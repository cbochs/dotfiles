-- File-specific options

vim.api.nvim_create_augroup("FileOptions", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
    group = "FileOptions",
    pattern = { "bash", "sh" },
    callback = function()
        vim.bo.expandtab = false
    end,
})
