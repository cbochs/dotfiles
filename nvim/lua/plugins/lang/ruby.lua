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
                    cmd = { "asdf", "exec", "solargraph", "stdio" },
                },
                -- ruby_ls = {
                --     cmd = { "asdf", "exec", "ruby-lsp" },
                -- },
            },
        },
    },

    -- add "alternate" and "related" keybinds for Rails projects
    {
        "tpope/vim-rails",
        ft = "ruby",
        keys = {
            { "ga", "<cmd>A<cr>", desc = "Goto alternate file (Rails)" },
            { "gb", "<cmd>R<cr>", desc = "Goto related file (Rails)" },
        },
    },
}
