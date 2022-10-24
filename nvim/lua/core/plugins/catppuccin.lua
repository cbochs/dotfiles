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

    vim.g.catppuccin_flavour = "mocha"
    catppuccin.setup({
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
            telescope = true,
            treesitter = true,
        },
        custom_highlights = {
            Comment = { fg = colors.flamingo },
        }
    })
    vim.cmd("colorscheme catppuccin")
end

return M
