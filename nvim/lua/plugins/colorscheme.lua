return {
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "kanagawa",
        },
    },

    {
        "rebelot/kanagawa.nvim",
        build = ":KanagawaCompile",
        opts = {
            compile = true,
            dimInactive = true,
            colors = { theme = { all = { ui = { bg_gutter = "none" } } } },
        },
    },
}
