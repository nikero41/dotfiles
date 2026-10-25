import { Plugin } from "@opencode/plugin/tui";
import { Effect, Layer, ManagedRuntime, MutableHashMap, Option } from "effect";
import type { Session } from "@opencode/schema";

import { EventSuppress } from "./eventSuppression";
import { createNotification, type NotificationOptions } from "./notify";
import { Terminal } from "./terminal";
import { Mux, type MuxPane } from "./tmux.js";

export default Plugin.define({
	id: "nikero.notifications.cli",
	setup(context) {
		context.ui.toast.show({ message: "CLI plugin loaded", variant: "success" });
		if (process.platform !== "darwin") return;

		const layers = Layer.mergeAll(
			Terminal.layer,
			Mux.layer,
			EventSuppress.layer,
		);
		const runtime = ManagedRuntime.make(layers);

		const run = <A, E, R extends Layer.Success<typeof layers>>(
			effect: Effect.Effect<A, E, R>,
		) => {
			effect.pipe(
				Effect.catch(error => Effect.logWarning("Notification failed", error)),
				runtime.runFork,
			);
		};

		const sessionPanes = MutableHashMap.empty<Session.ID, MuxPane>();

		const notify = (sessionID: string, opts: NotificationOptions) =>
			Effect.gen(function* () {
				const terminal = yield* Terminal;
				const mux = yield* Mux;

				if (yield* terminal.isVisible) return;
				let info = context.data.session.get(sessionID);
				if (!info) {
					yield* Effect.tryPromise(() => context.data.session.sync(sessionID));
					info = context.data.session.get(sessionID);
				}
				if (!info) return;

				const { response } = yield* createNotification(info, opts);
				yield* sessionPanes.pipe(
					// TODO: check if its focused
					MutableHashMap.get(sessionID),
					Option.map(mux.focus),
					Effect.transposeOption,
					Effect.tap(terminal.focus),
					Effect.when(Effect.succeed(response === "activate")),
				);
			});

		const permissionStop = context.data.on(
			"permission.asked",
			({ data: { sessionID } }) =>
				run(notify(sessionID, { kind: "permission" })),
		);

		const errorStop = context.data.on(
			"session.execution.failed",
			({ data: { sessionID, error } }) =>
				run(
					EventSuppress.use(({ suppressNext }) =>
						suppressNext(sessionID).pipe(
							Effect.andThen(
								notify(sessionID, {
									kind: "error",
									error: error.message,
								}),
							),
						),
					),
				),
		);

		const idleStop = context.data.on(
			"session.idle",
			({ data: { sessionID } }) =>
				run(
					EventSuppress.use(({ allowNotification }) =>
						notify(sessionID, { kind: "complete" }).pipe(
							Effect.when(allowNotification(sessionID)),
						),
					),
				),
		);

		return async () => {
			permissionStop();
			errorStop();
			idleStop();
			await runtime.dispose();
		};
	},
});
