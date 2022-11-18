stds.nvim = {
    read_globals = { "jit" },
}
std = "lua51+nvim"

read_globals = {
    "vim",
    "use",
}

globals = {
    "vim.b",
    "vim.bo",
    "vim.env",
    "vim.g",
    "vim.go",
    "vim.o",
    "vim.opt",
    "vim.w",
    "vim.wo",
}

exclude_files = {
    "plugin/packer_compiled.lua",
}
