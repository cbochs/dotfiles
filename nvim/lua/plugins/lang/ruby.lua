return {

    -- add ruby to treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        opts = function(_, opts)
            table.insert(opts.ensure_installed, "ruby")
        end,
    },

    -- setup lspconfig for Ruby
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                solargraph = {
                    mason = false,
                    initializationOptions = {
                        autoformat = true,
                        diagnostics = true,
                        formatting = true,
                    },
                },
            },
        },
    },
}
