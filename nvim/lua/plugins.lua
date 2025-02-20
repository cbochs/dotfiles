return {
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                ruby_lsp = { mason = false },
            },
        },
    },

    { -- Override: blink.cmp
        -- Reason: completion was a little too eager to trigger
        -- Reference: https://cmp.saghen.dev/configuration/completion.html#trigger
        "saghen/blink.cmp",
        opts = {
            completion = {
                trigger = {
                    show_on_trigger_character = false,
                    show_on_insert_on_trigger_character = false,
                },
            },
        },
    },

    { -- Disabled: render-markdown.nvim
        -- Reason: distracting
        "MeanderingProgrammer/render-markdown.nvim",
        enabled = false,
    },

    { -- Override: nvim-lspconfig
        "neovim/nvim-lspconfig",
        opts = {
            -- Inlay hints clutter the screen
            inlay_hints = {
                enabled = false,
            },
            servers = {
                -- Snippet placeholders are a PIA
                -- Reference: https://github.com/golang/tools/blob/master/gopls/doc/settings.md
                gopls = {
                    settings = {
                        gopls = {
                            usePlaceholders = false,
                        },
                    },
                },
            },
        },
    },

    { -- grapple.nvim
        "cbochs/grapple.nvim",
        enabled = true,
        opts = {
            scope = "git_branch",
            default_scopes = {
                git = { shown = true },
                git_branch = { shown = true },
                global = { shown = true },
            },
        },
        event = { "BufReadPost", "BufNewFile" },
        cmd = "Grapple",
        keys = {
            { "<leader>k", "<cmd>Grapple toggle_tags<cr>", desc = "Grapple toggle tags" },
            { "<leader>K", "<cmd>Grapple toggle_loaded<cr>", desc = "Grapple toggle loaded" },
            { "<leader>j", "<cmd>Grapple cycle forward<cr>", desc = "Grapple cycle forward" },
            { "<leader>J", "<cmd>Grapple cycle backward<cr>", desc = "Grapple cycle backward" },
            { "<leader>1", "<cmd>Grapple select index=1<cr>", desc = "Grapple select 1" },
            { "<leader>2", "<cmd>Grapple select index=2<cr>", desc = "Grapple select 2" },
            { "<leader>3", "<cmd>Grapple select index=3<cr>", desc = "Grapple select 3" },
            { "<leader>4", "<cmd>Grapple select index=3<cr>", desc = "Grapple select 4" },
            { "<leader>m", "<cmd>Grapple toggle<cr>", desc = "Grapple toggle tag" },
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
        enabled = true,
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
                git = {
                    added = "+",
                    modified = "~",
                    removed = "-",
                },
            },
        },
        version = false,
    },

    { -- Experimental: codesnap.nvim
        "mistricky/codesnap.nvim",
        opts = {
            bg_theme = "sea",
            has_breadcrumbs = true,
            mac_window_bar = false,
            save_path = "~/Desktop/screenshots_code",
            watermark = "",
        },
        build = "make",
        cmd = "CodeSnap",
        keys = {
            { "<leader>cs", "<esc><cmd>CodeSnap<cr>", mode = { "v" } },
        },
    },

    { -- kanagawa.nvim (theme)
        "rebelot/kanagawa.nvim",
        opts = {
            compile = true,
            dimInactive = true,
            colors = { theme = { all = { ui = { bg_gutter = "none" } } } },
        },
        build = ":KanagawaCompile",
        priority = 1000,
    },

    { -- other.nvim
        "rgroli/other.nvim",
        name = "other-nvim",
        opts = {
            showMissingFiles = false,
        },
        keys = {
            { "ga", "<cmd>Other<cr>", desc = "Other file" },
        },
    },

    { -- sort.nvim
        "sQVe/sort.nvim",
        cmd = "Sort",
    },

    { -- oil.nvim (replace netrw)
        "stevearc/oil.nvim",
        enabled = true,
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

    { -- Override: mini.pairs
        -- Reason: no auto pairs during search
        "echasnovski/mini.pairs",
        opts = {
            modes = {
                command = false,
            },
        },
    },

    { -- Override: flash.nvim
        -- Reason: remove ";" char, disable backdrop
        "folke/flash.nvim",
        opts = {
            labels = "asdfghjkl",
            search = {
                mode = "fuzzy",
            },
            highlight = {
                backdrop = false,
            },
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
        optional = true,
    },

    { -- Override: noice.nvim
        -- Reason: add message filters
        "folke/noice.nvim",
        opts = {
            routes = {
                {
                    opts = { skip = true },
                    filter = {
                        event = "msg_show",
                        any = {
                            -- skip search messages
                            { find = "search hit" },

                            -- skip undo messages
                            { find = "%d+ line less" },
                            { find = "%d+ fewer lines" },
                            { find = "%d+ more line" },
                            { find = "%d+ change" },
                        },
                    },
                },
                {
                    view = "mini",
                    filter = {
                        event = "msg_show",
                        any = {
                            -- mini write messages "{n}L, {n}B"
                            { find = "%d+L, %d+B" },

                            -- mini search messages
                            { find = "Pattern not found" },
                        },
                    },
                },
            },
        },
        optional = true,
    },

    { -- Override: nvim-snippets
        -- Reason: extend *.erb filetypes to include html
        "garymjr/nvim-snippets",
        enabled = false,
        opts = {
            extended_filetypes = {
                eruby = {
                    "html",
                },
            },
        },
        optional = true,
    },

    {
        -- Reason: use "/" instead of "g" for search
        "folke/snacks.nvim",
        opts = {
            dashboard = {
                preset = {
                    header = [[
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
                ]],
                },
                formats = {
                    header = { "%s", align = "left" },
                },
            },
            picker = {
                sources = {
                    files = {
                        exclude = {
                            "node_modules",
                            "public/images",
                            "vendor/assets",
                            "vendor/bundle",
                        },
                    },
                },
            },
        },
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

    { -- Disabled: headlines.nvim
        -- Reason: annoying
        "lukas-reineke/headlines.nvim",
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
