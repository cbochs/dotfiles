-- Color Theme
-- Repo: https://github.com/catppuccin/catppuccin

local M = {}

M.Details = function()
    return {
        "catppuccin/nvim",
        as = "catppuccin",
        run = ":CatppuccinCompile",
        config = M.Setup,
    }
end

M.Setup = function()
    local catppuccin = require("catppuccin")
    local colors = require("catppuccin.palettes").get_palette()

    catppuccin.setup({
        flavour = "mocha",
        term_colors = true,
        dim_inactive = {
            enabled = true,
        },
        compile = {
            enabled = true,
        },
        integrations = {
            cmp = true,
            gitsigns = true,
            leap = true,
            noice = true,
            telescope = true,
            treesitter = true,
        },
        color_overrides = {
            -- mocha = {
            --     base = "#11111B",
            -- },
        },
        custom_highlights = {
            Comment = { fg = colors.flamingo },
        },
    })

    vim.cmd.colorscheme("catppuccin")
end

return M
