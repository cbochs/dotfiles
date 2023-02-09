return {
    "simrat39/rust-tools.nvim",
    lazy = true,
    setup = function(options)
        require("rust-tools").setup({
            server = {
                on_attach = options.on_attach,
            },
        })
    end,
}
