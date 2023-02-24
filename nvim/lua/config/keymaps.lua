-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set({ "i", "x" }, "<c-j>", "<esc>")
vim.keymap.set("t", "<c-j>", "<c-\\><c-n>")

vim.keymap.set({ "n", "v" }, ":", ";")
vim.keymap.set({ "n", "v" }, ";", ":")

vim.keymap.set("n", "U", "<c-r>")

vim.keymap.set("n", "<leader>ut", "<cmd>split | terminal<cr>a", { desc = "Toggle terminal" })

local wk = require("which-key")
wk.register({
    mode = { "n" },
    ["<leader>t"] = { name = "+test" },
    ["<leader>n"] = { name = "+neorg" },
})
