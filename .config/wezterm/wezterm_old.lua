local wezterm = require("wezterm")
local act = wezterm.action
local config = {}

config.enable_wayland = true

config.color_scheme = "GruvboxDark"
config.hide_tab_bar_if_only_one_tab = true

config.font_size = 13

-- config.font = wezterm.font { -- Normal text
--     family = "Monaspace Neon",
--     harfbuzz_features = { "calt", "liga", "dlig", "ss01", "ss02", "ss03", "ss04", "ss05", "ss06", "ss07", "ss08" },
--     stretch = "UltraCondensed", -- This doesn't seem to do anything
-- }

config.font = wezterm.font_with_fallback {
    {
        family = "Monaspace Neon",
        weight = "Regular",
        harfbuzz_features = { "calt", "liga", "dlig", "ss01", "ss02", "ss03", "ss04", "ss05", "ss06", "ss07", "ss08" },
    },
    "JetBrains Mono",
    "Noto Color Emoji",
    "Material Design Icons",
}

-- config.font_rules = {
--     {
--         intensity = "Normal",
--         italic = false,
--         font = wezterm.font_with_fallback {
--             weight = "Light",
--             "Monaspace Neon",
--             "JetBrains Mono",
--             "Noto Color Emoji",
--             "Material Design Icons",
--         },
--     },
-- }
config.window_padding = {}

config.inactive_pane_hsb = {
    saturation = 1,
    brightness = 0.97,
}

wezterm.on("gui-startup", function(cmd)
    local _, _, window = wezterm.mux.spawn_window(cmd or {})
    window:gui_window():maximize()
end)

config.keys = {
    {
        key = "e",
        mods = "ALT",
        action = act.SplitHorizontal { domain = "CurrentPaneDomain" },
    },
    {
        key = "o",
        mods = "ALT",
        action = act.SplitVertical { domain = "CurrentPaneDomain" },
    },
    {
        key = "h",
        mods = "ALT",
        action = act.ActivatePaneDirection("Left"),
    },
    {
        key = "l",
        mods = "ALT",
        action = act.ActivatePaneDirection("Right"),
    },
    {
        key = "k",
        mods = "ALT",
        action = act.ActivatePaneDirection("Up"),
    },
    {
        key = "j",
        mods = "ALT",
        action = act.ActivatePaneDirection("Down"),
    },
    {
        key = "H",
        mods = "CTRL|SHIFT",
        action = act.AdjustPaneSize { "Left", 5 },
    },
    {
        key = "J",
        mods = "CTRL|SHIFT",
        action = act.AdjustPaneSize { "Down", 5 },
    },
    { key = "K", mods = "CTRL|SHIFT", action = act.AdjustPaneSize { "Up", 5 } },
    {
        key = "L",
        mods = "CTRL|SHIFT",
        action = act.AdjustPaneSize { "Right", 5 },
    },
    {
        key = "F11",
        action = wezterm.action.ToggleFullScreen,
    },
}
config.audible_bell = "Disabled"
config.warn_about_missing_glyphs = false
return config
