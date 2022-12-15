-- Repo: https://github.com/nvim-telescope/telescope.nvim
-- Description: Full-fledged fuzzy search UI and framework

return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    requires = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
    },
    config = function()
        local ok, telescope = pcall(require, "telescope")
        if not ok then
            return
        end

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
        local customs_find_dotfiles = function()
            builtin.find_files({ cwd = "~/.config/nvim" })
        end

        local keymap = vim.keymap.set
        local opts = { silent = true }
        keymap("n", "<leader>b", builtin.buffers, opts)
        keymap("n", "<leader>f", builtin.find_files, opts)
        keymap("n", "<leader>s", builtin.live_grep, opts)
        keymap("n", "<leader>.", customs_find_dotfiles, opts)
    end,
}
