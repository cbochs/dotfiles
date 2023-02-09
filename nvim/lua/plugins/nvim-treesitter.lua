local filetypes = {
    "bash",
    "c",
    "cpp",
    "dockerfile",
    "fish",
    "gitignore",
    "html",
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
}

return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
        "nvim-treesitter/nvim-treesitter-context",
        "nvim-treesitter/nvim-treesitter-textobjects",
        "nvim-treesitter/playground",
        "RRethy/nvim-treesitter-textsubjects",
        "drybalka/tree-climber.nvim",
    },
    build = ":TSUpdate",
    ft = filetypes,
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = filetypes,
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
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<cr>",
                    node_incremental = "<cr>",
                    scope_incremental = "<s-cr>",
                    node_decremental = "<bs>",
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
    end,
}
