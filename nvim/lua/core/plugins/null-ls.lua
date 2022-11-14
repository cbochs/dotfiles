-- LSP Linting & Formatting
-- Repo: https://github.com/jose-elias-alvarez/null-ls.nvim

local M = {}

M.Details = function()
    return {
        "jose-elias-alvarez/null-ls.nvim",
        requires = {
            "nvim-lua/plenary.nvim",
        },
        config = M.Setup,
    }
end

M.Setup = function()
    local null_ls = require("null-ls")
    null_ls.setup({
        sources = {
            null_ls.builtins.diagnostics.luacheck,
            null_ls.builtins.diagnostics.ruff,
            null_ls.builtins.formatting.black,
            null_ls.builtins.formatting.stylua,
            null_ls.builtins.formatting.usort,
        },
    })
end

return M
