return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = function(_, opts)
            vim.list_extend(opts.ensure_installed, {
                "ruby",
            })
        end,
    },

    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                ruby_ls = {},
            },
        },
    },

    {
        "mfussenegger/nvim-dap",
        optional = true,
        dependencies = {
            "suketa/nvim-dap-ruby",
            config = function()
                require("dap-ruby").setup()
            end,
        },
    },

    {
        "nvim-neotest/neotest",
        optional = true,
        dependencies = {
            "olimorris/neotest-rspec",
        },
        opts = {
            adapters = {
                ["neotest-rspec"] = {
                    -- NOTE: By default neotest-rspec uses the system wide rspec gem instead of the one through bundler
                    rspec_cmd = function()
                        return { "docker", "compose", "exec", "portal", "bin/rspec" }
                    end,
                },
            },
        },
    },
}