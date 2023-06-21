return {
    {
        "echasnovski/mini.bracketed",
        event = { "BufReadPost", "BufNewFile" },
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
    },

    {
        "echasnovski/mini.trailspace",
        event = { "BufReadPost", "BufNewFile" },
        config = true,
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
}
