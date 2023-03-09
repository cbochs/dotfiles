-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.shiftwidth = 4
vim.opt.tabstop = 4

-- Folding (from nvim-ufo)
vim.opt.foldcolumn = "1"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true

-- Jumplist (from portal.nvim)
vim.opt.jumpoptions = "stack"

-- Reduce command buffer size
vim.opt.cmdwinheight = 1

-- Disable comment continuation
vim.opt.formatoptions:remove("o") -- Don't continue after 'o' or 'O'
vim.opt.formatoptions:remove("r") -- Don't continue after <cr>
