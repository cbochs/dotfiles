stds.nvim = {
    read_globals = { "jit" },
}
std = "lua51+nvim"

read_globals = {
    "vim",
    "use",
}

globals = {
    "vim.g",
    "vim.b",
    "vim.w",
    "vim.o",
    "vim.bo",
    "vim.wo",
    "vim.go",
    "vim.env",
}

exclude_files = {
    "plugin/packer_compiled.lua",
}
