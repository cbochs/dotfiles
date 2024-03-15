return {
    { -- Grapple.nvim
        "cbochs/grapple.nvim",
        enabled = true,
        opts = {
            scope = "git_branch",
        },
        event = { "BufReadPost", "BufNewFile" },
        cmd = "Grapple",
        keys = {
            { "<leader>k", "<cmd>Grapple toggle_tags<cr>", desc = "Grapple toggle tags" },
            { "<leader>K", "<cmd>Grapple toggle_scopes<cr>", desc = "Grapple toggle scopes" },
            { "<leader>j", "<cmd>Grapple cycle forward<cr>", desc = "Grapple cycle forward" },
            { "<leader>J", "<cmd>Grapple cycle backward<cr>", desc = "Grapple cycle backward" },
            { "<leader>1", "<cmd>Grapple select index=1<cr>", desc = "Grapple select 1" },
            { "<leader>2", "<cmd>Grapple select index=2<cr>", desc = "Grapple select 2" },
            { "<leader>3", "<cmd>Grapple select index=3<cr>", desc = "Grapple select 3" },
            { "<leader>4", "<cmd>Grapple select index=3<cr>", desc = "Grapple select 4" },
            {
                "<leader>m",
                function()
                    local Grapple = require("grapple")
                    local Oil = require("oil")

                    if Oil.get_cursor_entry() then
                        local filename = Oil.get_cursor_entry().name
                        local directory = Oil.get_current_dir()

                        local Path = require("grapple.path")
                        Grapple.toggle({ path = Path.join(directory, filename) })
                    else
                        Grapple.toggle()
                    end
                end,
                desc = "Grapple toggle tag",
            },
        },
    },

    { -- Portal.nvim
        "cbochs/portal.nvim",
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

    { -- Experimental: nvim-spider
        "chrisgrieser/nvim-spider",
        lazy = true,
        keys = {
            {
                "w",
                "<cmd>lua require('spider').motion('w')<CR>",
                mode = { "n", "o", "x" },
            },
            {
                "e",
                "<cmd>lua require('spider').motion('e')<CR>",
                mode = { "n", "o", "x" },
            },
            {
                "b",
                "<cmd>lua require('spider').motion('b')<CR>",
                mode = { "n", "o", "x" },
            },
        },
    },

    { -- mini.trailspace
        "echasnovski/mini.trailspace",
        opts = {},
        event = { "BufReadPost", "BufNewFile" },
    },

    { -- lazy.nvim (package manager)
        "folke/lazy.nvim",
        version = false,
    },

    { -- Experimental: zen-mode.nvim
        "folke/zen-mode.nvim",
        opts = {},
        cmd = "ZenMode",
        keys = {
            { "<leader>uz", "<cmd>ZenMode<cr>", desc = "Zen mode" },
        },
    },

    { -- substitute.nvim
        "gbprod/substitute.nvim",
        config = true,
        keys = {
            { "r", "<cmd>lua require('substitute').operator()<cr>" },
            { "rr", "<cmd>lua require('substitute').line()<cr>" },
            { "R", "<cmd>lua require('substitute').eol()<cr>" },
            { "r", "<cmd>lua require('substitute').visual()<cr>", mode = "x" },
        },
    },

    { -- Experimental: fzf-lua
        "ibhagwan/fzf-lua",
        opts = { "fzf-vim" },
        keys = {
            {
                "<c-p>",
                function()
                    local opts = {}
                    opts.cmd = vim.env.FZF_DEFAULT_COMMAND
                    if vim.fn.expand("%:p:h") ~= vim.loop.cwd() then
                        opts.cmd = opts.cmd .. (" | proximity-sort %s"):format(vim.fn.expand("%"))
                    end
                    opts.prompt = "> "
                    opts.fzf_opts = {
                        ["--info"] = "inline",
                        ["--tiebreak"] = "index",
                        ["--layout"] = "reverse",
                    }
                    require("fzf-lua").files(opts)
                end,
                desc = "Find files",
            },
        },
    },

    { -- vim-coffee-script
        "kchmck/vim-coffee-script",
        ft = "coffee",
    },

    { -- nvim-bfq (better quickfix)
        "kevinhwang91/nvim-bqf",
        ft = "qf",
    },

    { -- nvim-ufo
        "kevinhwang91/nvim-ufo",
        dependencies = {
            "kevinhwang91/promise-async",
        },
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

    { -- nvim-surround
        "kylechui/nvim-surround",
        opts = {
            keymaps = {
                visual = "gs",
                visual_line = "gS",
            },
        },
        event = "VeryLazy",
    },

    { -- luasnip
        "L3MON4D3/LuaSnip",
        opts = function(_, opts)
            opts.history = true
            opts.region_check_events = "InsertEnter"
            opts.delete_check_events = "TextChanged,InsertLeave"
        end,
    },

    { -- LazyVim (distro)
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "kanagawa",
            icons = {
                diagnostics = {
                    Error = "E",
                    Warn = "W",
                    Hint = "H",
                    Info = "I",
                },
            },
        },
        version = false,
    },

    { -- nvim-treesitter-context
        "nvim-treesitter/nvim-treesitter-context",
        config = function(_, _)
            require("treesitter-context").setup({ enable = true })
        end,
        event = "VeryLazy",
    },

    { -- kanagawa.nvim (theme)
        "rebelot/kanagawa.nvim",
        opts = {
            compile = true,
            dimInactive = true,
            colors = { theme = { all = { ui = { bg_gutter = "none" } } } },
            overrides = function(_)
                return {
                    Comment = { link = "Constant" },
                }
            end,
        },
        build = ":KanagawaCompile",
        priority = 1000,
    },

    { -- other.nvim
        "rgroli/other.nvim",
        config = function(_, _)
            require("other-nvim").setup({
                showMissingFiles = false,
                mappings = {
                    "rails",
                    {
                        pattern = "(.+)/spec/(.*)/(.*)/(.*)_spec.rb",
                        target = {
                            { context = "source", target = "%1/db/%3/%4.rb" },
                            { context = "source", target = "%1/app/%3/%4.rb" },
                            { context = "source", target = "%1/%3/%4.rb" },
                        },
                    },
                    {
                        pattern = "(.+)/spec/(.*)/(.*)_spec.rb",
                        target = {
                            { context = "source", target = "%1/db/%2/%3.rb" },
                            { context = "source", target = "%1/app/%2/%3.rb" },
                            { context = "source", target = "%1/lib/%2/%3.rb" },
                        },
                    },
                    {
                        pattern = "(.+)/spec/(.*)/(.*)_(.*)_spec.rb",
                        target = {
                            { context = "source", target = "%1/app/%4s/%3_%4.rb" },
                        },
                    },
                },
            })
        end,
        keys = {
            { "ga", "<cmd>Other<cr>", desc = "Other file" },
        },
    },

    { -- oil.nvim (replace netrw)
        "stevearc/oil.nvim",
        opts = {},
        keys = {
            { "-", "<cmd>Oil<cr>", desc = "Open parent directory" },
        },
    },

    { -- treesj (split-join)
        "Wansmer/treesj",
        opts = {
            use_default_keymaps = false,
        },
        keys = {
            { "gj", "<cmd>TSJToggle<cr>", desc = "Split / Join" },
        },
    },

    { -- Override: mini.indentscope
        -- Reason: Disable some keymaps in favour of mini.bracketed "indent"
        "echasnovski/mini.indentscope",
        opts = {
            mappings = {
                goto_top = "",
                goto_bottom = "",
            },
        },
        optional = true,
    },

    { -- Override: flash.nvim
        -- Reason: remove ";" char, disable backdrop
        "folke/flash.nvim",
        opts = {
            highlight = {
                backdrop = false,
                groups = {
                    current = "CurSearch",
                    match = "CurSearch",
                    label = "Cursor",
                },
            },
            modes = {
                search = {
                    enabled = false,
                },
                char = {
                    keys = { "f", "F", "t", "T", "," },
                },
            },
        },
        optional = true,
    },

    { -- Override: noice.nvim
        -- Reason: add message filters
        "folke/noice.nvim",
        opts = function(_, opts)
            local patterns = {
                -- filter write messages "{n}L, {n}B"
                "%d+L, %d+B",

                -- filter undo messages
                "%d line less;",
                "%d fewer lines;",
                "%d more line",
                "%d change",

                -- filter search messages
                "search hit",
            }

            opts.routes = {}

            for _, pattern in ipairs(patterns) do
                table.insert(opts.routes, {
                    filter = {
                        event = "msg_show",
                        kind = "",
                        find = pattern,
                    },
                    opts = { skip = true },
                })
            end
        end,
        optional = true,
    },

    { -- Override: alpha-nvim
        -- Reason: use "/" instead of "g" for search
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
        optional = true,
    },

    { -- Override: telescope.nvim
        -- Reason: better keymaps
        "nvim-telescope/telescope.nvim",
        opts = function(_, opts)
            opts.defaults.file_ignore_patterns = {
                "node_modules", -- ignore node packages
                "vendor", -- ignore bundled gems
            }
            opts.defaults.mappings.i = vim.tbl_extend("force", opts.defaults.mappings.i, {
                ["<c-f>"] = require("telescope.actions").to_fuzzy_refine,
                ["<c-j>"] = { "<esc>", type = "command" },
                ["<c-u>"] = false,
            })
        end,
        optional = true,
    },

    { -- Disabled: bufferline.nvim
        -- Reason: unused
        "akinsho/bufferline.nvim",
        enabled = false,
    },

    { -- Disabled: catppuccin
        -- Reason: prefer kanagawa.nvim theme
        "catppuccin",
        enabled = false,
    },

    { -- Disabled: Grapple.nvim (Rust edition)
        -- Reason: an experiment
        "cbochs/grapple_native",
        dev = true,
        enabled = false,
    },

    { -- Disabled: mini.bracketed
        -- Reason: unused
        "echasnovski/mini.bracketed",
        enabled = false,
    },

    { -- Disabled: mini.surround
        -- Reason: prefer nvim-surround
        "echasnovski/mini.surround",
        enabled = false,
    },

    { -- Disabled: tokyonight.nvim
        -- Reason: prefer kanagawa.nvim theme
        "folke/tokyonight.nvim",
        enabled = false,
    },

    { -- Disabled: nvim-spectre
        -- Reason: unused
        "nvim-pack/nvim-spectre",
        enabled = false,
    },

    { -- Disabled: nvim-navic
        -- Reason: unused
        "SmiteshP/nvim-navic",
        enabled = false,
    },
}
