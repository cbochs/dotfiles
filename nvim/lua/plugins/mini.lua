return {
    { -- Disable some keymaps in favour of mini.bracketed
        "folke/todo-comments.nvim",
        keys = {
            { "]t", false },
            { "[t", false },
        },
    },

    {
        "echasnovski/mini.bracketed",
        event = "VeryLazy",
        opts = {
            comment = { suffix = "k" },
            indent = { options = { change_type = "diff" } },

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

    { -- Disable some keymaps in favour of mini.bracketed
        "echasnovski/mini.indentscope",
        opts = {
            mappings = {
                goto_top = "",
                goto_bottom = "",
            },
        },
    },

    { -- Disable in preference of nvim-surround
        "echasnovski/mini.indentscope",
        enabled = false,
    },

    {
        "echasnovski/mini.trailspace",
        event = "VeryLazy",
        config = function(_, opts)
            require("mini.trailspace").setup(opts)
        end,
    },
}
