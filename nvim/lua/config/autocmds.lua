-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Inspired by https://github.com/cappyzawa/trim.nvim

vim.api.nvim_create_autocmd("BufWritePre", {
    group = vim.api.nvim_create_augroup("TrimWhitespace", { clear = true }),
    pattern = "*",
    callback = function()
        MiniTrailspace.trim()
    end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "bash", "ruby", "sh" },
    callback = function()
        vim.b.autoformat = false
    end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "bash", "go", "sh" },
    callback = function()
        vim.b.expandtab = false
    end,
})

vim.api.nvim_create_autocmd({ "TermOpen" }, {
    callback = function()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
    end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "norg" },
    callback = function()
        vim.b.shiftwidth = 1
    end,
})
