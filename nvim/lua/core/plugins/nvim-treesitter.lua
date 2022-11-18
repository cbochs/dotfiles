-- Syntax Highlighting
-- Repos:
-- - https://github.com/nvim-treesitter/nvim-treesitter
-- - https://github.com/nvim-treesitter/nvim-treesitter-contexts
-- - https://github.com/nvim-treesitter/playground
-- - https://github.com/RRethy/nvim-treesitter-textsubjects

local M = {}

M.Details = function()
    return {
        "nvim-treesitter/nvim-treesitter",
        requires = {
            "nvim-treesitter/nvim-treesitter-context",
            "nvim-treesitter/nvim-treesitter-textobjects",
            "nvim-treesitter/playground",
            "RRethy/nvim-treesitter-textsubjects",
            "drybalka/tree-climber.nvim",
        },
        run = ":TSUpdate",
        config = M.Setup,
    }
end

M.Setup = function()
    require("nvim-treesitter.configs").setup({
        ensure_installed = {
            "bash",
            "c",
            "cpp",
            "dockerfile",
            "fish",
            "gitignore",
            "javascript",
            "json",
            "jsonc",
            "lua",
            "markdown",
            "markdown_inline",
            "python",
            "regex",
            "ruby",
            "rust",
            "typescript",
            "yaml",
        },
        highlight = {
            enable = true,
        },
        indent = {
            enable = true,
            disable = { "python" },
        },
        textsubjects = {
            enable = true,
            prev_selection = ",",
            keymaps = {
                ["."] = "textsubjects-smart",
                [";"] = "textsubjects-container-outer",
                ["i;"] = "textsubjects-container-inner",
            },
        },
        textobjects = {
            select = {
                enable = true,
                lookahead = true,
                keymaps = {
                    ["af"] = "@function.outer",
                    ["if"] = "@function.inner",
                },
            },
            swap = {
                enable = true,
                swap_next = {
                    ["<leader>a"] = "@parameter.inner",
                },
                swap_previous = {
                    ["<leader>A"] = "@parameter.inner",
                },
            },
        },
        playground = { enable = true },
    })

    require("nvim-treesitter.install").prefer_git = true

    require("treesitter-context").setup({
        enable = true,
    })
end

return M
