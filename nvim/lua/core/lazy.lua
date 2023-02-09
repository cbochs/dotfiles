local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazy_path) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazy_path,
    })
end

vim.opt.rtp:prepend(lazy_path)

require("lazy").setup("plugins", {
    dev = {
        path = "~/git_personal",
    },
    install = {
        colorscheme = { "kanagawa" },
    },
    performance = {
        rtp = {
            disabled_plugins = {
                "gzip",
                "matchit",
                "matchparen",
                "netrwPlugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
})
