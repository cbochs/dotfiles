-- Repo: https://github.com/ggandor/leap.nvim
-- Description: Quick buffer movement

return {
    "ggandor/leap.nvim",
    requires = {
        "ggandor/flit.nvim",
        "ggandor/leap-ast.nvim",
    },
    config = function()
        local ok, leap = pcall(require, "leap")
        if not ok then
            return
        end

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
        local leap_ast = require("leap-ast")
        vim.keymap.set({ "n", "x", "o" }, "<c-s>", leap_ast.leap, { silent = true })

        -- Add smart "f/F" and "t/T" keybinds
        require("flit").setup()
    end,
}
