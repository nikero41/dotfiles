local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.color_scheme = "Catppuccin Mocha"

config.font = wezterm.font("JetBrainsMono Nerd Font Med")
config.font_size = 13
config.line_height = 1.4
config.term = "wezterm"

config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.87
config.macos_window_background_blur = 20
config.native_macos_fullscreen_mode = true
config.hide_mouse_cursor_when_typing = true
config.mouse_wheel_scrolls_lines = 2
config.default_cursor_style = "SteadyBlock"

config.window_padding = {
	left = 0,
	right = 0,
	top = 2,
	bottom = 4,
}

config.inactive_pane_hsb = { brightness = 0.6 }
config.max_fps = 120

config.use_dead_keys = false
config.scrollback_lines = 5000
config.show_update_window = true

config.window_frame = { font_size = 12.0 }

config.leader = { key = "s", mods = "CMD", timeout_milliseconds = 1000 }

wezterm.on(
	"window-config-reloaded",
	function(window) window:toast_notification("wezterm", "Configuration reloaded!", nil, 4000) end
)

config.keys = {
	{
		key = "d",
		mods = "CMD|SHIFT",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "d",
		mods = "CMD",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	-- Move Splits left and right
	{
		key = "J",
		mods = "CMD|SHIFT",
		action = wezterm.action.ActivatePaneDirection("Down"),
	},
	{
		key = "K",
		mods = "CMD|SHIFT",
		action = wezterm.action.ActivatePaneDirection("Up"),
	},
	{
		key = "H",
		mods = "CMD|SHIFT",
		action = wezterm.action.ActivatePaneDirection("Left"),
	},
	{
		key = "L",
		mods = "CMD|SHIFT",
		action = wezterm.action.ActivatePaneDirection("Right"),
	},
	-- Ghostty-compatible shortcut aliases. Existing WezTerm shortcuts remain available.
	{
		key = "R",
		mods = "LEADER|SHIFT",
		action = wezterm.action.ReloadConfiguration,
	},
	{
		key = "x",
		mods = "LEADER",
		action = wezterm.action.CloseCurrentTab({ confirm = false }),
	},
	{
		key = "c",
		mods = "LEADER",
		action = wezterm.action.SpawnTab("CurrentPaneDomain"),
	},
	{
		key = "n",
		mods = "LEADER",
		action = wezterm.action.ActivateTabRelative(1),
	},
	{
		key = "p",
		mods = "LEADER",
		action = wezterm.action.ActivateTabRelative(-1),
	},
	{
		key = ",",
		mods = "LEADER|SHIFT",
		action = wezterm.action.MoveTabRelative(-1),
	},
	{
		key = ".",
		mods = "LEADER|SHIFT",
		action = wezterm.action.MoveTabRelative(1),
	},
	{
		key = "1",
		mods = "LEADER",
		action = wezterm.action.ActivateTab(0),
	},
	{
		key = "2",
		mods = "LEADER",
		action = wezterm.action.ActivateTab(1),
	},
	{
		key = "3",
		mods = "LEADER",
		action = wezterm.action.ActivateTab(2),
	},
	{
		key = "4",
		mods = "LEADER",
		action = wezterm.action.ActivateTab(3),
	},
	{
		key = "5",
		mods = "LEADER",
		action = wezterm.action.ActivateTab(4),
	},
	{
		key = "6",
		mods = "LEADER",
		action = wezterm.action.ActivateTab(5),
	},
	{
		key = "7",
		mods = "LEADER",
		action = wezterm.action.ActivateTab(6),
	},
	{
		key = "8",
		mods = "LEADER",
		action = wezterm.action.ActivateTab(7),
	},
	{
		key = "9",
		mods = "LEADER",
		action = wezterm.action.ActivateTab(8),
	},
	{
		key = "s",
		mods = "LEADER",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "v",
		mods = "LEADER",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "j",
		mods = "LEADER",
		action = wezterm.action.ActivatePaneDirection("Down"),
	},
	{
		key = "k",
		mods = "LEADER",
		action = wezterm.action.ActivatePaneDirection("Up"),
	},
	{
		key = "h",
		mods = "LEADER",
		action = wezterm.action.ActivatePaneDirection("Left"),
	},
	{
		key = "l",
		mods = "LEADER",
		action = wezterm.action.ActivatePaneDirection("Right"),
	},
	{
		key = "z",
		mods = "LEADER",
		action = wezterm.action.TogglePaneZoomState,
	},
}

config.mouse_bindings = {
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "CMD",
		action = wezterm.action.OpenLinkAtMouseCursor,
	},
}

return config
