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
        ft = "norg",
        {
            "nvim-neorg/neorg",
            dependencies = { { "nvim-lua/plenary.nvim" } },
            build = ":Neorg sync-parsers",
            opts = {
                load = {
                    ["core.defaults"] = {}, -- Loads default behaviour
                    ["core.norg.concealer"] = {}, -- Adds pretty icons to your documents
                    -- ["core.norg.completion"] = {
                    --     config = {
                    --         engine = { "nvim-cmp" },
                    --     },
                    -- },
                    -- ["core.integrations.nvim-cmp"] = {},
                    ["core.norg.dirman"] = { -- Manages Neorg workspaces
                        config = {
                            workspaces = {
                                work = "~/git_personal/notes",
                            },
                        },
                    },
                },
            },
        },
    },
}