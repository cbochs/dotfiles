-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local Wezterm = require("config.wezterm")
vim.keymap.set("n", "<leader>tl", Wezterm.test.last, { desc = "Test last" })
vim.keymap.set("n", "<leader>tn", Wezterm.test.near, { desc = "Test nearest" })
vim.keymap.set("n", "<leader>tt", Wezterm.test.file, { desc = "Test file" })
vim.keymap.set("n", "<leader>gho", Wezterm.github_open, { desc = "Open in Github" })
vim.keymap.set("n", "<leader>ghl", Wezterm.github_link, { desc = "Copy Github link" })
vim.keymap.set("n", "<leader>rp", Wezterm.preview_readme, { desc = "Preview README" })

vim.keymap.set({ "i", "x" }, "<c-j>", "<esc>")

vim.keymap.set({ "n", "v" }, ":", ";")
vim.keymap.set({ "n", "v" }, ";", ":")

vim.keymap.set("n", "U", "<c-r>")

require("which-key").register({
    mode = { "n" },
    ["<leader>n"] = { name = "+neorg" },
    ["<leader>t"] = { name = "+test" },
})
