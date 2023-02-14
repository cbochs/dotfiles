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
            },
        },
    },

    -- add "alternate" and "related" keybinds for Rails projects
    {
        "tpope/vim-rails",
        ft = "ruby",
        keys = {
            { "gA", "<cmd>AV<cr>", desc = "Goto alternate file (Rails)" },
            { "gR", "<cmd>RV<cr>", desc = "Goto related file (Rails)" },
        },
    },
}
