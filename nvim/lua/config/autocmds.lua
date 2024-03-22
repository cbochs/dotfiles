local cbochs = vim.api.nvim_create_augroup("cbochs", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    group = cbochs,
    callback = function()
        ---@diagnostic disable: undefined-global
        MiniTrailspace.trim()
        MiniTrailspace.trim_last_lines()
        ---@diagnostic enable: undefined-global
    end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "bash", "ruby", "sh", "javascript", "javascriptreact" },
    group = cbochs,
    callback = function()
        vim.b.autoformat = false
    end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "ruby" },
    group = cbochs,
    callback = function()
        vim.opt_local.indentexpr = ""
    end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "coffee", "javascript", "javascriptreact", "nginx" },
    group = cbochs,
    callback = function()
        vim.opt_local.shiftwidth = 2
    end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "bash", "go", "sh", "zsh" },
    group = cbochs,
    callback = function()
        vim.opt_local.expandtab = false
    end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "*.conf.template" },
    group = cbochs,
    callback = function()
        vim.opt_local.filetype = "nginx"
    end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "*.env*" },
    group = cbochs,
    callback = function()
        vim.opt_local.filetype = "sh"
    end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "docker-compose*.yaml", "docker-compose*.yml" },
    group = cbochs,
    callback = function()
        vim.opt_local.filetype = "yaml"
    end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "norg" },
    group = cbochs,
    callback = function()
        vim.opt_local.shiftwidth = 1
    end,
})

vim.api.nvim_create_autocmd({ "BufEnter" }, {
    pattern = "todo.norg",
    group = cbochs,
    command = "norm zM",
})
