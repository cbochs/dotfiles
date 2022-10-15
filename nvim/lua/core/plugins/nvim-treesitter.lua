-- Syntax Highlighting
-- Repos:
-- - https://github.com/nvim-treesitter/nvim-treesitter
-- - https://github.com/nvim-treesitter/nvim-treesitter-contexts
-- - https://github.com/nvim-treesitter/playground

local M = {}

M.Details = function()
    return {
        "nvim-treesitter/nvim-treesitter",
        requires = {
            "nvim-treesitter/nvim-treesitter-context",
            "nvim-treesitter/nvim-treesitter-textobjects",
            "nvim-treesitter/playground",
        },
        run = ":TSUpdate",
        config = M.Setup,
    }
end

M.Setup = function()
    require("nvim-treesitter.configs").setup({
        highlight = {
            enable = true,
        },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<M-n>",
                node_incremental = "<M-n>",
                scope_incremental = "<M-m>",
                node_decremental = "<M-p>",
            },
        },
        indent = {
            enable = true
        },
        textobjects = {
            select = {
                enable = true,
                lookahead = true,
                keymaps = {
                    ["af"] = "@function.outer",
                    ["if"] = "@function.inner",
                },
            }
        },
        playground = { enable = true },
    })
    require("nvim-treesitter.install").prefer_git = true

    require("treesitter-context").setup({
        enable = true,
    })
end

return M
