import { Context, Effect, Equal, Layer } from "effect";

import { exec } from "./helpers";

export class Terminal extends Context.Service<Terminal>()("Terminal", {
	make: Effect.gen(function* () {
		const appName = yield* terminalAppName;

		return {
			isVisible: exec(
				"osascript",
				"-e",
				'tell application "System Events" to get name of first application process whose frontmost is true',
			).pipe(
				Effect.tapError(error =>
					Effect.logWarning("Failed to get frontmost app", error),
				),
				Effect.map(output => output.trim().toLowerCase()),
				Effect.map(Equal.equals(appName.toLowerCase())),
			),

			focus: exec(
				"osascript",
				"-e",
				`tell application "${appName}" to activate`,
			).pipe(
				Effect.tapError(error =>
					Effect.logWarning("Failed to focus OpenCode", error),
				),
			),
		};
	}),
}) {
	static readonly layer = Layer.effect(this, this.make);
}

const terminalAppName = Effect.succeed("Ghostty");
