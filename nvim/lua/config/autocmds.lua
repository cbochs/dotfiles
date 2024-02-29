-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.api.nvim_create_autocmd("BufWritePre", {
    group = vim.api.nvim_create_augroup("TrimWhitespace", { clear = true }),
    pattern = "*",
    callback = function()
        MiniTrailspace.trim()
        MiniTrailspace.trim_last_lines()
    end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "bash", "ruby", "sh", "javascript", "javascriptreact" },
    callback = function()
        vim.b.autoformat = false
    end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "coffee", "javascript", "javascriptreact" },
    callback = function()
        vim.opt_local.shiftwidth = 2
    end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "bash", "go", "sh" },
    callback = function()
        vim.opt_local.expandtab = false
    end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "norg" },
    callback = function()
        vim.opt_local.shiftwidth = 1
    end,
})

vim.api.nvim_create_autocmd({ "BufEnter" }, {
    pattern = "todo.norg",
    command = "norm zM",
})
