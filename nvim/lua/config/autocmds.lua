local H = {}

function H.defer()
    -- stylua: ignore start
    H.au("BufWritePre", "*", H.trim_whitespace)

    H.au("FileType", { "bash", "sh", "javascript", "javascriptreact" },             H.b("autoformat",        false))
    H.au("FileType", { "bash", "go", "sh", "zsh" },                                 H.opt_local("expandtab", false))
    H.au("FileType", { "coffee", "hcl", "javascript", "javascriptreact", "nginx" }, H.opt_local("shiftwidth",    2))
    H.au("FileType", { "norg" },                                                    H.opt_local("shiftwidth",    1))

    H.au({ "BufNewFile", "BufRead" }, { "*.conf.template" }, H.opt_local("filetype", "nginx"))
    H.au({ "BufNewFile", "BufRead" }, { "*.env*" },          H.opt_local("filetype", "sh"))
    H.au({ "BufNewFile", "BufRead" }, { "docker-compose*" }, H.opt_local("filetype", "yaml"))

    H.au("BufEnter", { "plugins.lua" }, H.require("config.commands")) -- SortSpec
    H.au("BufEnter", { "todo.norg" },   "norm zM")
    -- stylua: ignore end
end

local cbochs = vim.api.nvim_create_augroup("cbochs", { clear = true })
function H.au(event, pattern, callback_or_command)
    local callback, command
    if type(callback_or_command) == "string" then
        command = callback_or_command
    else
        callback = callback_or_command
    end

    vim.api.nvim_create_autocmd(event, {
        group = cbochs,
        pattern = pattern,
        callback = callback,
        command = command,
    })
end

function H.trim_whitespace()
    ---@diagnostic disable: undefined-global
    MiniTrailspace.trim()
    MiniTrailspace.trim_last_lines()
    ---@diagnostic enable: undefined-global
end

function H.b(option, value)
    return function()
        vim.b[option] = value
    end
end

function H.opt_local(option, value)
    return function()
        vim.opt_local[option] = value
    end
end

function H.require(modname)
    return function()
        require(modname)
    end
end

H.defer()
