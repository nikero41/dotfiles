hl.config({
    input = {
        kb_layout = "us,gr",
        kb_variant = "",
        kb_options = "ctrl:swapcaps",
        kb_model = "",
        kb_rules = "",
        follow_mouse = 1,
        sensitivity = 0,
        natural_scroll = true,
        touchpad = {
            natural_scroll = true,
        },
    },
    gestures = {
        -- Require a shorter swipe and accept it sooner.
        workspace_swipe_distance = 200,
        workspace_swipe_cancel_ratio = 0.35,
    },
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace",
})
