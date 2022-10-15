-- LSP Installation & Configuration
-- Repos:
-- - https://github.com/williamboman/mason.nvim
-- - https://github.com/williamboman/mason-lspconfig.nvim
-- - https://github.com/neovim/nvim-lspconfig

local M = {}

M.Details = function()
    return {
        "williamboman/mason.nvim",
        requires = {
            "neovim/nvim-lspconfig",
            "williamboman/mason-lspconfig.nvim",
        },
        config = M.Setup,
    }
end

M.Setup = function()
    require("mason").setup()
    require("mason-lspconfig").setup({
        ensure_installed = {
            "sumneko_lua",
            "solargraph"
        }
    })
end

return M
