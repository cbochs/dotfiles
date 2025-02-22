-- Escape
vim.keymap.set({ "i", "x" }, "<c-j>", "<esc>")

-- No-shift command mode
vim.keymap.set({ "n", "v" }, ":", ";")
vim.keymap.set({ "n", "v" }, ";", ":")

-- Helix-like undo/redo
vim.keymap.set("n", "U", "<c-r>")

-- Helix-like go-to line endings
vim.keymap.set({ "n", "x" }, "gl", "$")
vim.keymap.set({ "n", "x" }, "gh", "^")
vim.keymap.set("n", "gs", "0")

-- Delete LazyVim next/prev buffer keymaps
vim.keymap.del("n", "<S-h>")
vim.keymap.del("n", "<S-l>")

-- Easy source file
vim.keymap.set("n", "<leader>S", "<cmd>w | source %<cr>", { desc = "Source file" })

-- Easy copy current filepath
vim.keymap.set("n", "<leader>yy", "<cmd>let @+ = expand('%')<cr>", { desc = "Copy filepath" })

local Wezterm = require("config.wezterm")
vim.keymap.set("n", "<leader>ghl", Wezterm.github_link, { desc = "Copy Github link" })
vim.keymap.set("n", "<leader>gho", Wezterm.github_open, { desc = "Open in Github" })
vim.keymap.set("n", "<leader>rp", Wezterm.preview_readme, { desc = "Preview README" })
vim.keymap.set("n", "<leader>tl", Wezterm.test.last, { desc = "Test last" })
vim.keymap.set("n", "<leader>tn", Wezterm.test.near, { desc = "Test nearest" })
vim.keymap.set("n", "<leader>tt", Wezterm.test.file, { desc = "Test file" })

require("which-key").add({
    mode = { "n" },
    {
        { "<leader>n", group = "neorg" },
        { "<leader>t", group = "test" },
    },
})
