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
                ruby_lsp = { mason = false },
            },
        },
    },
}
