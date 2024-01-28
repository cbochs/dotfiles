-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local Wezterm = require("config.wezterm")
vim.keymap.set("n", "<leader>tl", Wezterm.test.last, { desc = "Test last" })
vim.keymap.set("n", "<leader>tn", Wezterm.test.near, { desc = "Test nearest" })
vim.keymap.set("n", "<leader>tt", Wezterm.test.file, { desc = "Test file" })
vim.keymap.set("n", "<leader>jj", Wezterm.lazygit, { desc = "Open lazygit" })
vim.keymap.set("n", "<leader>gho", Wezterm.github_open, { desc = "Open in Github" })
vim.keymap.set("n", "<leader>ghl", Wezterm.github_link, { desc = "Copy Github link" })

vim.keymap.set({ "i", "x" }, "<c-j>", "<esc>")

vim.keymap.set({ "n", "v" }, ":", ";")
vim.keymap.set({ "n", "v" }, ";", ":")

vim.keymap.set("n", "U", "<c-r>")

vim.keymap.set("n", "<leader>up", "<cmd>InspectTree<cr>", { desc = "Toggle treesitter" })

local wk = require("which-key")
wk.register({
    mode = { "n" },
    ["<leader>t"] = { name = "+test" },
    ["<leader>n"] = { name = "+neorg" },
})
