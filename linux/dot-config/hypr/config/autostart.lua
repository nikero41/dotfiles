-- Run only on compositor startup, never during a configuration reload.
hl.on("hyprland.start", function()
    -- Make Wayland session variables available to D-Bus/systemd services before
    -- starting the graphical Polkit agent that needs that environment.
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP && systemctl --user start hyprpolkitagent.service")
    hl.exec_cmd("waybar")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("hyprsunset")
    hl.exec_cmd("swayosd-server")
    hl.exec_cmd("swaync")
    hl.exec_cmd("~/.local/bin/apply-desktop-defaults")
    hl.exec_cmd("gnome-keyring-daemon --start --components=secrets")
    hl.exec_cmd("vicinae server")
end)
