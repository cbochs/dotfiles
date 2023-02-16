return {

    -- add markdown to treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        opts = function(_, opts)
            table.insert(opts.ensure_installed, "markdown")
        end,
    },

    -- setup lspconfig for markdown
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                marksman = {},
            },
        },
    },
}
