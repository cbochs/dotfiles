return {
    {
        "echasnovski/mini.bracketed",
        event = "VeryLazy",
        opts = {
            comment = { suffix = "k" },
            indent = { options = { change_type = "diff" } },

            -- Disable most bracket operations
            buffer = { suffix = "" },
            diagnostic = { suffix = "" },
            file = { suffix = "" },
            jump = { suffix = "" },
            oldfile = { suffix = "" },
            undo = { suffix = "" },
            window = { suffix = "" },
        },
        config = function(_, opts)
            require("mini.bracketed").setup(opts)
        end,
    },

    {
        "Wansmer/treesj",
        keys = {
            { "gj", "<cmd>TSJToggle<cr>", desc = "Split / Join" },
        },
        opts = { use_default_keymaps = false },
    },

    {
        "echasnovski/mini.trailspace",
        event = "VeryLazy",
        config = function(_, opts)
            require("mini.trailspace").setup(opts)
        end,
    },

    { -- Disable some keymaps in favour of mini.bracketed "indent"
        "echasnovski/mini.indentscope",
        opts = {
            mappings = {
                goto_top = "",
                goto_bottom = "",
            },
        },
    },

    { -- Disable some keymaps in favour of mini.bracketed "treesitter"
        "folke/todo-comments.nvim",
        keys = {
            { "]t", false },
            { "[t", false },
        },
    },
}
