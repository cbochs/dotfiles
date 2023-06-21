return {

    { -- override: enable inlay hints
        "neovim/nvim-lspconfig",
        opts = {
            inlay_hints = {
                enabled = false,
            },
        },
    },

    { -- override: default options
        "ggandor/flit.nvim",
        opts = { labeled_modes = "v" },
    },

    { -- override: use "/" instead of "g" for search
        "goolord/alpha-nvim",
        opts = function(_, dashboard)
            local logo = [[
            __:.__
           (_:..'"=
            ::/ o o\         AHAH!
           ;'-'   (_)     Spaceman Spiff      .
           '-._  ;-'        wins again !  _'._|\/:
           .:;  ;                .         '- '   /_
          :.. ; ;,                \       _/,    "_<
         :.|..| ;:                 \__   '._____  _)
         :.|.'| ||                            _/ /
         :.|..| :'                           `;--:
         '.|..|:':       _               _ _ :|_\:
      .. _:|__| '.\.''..' ) ___________ ( )_):|_|:
:....::''::/  | : :|''| "/ /_=_=_=_=_=/ :_[__'_\3_)
 ''''      '-''-'-'.__)-'
            ]]
            dashboard.section.header.val = vim.split(logo, "\n")
            dashboard.section.buttons.val[4].opts.keymap[2] = "/"
            dashboard.section.buttons.val[4].opts.shortcut = "/"
        end,
    },

    { -- override: add message filters
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

    { -- override: disable some keymaps in favour of mini.bracketed "treesitter"
        "folke/todo-comments.nvim",
        keys = {
            { "]t", false },
            { "[t", false },
        },
    },

    { -- override: help neorg sync-parsers
        "nvim-treesitter/nvim-treesitter",
        config = function(_, opts)
            require("nvim-treesitter.install").compilers = { "gcc-13" }
            require("nvim-treesitter.configs").setup(opts)
        end,
    },

    { -- override: setup better keymaps
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
        "L3MON4D3/LuaSnip",
        opts = function(_, opts)
            opts.history = true
            opts.region_check_events = "InsertEnter"
            opts.delete_check_events = "TextChanged,InsertLeave"
        end,
    },

    {
        "nvim-treesitter/nvim-treesitter-context",
        event = "VeryLazy",
        config = function(_, _)
            require("treesitter-context").setup({ enable = true })
        end,
    },

    {
        cmd = "CellularAutomaton",
        keys = {
            { "gol", "<cmd>CellularAutomaton game_of_life<cr>" },
            { "gor", "<cmd>CellularAutomaton make_it_rain<cr>" },
        },
        "eandrju/cellular-automaton.nvim",
    },

    {
        "cbochs/grapple.nvim",
        dir = "~/git_personal/grapple.nvim",
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
            wrap = true,
            select_first = true,
            escape = {
                ["<c-j>"] = true,
                ["<esc>"] = true,
                ["q"] = true,
            },
        },
    },

    {
        "kylechui/nvim-surround",
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                -- change visual keymap to allow flash.nvim to use 'S'
                keymaps = {
                    visual = "gS",
                    visual_line = "gSS",
                },
            })
        end,
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
        "kevinhwang91/nvim-bqf",
        ft = "qf",
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

    {
        "Wansmer/treesj",
        event = { "BufReadPost", "BufNewFile" },
        keys = {
            { "gj", "<cmd>TSJToggle<cr>", desc = "Split / Join" },
        },
        opts = { use_default_keymaps = false },
    },

    {
        "neovim/nvim-lspconfig",
        dependencies = {
            {
                "SmiteshP/nvim-navbuddy",
                dependencies = {
                    "SmiteshP/nvim-navic",
                    "MunifTanjim/nui.nvim",
                },
                opts = {
                    lsp = {
                        auto_attach = true,
                    },
                },
            },
        },
    },

    {
        "rgroli/other.nvim",
        event = { "BufReadPost", "BufNewFile" },
        keys = {
            { "ga", "<cmd>Other<cr>", desc = "Other file" },
        },
        config = function(_, opts)
            require("other-nvim").setup({
                mappings = {
                    "rails",
                    {
                        pattern = "(.+)/spec/(.*)/(.*)/(.*)_spec.rb",
                        target = {
                            { target = "%1/db/%3/%4.rb" },
                            { target = "%1/app/%3/%4.rb" },
                            { target = "%1/%3/%4.rb" },
                        },
                    },
                    {
                        pattern = "(.+)/spec/(.*)/(.*)_spec.rb",
                        target = {
                            { target = "%1/db/%2/%3.rb" },
                            { target = "%1/app/%2/%3.rb" },
                            { target = "%1/lib/%2/%3.rb" },
                        },
                    },
                    {
                        pattern = "(.+)/spec/(.*)/(.*)_(.*)_spec.rb",
                        target = {
                            { target = "%1/app/%4s/%3_%4.rb" },
                        },
                    },
                },
            })
        end,
    },

    {
        "https://github.com/notomo/gesture.nvim",
        opts = {
            show_board = false,
        },
        -- stylua: ignore
        config = function(_, opts)
            local Util = require("lazy.util")
            local enabled = false

            local function vim_keymap_set(mode, lhs, rhs)
                vim.keymap.set(mode, lhs, function()
                    if enabled then
                        rhs()
                    else
                        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(lhs, true, true, true), "n", true)
                    end
                end)
            end

            vim_keymap_set("n", "<LeftDrag>", function() require("gesture").draw(opts) end)
            vim_keymap_set("n", "<LeftRelease>", function() require("gesture").suspend() end)
            vim_keymap_set("n", "<2-LeftMouse>", function() require("gesture").finish() end)

            vim.keymap.set("n", "<leader>uD", function()
                enabled = not enabled
                if enabled then
                    Util.info("Enabled draw", { title = "Draw" })
                else
                    Util.warn("Disabled draw", { title = "Draw" })
                end
            end, { desc = "Draw" })
        end,
    },
}
