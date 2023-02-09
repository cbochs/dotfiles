return {
    "jose-elias-alvarez/null-ls.nvim",
    lazy = true,
    setup = function(options)
        local null_ls = require("null-ls")
        null_ls.setup({
            debounce = 150,
            save_after_format = false,
            sources = {
                null_ls.builtins.diagnostics.luacheck.with({
                    cwd = function(params)
                        return require("null-ls.utils").root_pattern(".luacheckrc")(params.bufname)
                    end,
                }),
                null_ls.builtins.diagnostics.ruff,
                -- null_ls.builtins.diagnostics.spectral,
                null_ls.builtins.formatting.black,
                null_ls.builtins.formatting.stylua,
                null_ls.builtins.formatting.usort,
                -- null_ls.builtins.formatting.shfmt,
            },
            on_attach = options.on_attach,
        })
    end,
}
