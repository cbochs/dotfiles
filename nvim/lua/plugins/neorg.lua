return {
    {
        "nvim-neorg/neorg",
        dependencies = {
            "benlubas/neorg-interim-ls",
        },
        version = "*", -- Pin Neorg to the latest stable release
        ft = "norg",
        cmd = "Neorg",
        keys = {
            -- <Plug>(neorg.keybind-name)
            { "<leader>ni", "<Plug>(neorg.index)", desc = "Index" },
            { "<leader>nj", "<Plug>(neorg.journal.today)", desc = "Journal" },
            { "<leader>nr", "<Plug>(neorg.return)", desc = "Return" },
            { "<leader>ns", "<Plug>(neorg.sync)", desc = "Sync parsers" },
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
                            todo = {
                                done = { icon = "x" },
                                pending = { icon = "-" },
                                undone = { icon = " " },
                                urgent = { icon = "!" },
                            },
                        },
                    },
                }, -- Adds pretty icons to your documents
                ["core.completion"] = {
                    config = {
                        engine = {
                            module_name = "external.lsp-completion",
                        },
                    },
                },
                ["core.dirman"] = { -- Manages Neorg workspaces
                    config = {
                        default_workspace = "work",
                        workspaces = { work = "~/git_personal/notes" },
                    },
                },
                ["external.interim-ls"] = {
                    config = {
                        completion_provider = {
                            enable = true,
                            documentation = true,
                            categories = false,
                        },
                    },
                },
            },
        },
    },
}
