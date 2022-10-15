-- Statusbar
-- Repo: https://github.com/nvim-lualine/lualine.nvim

local M = {}

M.Details = function()
    return {
        "nvim-lualine/lualine.nvim",
        after = {
            "catppuccin",
            "gitsigns.nvim",
        },
        config = M.Setup,
    }
end

M.Setup = function()
    require("lualine").setup({
        options = {
            theme = "catppuccin",
            globalstatus = true,
            component_separators = "",
            section_separators = "",
        },
        sections = {
            lualine_a = { "mode" },
            lualine_b = { "branch", "diff", "diagnostics"},
            lualine_c = {},
            lualine_x = {},
            lualine_y = { "filetype", "location" },
            lualine_z = { "filename" },
        },
        winbar = {}
    })
end

return M
