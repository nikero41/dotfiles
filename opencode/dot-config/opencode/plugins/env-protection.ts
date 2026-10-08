import { Plugin } from "@opencode/plugin/effect";
import { Tool } from "@opencode/schema/tool";
import { Effect, Schema as S } from "effect";

export default Plugin.define({
	id: "env-protection",
	effect: ctx =>
		ctx.tool.hook("execute.before", ({ tool, input }) =>
			Effect.all([
				S.decodeUnknownEffect(ReadToolSchema)(tool),
				S.decodeUnknownEffect(ProtectedEnvSchema)(input),
			]).pipe(
				Effect.map(
					() => new Tool.Error(new Error("Do not read protected .env files")),
				),
				Effect.flip,
				Effect.asVoid,
			),
		),
});

const ReadToolSchema = S.Literals(["edit", "glob", "grep", "read", "shell"]);
const ProtectedEnvPathSchema = S.NonEmptyString.check(
	// [\s"'=/:\\] allows whitespace, quotes, =, or a path separator before .env.
	// [^\s"'=;|&/\\]* reads the filename suffix without consuming separators.
	// (?=$|[\s"'=;|&]) requires the filename to end before whitespace, quotes, shell operators, or the end of the string.
	S.isPattern(/(?:^|[/\\])\.env(?:\.(?!(?:example|sample)$)[^/\\]+)?$/),
);

const ProtectedEnvSchema = S.Union([
	ProtectedEnvPathSchema,
	S.Record(S.String, ProtectedEnvPathSchema),
]);
