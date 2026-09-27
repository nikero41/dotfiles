import type { Plugin } from "@opencode-ai/plugin";

export const WorktrunkPlugin: Plugin = ({ $, directory }) =>
	Promise.resolve({
		event: async ({ event }) => {
			switch (event.type) {
				case "session.status": {
					await $`wt config state marker set ${"🤖"} || true`
						.cwd(directory)
						.quiet();
					break;
				}
				case "session.idle": {
					await $`wt config state marker set ${"💬"} || true`
						.cwd(directory)
						.quiet();
					break;
				}
				case "session.deleted": {
					await $`wt config state marker clear || true`.cwd(directory).quiet();
					break;
				}
				default:
			}
		},
	});
