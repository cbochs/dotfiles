return {
    { -- override defaults
        "ggandor/flit.nvim",
        opts = { labeled_modes = "v" },
    },

    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            textobjects = {
                move = {
                    enable = true,
                    set_jump = true,
                    goto_next_start = {
                        ["]b"] = { query = "@block.outer", desc = "Next block" },
                        ["]c"] = { query = "@class.outer", desc = "Next class" },
                        ["]f"] = { query = "@function.outer", desc = "Next function" },
                    },
                    goto_previous_start = {
                        ["[b"] = { query = "@block.outer", desc = "Prev block" },
                        ["[c"] = { query = "@class.outer", desc = "Prev class" },
                        ["[f"] = { query = "@function.outer", desc = "Prev function" },
                    },
                },
            },
        },
    },

    {
        "AndrewRadev/splitjoin.vim",
        event = "VeryLazy",
        keys = {
            { "gj", "<cmd>SplitjoinJoin<cr>", desc = "Join" },
            { "gk", "<cmd>SplitjoinSplit<cr>", desc = "Split" },
        },
        config = function(_, _)
            vim.cmd([[
                let g:splitjoin_split_mapping = ""
                let g:splitjoin_join_mapping = ""
            ]])
        end,
    },

    { -- prefer this over mini.surround
        "kylechui/nvim-surround",
        event = "VeryLazy",
        config = true,
    },

    {
        "gbprod/substitute.nvim",
        keys = {
            { "r", "<cmd>lua require('substitute').operator()<cr>" },
            { "rr", "<cmd>lua require('substitute').line()<cr>" },
            { "R", "<cmd>lua require('substitute').eol()<cr>" },
            { "r", "<cmd>lua require('substitute').visual()<cr>", mode = "x" },
        },
        config = true,
    },

    {
        "kevinhwang91/nvim-ufo",
        dependencies = { "kevinhwang91/promise-async" },
        event = "VeryLazy",
        keys = {
            { "zR", "<cmd>lua require('ufo').openAllFolds()<cr>", desc = "Open folds" },
            { "zM", "<cmd>lua require('ufo').closeAllFolds()<cr>", desc = "Close folds" },
        },
        opts = {
            provider_selector = function(_, _, _)
                return { "treesitter", "indent" }
            end,
        },
    },
}
