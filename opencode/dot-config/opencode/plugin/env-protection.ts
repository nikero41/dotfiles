import type { Hooks, Plugin } from "@opencode-ai/plugin";

export const EnvProtection: Plugin = () =>
	Promise.resolve<Hooks>({
		"tool.execute.before": (input, output) => {
			if (
				input.tool === "read" &&
				hasFilePath(output.args) &&
				isProtectedEnvFile(output.args.filePath)
			) {
				throw new Error("Do not read protected .env files");
			}
			return Promise.resolve();
		},
	});

const hasFilePath = (args: unknown): args is { filePath: string } =>
	!!args &&
	typeof args === "object" &&
	"filePath" in args &&
	typeof args.filePath === "string";

const isProtectedEnvFile = (filePath: string) =>
	!/(?:^|[\\/])\.env\.(?:sample|example)$/.test(filePath) &&
	/(?:^|[\\/])\.env(?:\.[^/\\]*)?$/.test(filePath);
