import { Config, Context, Data, Effect, Layer } from "effect";

import { exec } from "./helpers";

export class MuxPane extends Data.TaggedClass("MuxPane")<{
	paneId: string;
	sessionId: string;
	windowId: string;
}> {}

export class Mux extends Context.Service<Mux>()("Mux", {
	make: Effect.sync(() => {
		const currentPane = tmuxCmd(
			"display-message",
			"-p",
			"#{session_id},#{window_id},#{pane_id}",
		).pipe(
			Effect.tapError(error =>
				Effect.logWarning("Failed to get tmux pane", error),
			),
			Effect.map(output => output.trim().split(",")),
			Effect.map(
				([sessionId, windowId, paneId]) =>
					new MuxPane({ paneId, sessionId, windowId }),
			),
			Effect.option,
		);

		return {
			current: currentPane,

			// isVisible: currentPane.pipe(
			// 	Effect.map(Option.map(Equal.equals(this))),
			// 	Effect.map(Option.getOrElse(() => false)),
			// ),

			focus: ({ sessionId, windowId, paneId }: MuxPane) =>
				Effect.all([
					tmuxCmd("switch-client", "-t", sessionId),
					tmuxCmd("select-window", "-t", windowId),
					tmuxCmd("select-pane", "-t", paneId),
				]).pipe(
					Effect.tapError(error =>
						Effect.logWarning("Failed to focus tmux pane", error),
					),
					Effect.asVoid,
				),
		};
	}),
}) {
	static readonly layer = Layer.effect(this, this.make);
}

const tmuxCmd = (...args: string[]) =>
	Config.string("TMUX").pipe(
		Config.map(config => config.split(",")),
		Config.map(config => config[0]),
		Effect.flatMap(socket => exec("tmux", "-S", socket, ...args)),
	);
