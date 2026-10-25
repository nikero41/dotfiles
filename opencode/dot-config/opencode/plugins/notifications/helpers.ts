import { type ExecException, execFile } from "node:child_process";
import { Effect } from "effect";

export const exec = (cmd: string, ...args: string[]) =>
	Effect.callback<string, ExecException>(resume => {
		execFile(
			cmd,
			args,
			{ timeout: 5000, killSignal: "SIGKILL" },
			(error, stdout) =>
				resume(error ? Effect.fail(error) : Effect.succeed(stdout)),
		);
	}).pipe(Effect.uninterruptible);
