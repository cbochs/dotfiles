-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader>tl", require("config.wezterm").test.last, { desc = "Test last" })
vim.keymap.set("n", "<leader>tn", require("config.wezterm").test.near, { desc = "Test nearest" })
vim.keymap.set("n", "<leader>tt", require("config.wezterm").test.file, { desc = "Test file" })
vim.keymap.set("n", "<leader>jj", require("config.wezterm").lazygit, { desc = "Open lazygit" })
vim.keymap.set("n", "<leader>gho", require("config.wezterm").github_open, { desc = "Open in Github" })
vim.keymap.set("n", "<leader>ghl", require("config.wezterm").github_link, { desc = "Copy Github link" })

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
