local environment = {
    XCURSOR_SIZE = "24",
    XCURSOR_THEME = "catppuccin-mocha-dark-cursors",
    HYPRCURSOR_SIZE = "24",
    HYPRCURSOR_THEME = "catppuccin-mocha-dark-cursors",
    ELECTRON_OZONE_PLATFORM_HINT = "wayland",
    SDL_VIDEODRIVER = "wayland",
    CLUTTER_BACKEND = "wayland",
    XDG_CURRENT_DESKTOP = "Hyprland",
    XDG_SESSION_TYPE = "wayland",
    XDG_SESSION_DESKTOP = "Hyprland",
    GDK_BACKEND = "wayland,x11,*",
    GTK_THEME = "catppuccin-mocha-blue-standard+default:dark",
    QT_QPA_PLATFORM = "wayland;xcb",
    QT_QPA_PLATFORMTHEME = "hyprqt6engine",
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1",
    QT_QUICK_CONTROLS_STYLE = "org.hyprland.style",
    QT_AUTO_SCREEN_SCALE_FACTOR = "1",
}

for name, value in pairs(environment) do
    hl.env(name, value)
end
