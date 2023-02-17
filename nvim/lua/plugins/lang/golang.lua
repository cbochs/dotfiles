return {
    -- add golang to treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        opts = function(_, opts)
            table.insert(opts.ensure_installed, "go")
        end,
    },

    -- setup lspconfig for golang
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                gopls = {},
            },
        },
    },

    -- setup gofmt for golang
    {
        "jose-elias-alvarez/null-ls.nvim",
        opts = function(_, opts)
            local null_ls = require("null-ls")
            opts.sources = vim.list_extend(opts.sources, {
                null_ls.builtins.formatting.gofmt,
                -- null_ls.builtins.formatting.gofmt
            })
        end,
    },
}
