-- HyprExpo is optional and ABI-sensitive. Keep failures isolated so an outdated
-- plugin never prevents the rest of the compositor configuration from loading.
pcall(function()
    hl.config({
        plugin = {
            hyprexpo = {
                columns = 3,
                gaps_in = 5,
                gaps_out = 0,
                bg_col = "rgb(111111)",
                workspace_method = "center current",
                gesture_distance = 200,
                cancel_key = "escape",
                show_cursor = 1,
            },
        },
    })

    hl.bind("SUPER + TAB", function()
        hl.plugin.hyprexpo.expo("toggle")
    end, { description = "Toggle workspace overview" })
end)
