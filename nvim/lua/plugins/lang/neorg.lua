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
        keys = {
            { "<leader>nr", "<cmd>Neorg return<cr>", desc = "Return" },
            { "<leader>ni", "<cmd>Neorg index<cr>", desc = "Index" },
        },
        opts = {
            load = {
                ["core.defaults"] = {}, -- Loads default behaviour
                ["core.norg.concealer"] = {}, -- Adds pretty icons to your documents
                -- ["core.norg.completion"] = {
                --     config = {
                --         engine = { "nvim-cmp" },
                --     },
                -- },
                ["core.norg.dirman"] = { -- Manages Neorg workspaces
                    config = {
                        default_workspace = "work",
                        workspaces = {
                            work = "~/git_personal/notes",
                        },
                    },
                },
            },
        },
    },
}
