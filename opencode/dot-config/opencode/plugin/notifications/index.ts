import type { Plugin } from "@opencode-ai/plugin";
import type { OpencodeClient } from "@opencode-ai/sdk";

import { focusOpenCode, getTmuxTarget, isVisible } from "./actions.js";
import { EventSuppression } from "./eventSuppression.js";
import { notify } from "./notify.js";

const completionSuppression = new EventSuppression();

export const NotificationsPlugin: Plugin = ({ client, directory, $ }) => {
	if (
		process.platform !== "darwin" ||
		(process.env.OPENCODE_CLIENT && process.env.OPENCODE_CLIENT !== "cli")
	) {
		return Promise.resolve({});
	}

	return Promise.resolve({
		"permission.ask": async ({ title, sessionID }) => {
			const tmuxTarget = await getTmuxTarget($);
			if (await isVisible($, tmuxTarget)) return;
			notify(
				{ directory, kind: "permission", sessionId: sessionID, title },
				() => focusOpenCode($, tmuxTarget),
			);
		},
		event: async ({ event }) => {
			const now = Date.now();
			completionSuppression.cleanup(now);

			const tmuxTarget = await getTmuxTarget($);

			switch (event.type) {
				case "session.error": {
					if (event.properties.error?.name === "MessageAbortedError") return;

					const sessionId = event.properties.sessionID;
					if (sessionId) completionSuppression.suppressNext(sessionId, now);
					if (await isVisible($, tmuxTarget)) return;

					notify(
						{
							directory,
							error: event.properties.error?.data.message as string,
							kind: "error",
							sessionId: sessionId ?? null,
							title: sessionId ? await sessionTitle(client, sessionId) : null,
						},
						() => focusOpenCode($, tmuxTarget),
					);
					break;
				}

				case "session.idle": {
					const sessionId = event.properties.sessionID;
					if (completionSuppression.shouldSuppress(sessionId, now)) return;
					if (await isVisible($, tmuxTarget)) return;

					notify(
						{
							directory,
							kind: "complete",
							sessionId,
							title: await sessionTitle(client, sessionId),
						},
						() => focusOpenCode($, tmuxTarget),
					);
					break;
				}

				default: {
					break;
				}
			}
		},
	});
};

export default NotificationsPlugin;

const sessionTitle = async (client: OpencodeClient, sessionId: string) => {
	const response = await client.session
		.get({ path: { id: sessionId } })
		.catch(() => null);
	return response?.data?.title ?? null;
};
