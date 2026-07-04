import type { Hooks, Plugin } from "@opencode-ai/plugin";

export const EnvProtection: Plugin = () =>
	Promise.resolve<Hooks>({
		"tool.execute.before": (input, output) => {
			if (
				input.tool === "read" &&
				hasFilePath(output.args) &&
				output.args.filePath.includes(".env")
			) {
				throw new Error("Do not read .env files");
			}
			return Promise.resolve();
		},
	});

const hasFilePath = (args: unknown): args is { filePath: string } =>
	!!args &&
	typeof args === "object" &&
	"filePath" in args &&
	!args.filePath &&
	typeof args.filePath === "string";
