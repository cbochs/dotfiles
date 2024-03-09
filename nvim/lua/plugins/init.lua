return {
    {
        "cbochs/grapple.nvim",
        dev = true,
        enabled = true,
        opts = {
            scope = "git_branch",
        },
        event = { "BufReadPost", "BufNewFile" },
        cmd = "Grapple",
        keys = {
            { "<leader>m", "<cmd>Grapple toggle<cr>", desc = "Grapple toggle tag" },
            { "<leader>k", "<cmd>Grapple toggle_tags<cr>", desc = "Grapple toggle tags" },
            { "<leader>K", "<cmd>Grapple toggle_scopes<cr>", desc = "Grapple toggle scopes" },
            { "<leader>j", "<cmd>Grapple cycle forward<cr>", desc = "Grapple cycle forward" },
            { "<leader>J", "<cmd>Grapple cycle backward<cr>", desc = "Grapple cycle backward" },
            { "<leader>1", "<cmd>Grapple select index=1<cr>", desc = "Grapple select 1" },
            { "<leader>2", "<cmd>Grapple select index=2<cr>", desc = "Grapple select 2" },
            { "<leader>3", "<cmd>Grapple select index=3<cr>", desc = "Grapple select 3" },
            { "<leader>4", "<cmd>Grapple select index=3<cr>", desc = "Grapple select 4" },
            {
                "<leader>M",
                function()
                    local Oil = require("oil")
                    local filename = Oil.get_cursor_entry().name
                    local directory = Oil.get_current_dir()

                    local Grapple = require("grapple")
                    local Path = require("grapple.path")
                    Grapple.toggle({ path = Path.join(directory, filename) })
                end,
                desc = "Grapple tag under cursor",
            },
        },
    },

    {
        "cbochs/grapple_nvim",
        dev = true,
        enabled = false,
    },

    {
        "cbochs/portal.nvim",
        dev = true,
        enabled = true,
        opts = {
            wrap = true,
            select_first = true,
            escape = {
                ["<c-j>"] = true,
                ["<esc>"] = true,
                ["q"] = true,
            },
        },
        keys = {
            { "<leader>i", "<cmd>Portal grapple forward<cr>", desc = "Portal forward" },
            { "<leader>o", "<cmd>Portal grapple backward<cr>", desc = "Portal backward" },
        },
    },

    { -- override: remove ";" char, disable backdrop
        "folke/flash.nvim",
        opts = {
            modes = {
                search = {
                    enabled = false,
                },
                char = {
                    keys = { "f", "F", "t", "T", "," },
                    highlight = {
                        backdrop = false,
                    },
                },
            },
        },
    },

    { -- override: add message filters
        "folke/noice.nvim",
        opts = function(_, opts)
            opts.routes = {
                { -- filter write messages "xxxL, xxxB"
                    filter = {
                        event = "msg_show",
                        kind = "",
                        find = "%dL",
                    },
                    opts = { skip = true },
                },
                { -- filter search messages
                    filter = {
                        event = "msg_show",
                        kind = "",
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

    {
        "gbprod/substitute.nvim",
        config = true,
        keys = {
            { "r", "<cmd>lua require('substitute').operator()<cr>" },
            { "rr", "<cmd>lua require('substitute').line()<cr>" },
            { "R", "<cmd>lua require('substitute').eol()<cr>" },
            { "r", "<cmd>lua require('substitute').visual()<cr>", mode = "x" },
        },
    },

    {
        cmd = "CellularAutomaton",
        keys = {
            { "gol", "<cmd>CellularAutomaton game_of_life<cr>" },
            { "gor", "<cmd>CellularAutomaton make_it_rain<cr>" },
        },
        "eandrju/cellular-automaton.nvim",
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

    { "kchmck/vim-coffee-script" },

    {
        "kevinhwang91/nvim-bqf",
        ft = "qf",
    },

    {
        "kevinhwang91/nvim-ufo",
        dependencies = { "kevinhwang91/promise-async" },
        opts = {
            provider_selector = function(_, _, _)
                return { "treesitter", "indent" }
            end,
        },
        event = "VeryLazy",
        keys = {
            { "zR", "<cmd>lua require('ufo').openAllFolds()<cr>", desc = "Open folds" },
            { "zM", "<cmd>lua require('ufo').closeAllFolds()<cr>", desc = "Close folds" },
        },
    },

    {
        "kylechui/nvim-surround",
        opts = {
            -- change visual keymap to allow flash.nvim to use 'S'
            keymaps = {
                visual = "gS",
                visual_line = "gSS",
            },
        },
        event = "VeryLazy",
    },

    {
        "L3MON4D3/LuaSnip",
        opts = function(_, opts)
            opts.history = true
            opts.region_check_events = "InsertEnter"
            opts.delete_check_events = "TextChanged,InsertLeave"
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
                ["<c-f>"] = require("telescope.actions").to_fuzzy_refine,
                ["<c-j>"] = { "<esc>", type = "command" },
                ["<c-u>"] = false,
            })
        end,
    },

    {
        "nvim-treesitter/nvim-treesitter-context",
        config = function(_, _)
            require("treesitter-context").setup({ enable = true })
        end,
        event = "VeryLazy",
    },

    {
        "rgroli/other.nvim",
        config = function(_, _)
            require("other-nvim").setup({
                showMissingFiles = false,
                mappings = {
                    "rails",
                    {
                        -- generic test mapping for minitest and rspec
                        pattern = "/app/(.*)/(.*).rb",
                        target = {
                            { context = "test", target = "/spec/requests/%1/%2_spec.rb" },
                            { context = "test", target = "/spec/requests/%2_spec.rb" },
                            { context = "test", target = "/spec/requests/**/%2_spec.rb" },
                        },
                    },
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
        keys = {
            { "ga", "<cmd>Other<cr>", desc = "Other file" },
        },
    },

    {
        "stevearc/oil.nvim",
        opts = {},
        keys = {
            { "-", "<cmd>Oil<cr>", desc = "Open parent directory" },
        },
    },

    {
        "Wansmer/treesj",
        opts = {
            use_default_keymaps = false,
        },
        keys = {
            { "gj", "<cmd>TSJToggle<cr>", desc = "Split / Join" },
        },
    },
}
