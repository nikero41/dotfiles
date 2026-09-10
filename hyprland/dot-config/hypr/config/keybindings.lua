local applications = require("config.applications")

local main_mod = "SUPER"
local window_mod = "ALT"

local function bind(keys, dispatcher, options)
    hl.bind(keys, dispatcher, options)
end

bind(main_mod .. " + T", hl.dsp.exec_cmd(applications.terminal), {
    description = "Open terminal",
})
bind(main_mod .. " + Q", hl.dsp.window.close(), { description = "Close active window" })
bind(main_mod .. " + E", hl.dsp.exec_cmd(applications.file_manager), {
    description = "Open file manager",
})
bind(main_mod .. " + V", hl.dsp.window.float({ action = "toggle" }), { description = "Toggle floating" })
bind(main_mod .. " + space", hl.dsp.exec_cmd(applications.launcher), {
    description = "Open launcher",
})
bind(main_mod .. " + SHIFT + space", hl.dsp.exec_cmd(applications.launcher_fallback), {
    description = "Open fallback application launcher",
})
bind(main_mod .. " + P", hl.dsp.window.pseudo(), { description = "Toggle pseudotiling" })
bind(main_mod .. " + J", hl.dsp.layout("togglesplit"), { description = "Toggle Dwindle split" })
bind(main_mod .. " + RETURN", hl.dsp.window.fullscreen({ mode = "maximized" }), {
    description = "Toggle maximized",
})

bind(main_mod .. " + CTRL + h", hl.dsp.focus({ workspace = "-1" }), { description = "Previous workspace" })
bind(main_mod .. " + CTRL + l", hl.dsp.focus({ workspace = "+1" }), { description = "Next workspace" })

bind(window_mod .. " + h", hl.dsp.focus({ direction = "l" }), { description = "Focus left" })
bind(window_mod .. " + j", hl.dsp.focus({ direction = "d" }), { description = "Focus down" })
bind(window_mod .. " + k", hl.dsp.focus({ direction = "u" }), { description = "Focus up" })
bind(window_mod .. " + l", hl.dsp.focus({ direction = "r" }), { description = "Focus right" })
bind(window_mod .. " + semicolon", hl.dsp.window.float({ action = "toggle" }), {
    description = "Toggle floating",
})

local workspace_keys = { "T", "A", "S", "4", "5", "6", "7", "8", "9", "0" }
for workspace, key in ipairs(workspace_keys) do
    bind(window_mod .. " + " .. key, hl.dsp.focus({ workspace = workspace }), {
        description = "Switch to workspace " .. workspace,
    })
    bind(window_mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = workspace }), {
        description = "Move active window to workspace " .. workspace,
    })
end

bind(main_mod .. " + CTRL + SHIFT + h", hl.dsp.window.move({ workspace = "-1" }), {
    description = "Move window to previous workspace",
})
bind(main_mod .. " + CTRL + SHIFT + l", hl.dsp.window.move({ workspace = "+1" }), {
    description = "Move window to next workspace",
})

bind(main_mod .. " + S", hl.dsp.workspace.toggle_special("magic"), { description = "Toggle special workspace" })
bind(main_mod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }), {
    description = "Move window to special workspace",
})

bind(main_mod .. " + L", hl.dsp.exec_cmd("loginctl lock-session"), {
    description = "Lock session",
})
bind(main_mod .. " + ESCAPE", hl.dsp.exec_cmd("wlogout"), {
    description = "Open power menu",
})
bind(main_mod .. " + CTRL + comma", hl.dsp.exec_cmd("swaync-client -d"), {
    description = "Toggle do not disturb",
})
bind(main_mod .. " + CTRL + V", hl.dsp.exec_cmd("vicinae vicinae://launch/clipboard/history"), {
    description = "Open clipboard history",
})
bind(main_mod .. " + SHIFT + A", hl.dsp.exec_cmd(applications.audio_mixer), {
    description = "Open audio mixer",
})
bind(main_mod .. " + SHIFT + P", hl.dsp.exec_cmd(applications.printer_settings), {
    description = "Open printer settings",
})
bind(main_mod .. " + SHIFT + T", hl.dsp.exec_cmd(applications.tlp_settings), {
    description = "Open power settings",
})
bind(main_mod .. " + SHIFT + X", hl.dsp.exec_cmd(applications.local_send), {
    description = "Open LocalSend",
})

bind("PRINT", hl.dsp.exec_cmd("sh ~/.config/hypr/scripts/screenshot.sh region"), {
    description = "Screenshot region",
})
bind("SHIFT + PRINT", hl.dsp.exec_cmd("sh ~/.config/hypr/scripts/screenshot.sh window"), {
    description = "Screenshot active window",
})
bind("CTRL + PRINT", hl.dsp.exec_cmd("sh ~/.config/hypr/scripts/screenshot.sh output"), {
    description = "Screenshot output",
})
bind(main_mod .. " + SHIFT + PRINT", hl.dsp.exec_cmd("sh ~/.config/hypr/scripts/screenshot.sh edit"), {
    description = "Screenshot region with annotation",
})
bind("ALT + PRINT", hl.dsp.exec_cmd("sh ~/.config/hypr/scripts/record.sh"), {
    description = "Start or stop region recording",
})
bind(main_mod .. " + PRINT", hl.dsp.exec_cmd("hyprpicker --autocopy"), {
    description = "Pick color",
})

bind(main_mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }), { description = "Next open workspace" })
bind(main_mod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }), { description = "Previous open workspace" })

bind(main_mod .. " + mouse:272", hl.dsp.window.drag(), {
    mouse = true,
    description = "Move window",
})
bind(main_mod .. " + mouse:273", hl.dsp.window.resize(), {
    mouse = true,
    description = "Resize window",
})

bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("swayosd-client --output-volume raise"), {
    locked = true,
    repeating = true,
    description = "Raise volume",
})
bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("swayosd-client --output-volume lower"), {
    locked = true,
    repeating = true,
    description = "Lower volume",
})
bind("XF86AudioMute", hl.dsp.exec_cmd("swayosd-client --output-volume mute-toggle"), {
    locked = true,
    description = "Toggle audio mute",
})
bind("Caps_Lock", hl.dsp.exec_cmd("swayosd-client --caps-lock"), {
    release = true,
    description = "Show Caps Lock state",
})
bind("XF86AudioMicMute", hl.dsp.exec_cmd("sh ~/.config/hypr/scripts/toggle-mic.sh"), {
    locked = true,
    description = "Toggle microphone mute",
})
bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("swayosd-client --brightness raise --device intel_backlight"), {
    locked = true,
    repeating = true,
    description = "Raise brightness",
})
bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("swayosd-client --brightness lower --device intel_backlight"), {
    locked = true,
    repeating = true,
    description = "Lower brightness",
})

bind("XF86AudioNext", hl.dsp.exec_cmd("swayosd-client --playerctl next"), { locked = true, description = "Next track" })
bind("XF86AudioPause", hl.dsp.exec_cmd("swayosd-client --playerctl play-pause"), { locked = true, description = "Play or pause" })
bind("XF86AudioPlay", hl.dsp.exec_cmd("swayosd-client --playerctl play-pause"), { locked = true, description = "Play or pause" })
bind("XF86AudioPrev", hl.dsp.exec_cmd("swayosd-client --playerctl previous"), { locked = true, description = "Previous track" })

bind("CTRL + " .. main_mod .. " + space", hl.dsp.exec_cmd("hyprctl switchxkblayout all next"), {
    description = "Switch keyboard layout",
})
bind("CTRL + ALT + space", hl.dsp.exec_cmd("rofi -modi emoji -show emoji -emoji-format '{emoji}' -kb-secondary-copy '' -kb-custom-1 Ctrl+c"), {
    description = "Open emoji picker",
})
