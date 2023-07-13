return {
    -- override: setup black for python
    {
        "jose-elias-alvarez/null-ls.nvim",
        opts = function(_, opts)
            local null_ls = require("null-ls")
            opts.sources = vim.list_extend(opts.sources, {
                null_ls.builtins.formatting.black,
            })
        end,
    },
}
