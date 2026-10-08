import { execFile, type ExecException } from "node:child_process";
import { Plugin } from "@opencode/plugin/effect";
import { Effect, Match, Option, Stream } from "effect";
import type { OpenCodeEvent } from "@opencode/protocol/groups/event";

export default Plugin.define({
	id: "nikero.worktrunk",
	effect: ({ event, location: { directory } }) =>
		Effect.gen(function* () {
			yield* Effect.addFinalizer(() => setMarker(directory, Option.none()));

			yield* event.subscribe().pipe(
				Stream.filter(event => event.location?.directory === directory),
				worktrunkMarker(directory),
				Effect.forkScoped,
				Effect.asVoid,
			);
		}),
});

const worktrunkMarker = (directory: string) =>
	Stream.runForEach(
		Match.type<OpenCodeEvent>().pipe(
			Match.whenOr(
				{ type: "session.idle" },
				{ type: "session.status", data: { status: { type: "idle" } } },
				() => setMarker(directory, Option.some("💬")),
			),
			Match.when({ type: "session.status" }, () =>
				setMarker(directory, Option.some("🤖")),
			),
			Match.when({ type: "session.deleted" }, () =>
				setMarker(directory, Option.none()),
			),
			Match.orElse(() => Effect.void),
		),
	);

const setMarker = (directory: string, marker: Option.Option<string>) =>
	Effect.callback<void, ExecException>(resume => {
		const cmd = Option.match(marker, {
			onSome: marker => ["set", marker],
			onNone: () => ["clear"],
		});
		execFile(
			"wt",
			["config", "state", "marker", ...cmd],
			{
				cwd: directory,
				timeout: 5000,
				killSignal: "SIGKILL",
			},
			error => resume(error ? Effect.fail(error) : Effect.void),
		);
	}).pipe(Effect.ignore, Effect.uninterruptible);
