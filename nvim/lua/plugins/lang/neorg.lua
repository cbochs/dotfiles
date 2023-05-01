return {
    {
        "hrsh7th/nvim-cmp",
        opts = function(_, opts)
            local cmp = require("cmp")
            opts.sources = cmp.config.sources(vim.list_extend(opts.sources, { { name = "neorg" } }))
        end,
    },

    {
        "nvim-neorg/neorg",
        dependencies = { "nvim-lua/plenary.nvim" },
        ft = "norg",
        cmd = "Neorg",
        keys = {
            { "<leader>ni", "<cmd>Neorg index<cr>", desc = "Index" },
            { "<leader>nj", "<cmd>Neorg journal today<cr>", desc = "Journal" },
            { "<leader>nr", "<cmd>Neorg return<cr>", desc = "Return" },
            { "<leader>ns", "<cmd>Neorg sync-parsers<cr>", desc = "Sync parsers" },
        },
        opts = {
            load = {
                ["core.defaults"] = {}, -- Loads default behaviour
                ["core.concealer"] = {
                    config = {
                        dim_code_blocks = {
                            padding = { left = 4 },
                        },
                        icons = {
                            done = { icon = "x" },
                            pending = { icon = "-" },
                            undone = { icon = " " },
                            urgent = { icon = "!" },
                        },
                    },
                }, -- Adds pretty icons to your documents
                ["core.completion"] = {
                    config = { engine = "nvim-cmp" },
                },
                ["core.dirman"] = { -- Manages Neorg workspaces
                    config = {
                        default_workspace = "work",
                        workspaces = { work = "~/git_personal/notes" },
                    },
                },
            },
        },
    },
}
