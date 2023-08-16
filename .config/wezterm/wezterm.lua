local wezterm = require('wezterm')
local act = wezterm.action
local config = {}

config.enable_wayland = false

config.color_scheme = 'GruvboxDark'
config.hide_tab_bar_if_only_one_tab = true

config.font_size = 10
config.font_rules = {
    {
        intensity = 'Bold',
        font = wezterm.font('JetBrains Mono', { weight = 'Bold' }),
    },
}
config.bold_brightens_ansi_colors = false

config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
}

config.inactive_pane_hsb = {
    saturation = 1,
    brightness = 0.97,
}

wezterm.on('gui-startup', function(cmd)
    local _, _, window = wezterm.mux.spawn_window(cmd or {})
    window:gui_window():maximize()
end)

config.keys = {
    {
        key = 'e',
        mods = 'ALT',
        action = act.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },
    {
        key = 'o',
        mods = 'ALT',
        action = act.SplitVertical { domain = 'CurrentPaneDomain' },
    },
    {
        key = 'h',
        mods = 'ALT',
        action = act.ActivatePaneDirection('Left'),
    },
    {
        key = 'l',
        mods = 'ALT',
        action = act.ActivatePaneDirection('Right'),
    },
    {
        key = 'k',
        mods = 'ALT',
        action = act.ActivatePaneDirection('Up'),
    },
    {
        key = 'j',
        mods = 'ALT',
        action = act.ActivatePaneDirection('Down'),
    },
    {
        key = 'H',
        mods = 'CTRL|SHIFT',
        action = act.AdjustPaneSize { 'Left', 5 },
    },
    {
        key = 'J',
        mods = 'CTRL|SHIFT',
        action = act.AdjustPaneSize { 'Down', 5 },
    },
    { key = 'K', mods = 'CTRL|SHIFT', action = act.AdjustPaneSize { 'Up', 5 } },
    {
        key = 'L',
        mods = 'CTRL|SHIFT',
        action = act.AdjustPaneSize { 'Right', 5 },
    },
    {
        key = 'F11',
        action = wezterm.action.ToggleFullScreen,
    },
}

return config
