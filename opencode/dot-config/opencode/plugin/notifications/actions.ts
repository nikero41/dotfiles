import type { PluginInput } from "@opencode-ai/plugin";

type Shell = PluginInput["$"];

interface TmuxTarget {
	paneId: string;
	sessionId: string;
	windowId: string;
}

const focusTerminal = async ($: Shell) => {
	await $`osascript -e 'tell application "Ghostty" to activate'`.quiet();
};

export const getTmuxTarget = async ($: Shell) => {
	const tmuxSocket = process.env.TMUX?.split(",")[0] ?? null;
	if (!tmuxSocket) return;

	const [sessionId, windowId, paneId] =
		await $`tmux -S ${tmuxSocket} display-message -p '#{session_id},#{window_id},#{pane_id}'`
			.quiet()
			.then(output => output.text().trim().split(","));

	return {
		paneId,
		sessionId,
		windowId,
	};
};

const focusTmuxPane = async ($: Shell, target: TmuxTarget) => {
	const tmuxSocket = process.env.TMUX?.split(",")[0] ?? null;
	if (!tmuxSocket) return null;

	await $`tmux -S ${tmuxSocket} switch-client -t ${target.sessionId}`.quiet();
	await $`tmux -S ${tmuxSocket} select-window -t ${target.windowId}`.quiet();
	await $`tmux -S ${tmuxSocket} select-pane -t ${target.paneId}`.quiet();
};

export const focusOpenCode = async ($: Shell, target?: TmuxTarget) => {
	await focusTerminal($);
	if (target) await focusTmuxPane($, target);
};

export const isVisible = async ($: Shell, target?: TmuxTarget) => {
	const frontmostApp =
		await $`osascript -e 'tell application "System Events" to get name of first application process whose frontmost is true'`
			.quiet()
			.then(output => output.text().trim())
			.catch(() => null);

	const isGhostty = frontmostApp?.toLowerCase() === "ghostty";

	const tmuxSocket = process.env.TMUX?.split(",")[0] ?? null;
	if (!tmuxSocket || !target) return isGhostty;

	const [sessionId, windowId] =
		await $`tmux -S ${tmuxSocket} display-message -p '#{session_id},#{window_id},#{pane_id}'`
			.quiet()
			.then(output => output.text().trim().split(","))
			.catch(() => []);

	return (
		isGhostty && sessionId === target.sessionId && windowId === target.windowId
	);
};
