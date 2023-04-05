return {
    -- add python to treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        opts = function(_, opts)
            table.insert(opts.ensure_installed, "python")
        end,
    },

    -- setup lspconfig for python
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                pyright = {},
            },
        },
    },

    -- setup ruff and black for python
    {
        "jose-elias-alvarez/null-ls.nvim",
        opts = function(_, opts)
            local null_ls = require("null-ls")
            opts.sources = vim.list_extend(opts.sources, {
                null_ls.builtins.diagnostics.ruff,
                null_ls.builtins.formatting.black,
            })
        end,
    },
}
