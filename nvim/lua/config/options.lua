vim.opt.shiftwidth = 4
vim.opt.tabstop = 4

-- Reduce command buffer size
vim.opt.cmdwinheight = 1

-- Folding (nvim-ufo)
vim.opt.foldcolumn = "1"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true

-- Jumplist (portal.nvim)
vim.opt.jumpoptions = "stack"

-- Disable comment continuation
vim.opt.formatoptions:remove("o") -- Don't continue after 'o' or 'O'
vim.opt.formatoptions:remove("r") -- Don't continue after <cr>
