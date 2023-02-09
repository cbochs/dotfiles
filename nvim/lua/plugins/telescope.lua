return {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    keys = {
        { "<leader>b", "<cmd>Telescope buffers<cr>", desc = "Find [b]uffer" },
        { "<leader>f", "<cmd>Telescope find_files<cr>", desc = "Find [f]ile" },
        { "<leader>/", "<cmd>Telescope live_grep<cr>", desc = "Live [s]earch" },
        { "<leader>*", "<cmd>Telescope grep_string<cr>", desc = "Search under cursor" },
        -- keymap("n", "<leader>.", customs_find_dotfiles, opts)
    },
    config = function()
        local telescope = require("telescope")
        telescope.setup({
            defaults = {
                layout_strategy = "horizontal",
                layout_config = {
                    prompt_position = "top",
                    width = 0.8,
                },
                file_ignore_patterns = {
                    "node_modules", -- ignore node packages
                    "packer_compiled", -- ignore packer_compiled.lua
                    "vendor", -- ignore bundled gems
                },
                selection_strategy = "reset",
                sorting_strategy = "ascending",
                mappings = {
                    i = {
                        ["<c-j>"] = { "<esc>", type = "command" },
                        ["<c-u>"] = false,
                    },
                },
            },
            pickers = {
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
            },
        })

        telescope.load_extension("fzf")
    end,
}
