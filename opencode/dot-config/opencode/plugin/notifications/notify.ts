import { basename } from "path";
import notifier, { type NotificationCallback } from "node-notifier";

type NotificationInput = {
	directory: string;
	sessionId: string | null;
	title: string | null;
} & (
	| { kind: "permission" | "complete"; error?: never }
	| { kind: "error"; error: string }
);

type NotificationKind = NotificationInput["kind"];

const NOTIFICATION_TITLES = {
	permission: "OpenCode needs permission",
	complete: "OpenCode has finished",
	error: "OpenCode encountered an error",
} as const satisfies Record<NotificationKind, string>;

export const notify = (
	input: NotificationInput,
	callback?: NotificationCallback,
) => {
	notifier.notify(
		{
			title: NOTIFICATION_TITLES[input.kind],
			message: notificationBody(input),
			sound: true,
			wait: true,
		},
		callback,
	);
};

const notificationBody = (input: NotificationInput) => {
	if (input.title) return sanitizeText(input.title, 160);
	if (input.kind === "error") return sanitizeText(input.error, 160);

	const projectName = basename(input.directory);
	return projectName && projectName !== "/" ? projectName : "OpenCode";
};

const sanitizeText = (value: string, maxLength: number) => {
	const normalized = value.replaceAll(/\s+/g, " ").trim();

	return normalized.length <= maxLength
		? normalized
		: `${normalized.slice(0, Math.max(0, maxLength - 3))}...`;
};
