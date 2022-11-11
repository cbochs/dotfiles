-- Auto-commands

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

-- vim.api.nvim_create_augroup("LspFormat", { clear = true })
-- vim.api.nvim_create_autocmd("BufWritePost", {
--     group = "LspFormat",
--     pattern = "*.rs",
--     callback = vim.lsp.buf.format
-- })
