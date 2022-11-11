-- Cursorline Highlighting
-- Repo: https://github.com/mvllow/modes.nvim

local M = {}

M.Details = function()
    return {
        "mvllow/modes.nvim",
        tag = "v0.2.0",
        after = {
            "catppuccin",
        },
        config = M.Setup,
    }
end

M.Setup = function()
    require("modes").setup({
        colors = {
            copy = "#f9e2af", -- catppuccin.yellow,
            delete = "#f38ba8", -- catppuccin.red,
            insert = "#a6e3a1", -- catppuccin.green,
            visual = "#cba6f7", -- catppuccin.mauve,
        },
    })
end

return M
