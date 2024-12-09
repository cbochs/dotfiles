return {
    {
        "nvim-neorg/neorg",
        dependencies = {
            "vhyrro/luarocks.nvim",
            priority = 1000,
            config = true,
        },
        version = "*", -- Pin Neorg to the latest stable release
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
                            -- show file contents as documentation when you complete a file name
                            documentation = true,
                            -- Try to complete categories. Requires benlubas/neorg-se
                            categories = false,
                        },
                    },
                },
            },
        },
    },
}
