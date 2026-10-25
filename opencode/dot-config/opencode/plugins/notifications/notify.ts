import { basename } from "path";
import { Effect } from "effect";
import notifier, { type NotificationMetadata } from "node-notifier";
import type { SessionInfo } from "@opencode/client";

export type NotificationOptions =
	| { kind: "permission" | "complete"; error?: never }
	| { kind: "error"; error: string };

export type NotificationKind = NotificationOptions["kind"];

const NOTIFICATION_TITLES = {
	permission: "OpenCode needs permission",
	complete: "OpenCode has finished",
	error: "OpenCode encountered an error",
} as const satisfies Record<NotificationKind, string>;

export function createNotification(
	session: SessionInfo,
	opts: NotificationOptions,
) {
	return Effect.callback<
		{ response: string; metadata: NotificationMetadata | undefined },
		Error
	>(resume => {
		let message = basename(session.location.directory);
		if (session.title) message = session.title;
		if (opts.kind === "error") message = `${message}: ${opts.error}`;

		notifier.notify(
			{
				title: NOTIFICATION_TITLES[opts.kind],
				message: sanitizeText(message),
				sound: true,
				wait: true,
			},
			(error, response, metadata) => {
				if (error) resume(Effect.fail(error));
				else resume(Effect.succeed({ response, metadata }));
			},
		);
	});
}

const sanitizeText = (value: string) => {
	const normalized = value.replaceAll(/\s+/g, " ").trim();

	return normalized.length <= 160
		? normalized
		: `${normalized.slice(0, Math.max(0, 160 - 3))}...`;
};
