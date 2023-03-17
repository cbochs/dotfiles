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
        opts = function(_, opts)
            opts.routes = {
                { -- filter write messages "xxxL, xxxB"
                    filter = {
                        event = "msg_show",
                        find = "%dL",
                    },
                    opts = { skip = true },
                },
                { -- filter search messages
                    filter = {
                        event = "msg_show",
                        find = "search hit",
                    },
                    opts = { skip = true },
                },
            }
        end,
    },

    { -- add treesitter playground
        "nvim-treesitter/nvim-treesitter",
        dependencies = { "nvim-treesitter/playground" },
        keys = {
            { "<leader>up", "<cmd>TSPlaygroundToggle<cr>" },
        },
        opts = {
            playground = {
                enable = true,
            },
        },
    },

    { -- add more keymaps
        "nvim-telescope/telescope.nvim",
        opts = function(_, opts)
            opts.defaults.file_ignore_patterns = {
                "node_modules", -- ignore node packages
                "packer_compiled", -- ignore packer_compiled.lua
                "vendor", -- ignore bundled gems
            }
            opts.defaults.mappings.i = vim.tbl_extend("force", opts.defaults.mappings.i, {
                ["<c-j>"] = { "<esc>", type = "command" },
                ["<c-u>"] = false,
            })
            opts.pickers = {
                live_grep = {
                    mappings = {
                        i = {
                            ["<c-f>"] = require("telescope.actions").to_fuzzy_refine,
                        },
                    },
                },
                find_files = {
                    mappings = {
                        i = {
                            ["<c-f>"] = require("telescope.actions").to_fuzzy_refine,
                        },
                    },
                },
            }
        end,
    },

    {
        "nvim-treesitter/nvim-treesitter-context",
        event = "VeryLazy",
        config = function(_, _)
            require("treesitter-context").setup({ enable = true })
        end,
    },

    { "kkharji/sqlite.lua" },

    {
        "cbochs/grapple.nvim",
        -- dir = "~/git_personal/grapple.nvim",
        keys = {
            { "<leader>m", "<cmd>GrappleToggle<cr>", desc = "Grapple toggle tag" },
            { "<leader>k", "<cmd>GrapplePopup tags<cr>", desc = "Grapple popup tags" },
            { "<leader>j", "<cmd>GrappleCycle forward<cr>", desc = "Grapple cycle forward" },
            { "<leader>J", "<cmd>GrappleCycle backward<cr>", desc = "Grapple cycle backward" },
        },
    },

    {
        "cbochs/portal.nvim",
        -- dir = "~/git_personal/portal.nvim",
        keys = {
            { "<leader>i", "<cmd>Portal jumplist forward<cr>", desc = "Portal forward" },
            { "<leader>o", "<cmd>Portal jumplist backward<cr>", desc = "Portal backward" },
            {
                "<leader>O",
                function()
                    require("portal").tunnel({
                        require("portal.builtin").grapple.query({ max_results = 1 }),
                        require("portal.builtin").jumplist.query({ max_results = 3 }),
                    })
                end,
                desc = "Portal somewhere",
            },
        },
        opts = {
            escape = {
                ["<c-j>"] = true,
                ["q"] = true,
            },
        },
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
