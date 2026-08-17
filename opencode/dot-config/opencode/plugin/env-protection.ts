import type { Hooks, Plugin } from "@opencode-ai/plugin";

export const EnvProtection: Plugin = () =>
	Promise.resolve<Hooks>({
		"tool.execute.before": (input, output) => {
			if (input.tool === "bash" && hasProtectedEnvReference(output.args)) {
				throw new Error("Do not access protected .env files through Bash");
			}

			if (
			["edit", "glob", "grep", "read"].includes(input.tool) &&
			hasProtectedEnvReference(output.args)
		) {
				throw new Error("Do not read protected .env files");
			}
			return Promise.resolve();
		},
	});

const hasProtectedEnvReference = (args: unknown): boolean => {
	if (typeof args === "string") return containsProtectedEnvPath(args);
	if (!args || typeof args !== "object") return false;

	return Object.values(args).some((value) =>
		typeof value === "string" && containsProtectedEnvPath(value),
	);
};

const containsProtectedEnvPath = (value: string) =>
	/(?:^|[\s"'=/:])(?:[^\s"'=;|&]*[\\/])?\.env(?:\.[^\s"'=;|&]*)?(?=$|[\s"'=;|&])/.test(
		value,
	) &&
	!/(?:^|[\\/])\.env\.(?:sample|example)(?=$|[\s"'=;|&])/.test(value);
