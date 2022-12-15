-- Repos:
-- - https://github.com/williamboman/mason.nvim
-- - https://github.com/williamboman/mason-lspconfig.nvim
-- - https://github.com/neovim/nvim-lspconfig
-- Description: LSP server installation

return {
    "williamboman/mason.nvim",
    requires = {
        "neovim/nvim-lspconfig",
        "williamboman/mason-lspconfig.nvim",
    },
    config = function()
        local ok, _ = pcall(require, "mason")
        if not ok then
            return
        end

        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "clangd",
                "pyright",
                "solargraph",
                "sumneko_lua",
                -- Error: "not a valid entry in ensure_installed"
                -- "lua-language-server",
                -- "luacheck",
                -- "ruff",
                -- "rust-analyzer",
                -- "selene",
                -- "stylua",
                -- "usort",
            },
            --
        })
    end,
}
