return {
    { -- override defaults
        "ggandor/flit.nvim",
        opts = { labeled_modes = "v" },
    },

    { -- use "/" instead of "g" for search
        "goolord/alpha-nvim",
        opts = function(_, dashboard)
            dashboard.section.buttons.val[4].opts.keymap[2] = "/"
            dashboard.section.buttons.val[4].opts.shortcut = "/"
        end,
    },

    { -- add message filters
        "folke/noice.nvim",
        opts = {
            routes = {
                -- { -- filter annoying buffer messages
                --     filter = {
                --         event = "msg_show",
                --         kind = "",
                --     },
                --     opts = { skip = true },
                -- },
                {
                    filter = {
                        event = "msg_show",
                        kind = "search_count",
                    },
                    opts = { skip = true },
                },
            },
        },
    },

    { -- add extra motions
        "nvim-treesitter/nvim-treesitter",
        dependencies = { "nvim-treesitter/playground" },
        opts = {
            playground = {
                enable = true,
            },
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
        "nvim-treesitter/nvim-treesitter-context",
        event = "VeryLazy",
        config = function(_, _)
            require("treesitter-context").setup({ enable = true })
        end,
    },

    {
        "cbochs/grapple.nvim",
        keys = {
            { "<leader>m", "<cmd>GrappleToggle<cr>", desc = "Grapple toggle tag" },
            { "<leader>k", "<cmd>GrapplePopup tags<cr>", desc = "Grapple popup tags" },
            { "<leader>j", "<cmd>GrappleCycle forward<cr>", desc = "Grapple cycle forward" },
            { "<leader>J", "<cmd>GrappleCycle backward<cr>", desc = "Grapple cycle backward" },
        },
        config = true,
    },

    {
        "Wansmer/treesj",
        keys = {
            { "gj", "<cmd>TSJToggle<cr>", desc = "Split / Join" },
        },
        opts = { use_default_keymaps = false },
    },

    {
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
