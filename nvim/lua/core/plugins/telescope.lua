-- Fuzzy Search
-- Repo: https://github.com/nvim-telescope/telescope.nvim

local M = {}

M.Details = function()
    return {
        "nvim-telescope/telescope.nvim",
        requires = {
            "nvim-lua/plenary.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
        },
        branch = "0.1.x",
        config = M.Setup,
    }
end

M.Setup = function()
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
    })

    telescope.load_extension("fzf")

    local builtin = require("telescope.builtin")
    local keymap = vim.keymap.set
    local default_opts = { silent = true }

    local customs_find_dotfiles = function()
        builtin.find_files({ cwd = "~/.config/nvim" })
    end

    keymap("n", "<leader>b", builtin.buffers, default_opts)
    keymap("n", "<leader>f", builtin.find_files, default_opts)
    keymap("n", "<leader>s", builtin.live_grep, default_opts)
    keymap("n", "<leader>.", customs_find_dotfiles, default_opts)
end

return M
