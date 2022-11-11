-- Quick File Navigation
-- Repo: https://github.com/ggandor/leap.nvim

local M = {}

M.Details = function()
    return {
        "ggandor/leap.nvim",
        requires = {
            "ggandor/flit.nvim",
            "ggandor/leap-ast.nvim",
        },
        config = M.Setup,
    }
end

M.Setup = function()
    local leap = require("leap")
    local leap_ast = require("leap-ast")

    leap.setup({
        equivilence_classes = {
            " \t\r\n", -- space-like characters
            "([{", -- opening braces
            ")]}", -- closing braces
            "`\"'", -- quote-like characters
        },
    })

    -- Detault "s" (normal) and "x" (visual) keybinds
    leap.add_default_mappings()

    -- Add treesitter keybinds
    vim.keymap.set({ "n", "x", "o" }, "<c-s>", leap_ast.leap, { silent = true })

    -- Add smart "f/F" and "t/T" keybinds
    require("flit").setup()
end

return M
