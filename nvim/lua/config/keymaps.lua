-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader>tl", require("config.wezterm").test.last)
vim.keymap.set("n", "<leader>tn", require("config.wezterm").test.near)
vim.keymap.set("n", "<leader>tt", require("config.wezterm").test.file)
vim.keymap.set("n", "<leader>jj", require("config.wezterm").lazygit)
vim.keymap.set("n", "<leader>oo", require("config.wezterm").open_in_github)

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
