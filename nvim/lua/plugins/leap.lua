return {
    "ggandor/leap.nvim",
    keys = { "s", "S", "f", "F", "t", "T" },
    dependencies = {
        "ggandor/flit.nvim",
        "ggandor/leap-ast.nvim",
    },
    config = function()
        local leap = require("leap")
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
