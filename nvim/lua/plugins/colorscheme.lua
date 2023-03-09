return {
    {
        "rebelot/kanagawa.nvim",
        build = ":KanagawaCompile",
        opts = {
            compile = true,
            dimInactive = true,
        },
    },
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "kanagawa",
        },
    },
}
