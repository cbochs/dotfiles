-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Inspired by https://github.com/cappyzawa/trim.nvim
vim.api.nvim_create_augroup("TrimWhitespace", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
    group = "TrimWhitespace",
    pattern = "*",
    callback = function()
        local patterns = {
            [[%s/\s\+$//e]], -- remove unwanted spaces
            [[%s/\($\n\s*\)\+\%$//]], -- trim last line
            [[%s/\%^\n\+//]], -- trim first line
        }

        local save = vim.fn.winsaveview()
        for _, pattern in ipairs(patterns) do
            vim.api.nvim_exec(string.format("keepjumps keeppatterns silent! %s", pattern), false)
        end
        vim.fn.winrestview(save)
    end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "ruby" },
    callback = function()
        vim.b.autoformat = false
    end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "go", "bash" },
    callback = function()
        vim.b.expandtab = false
    end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "norg" },
    callback = function()
        vim.b.shiftwidth = 1
    end,
})
