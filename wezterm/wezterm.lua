local wezterm = require("wezterm")
local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

wezterm.on("format-tab-title", function(tab)
    if tab.tab_title and #tab.tab_title > 0 then
        return "  " .. tab.tab_title .. " "
    end
    return "  " .. tab.active_pane.title .. "  "
end)

config = {
    use_fancy_tab_bar = false,
    window_decorations = "RESIZE",

    leader = { key = "b", mods = "CTRL" },
    keys = {
        -- tmux
        { key = "\\", mods = "LEADER", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
        { key = "-", mods = "LEADER", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
        { key = "c", mods = "LEADER", action = wezterm.action.SpawnTab("CurrentPaneDomain") },
        { key = "z", mods = "LEADER", action = wezterm.action.TogglePaneZoomState },
        { key = "h", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Left") },
        { key = "j", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Down") },
        { key = "k", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Up") },
        { key = "l", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Right") },
        { key = "n", mods = "LEADER", action = wezterm.action.ActivateTabRelative(1) },
        { key = "p", mods = "LEADER", action = wezterm.action.ActivateTabRelative(-1) },
        { key = "x", mods = "LEADER", action = wezterm.action.CloseCurrentPane({ confirm = true }) },
        {
            key = ",",
            mods = "LEADER",
            action = wezterm.action.PromptInputLine({
                description = "Tab name",
                action = wezterm.action_callback(function(window, _, line)
                    if line then
                        window:active_tab():set_title(line)
                    end
                end),
            }),
        },
    },

    -- Theme: Kanagawa
    force_reverse_video_cursor = true,
    colors = {
        background = "#1f1f28",
        foreground = "#dcd7ba",

        tab_bar = {
            background = "#1f1f28",

            active_tab = {
                bg_color = "#2d4f67",
                fg_color = "#c8c093",
            },
            inactive_tab = {
                bg_color = "#1f1f28",
                fg_color = "#dcd7ba",
            },
            new_tab = {
                bg_color = "#1f1f28",
                fg_color = "#dcd7ba",
            },
        },

        cursor_bg = "#c8c093",
        cursor_fg = "#c8c093",
        cursor_border = "#c8c093",

        selection_fg = "#c8c093",
        selection_bg = "#2d4f67",

        scrollbar_thumb = "#16161d",
        split = "#16161d",

        ansi = { "#090618", "#c34043", "#76946a", "#c0a36e", "#7e9cd8", "#957fb8", "#6a9589", "#c8c093" },
        brights = { "#727169", "#e82424", "#98bb6c", "#e6c384", "#7fb4ca", "#938aa9", "#7aa89f", "#dcd7ba" },
        indexed = { [16] = "#ffa066", [17] = "#ff5d62" },
    },
}

return config
