vim.g.lazygit_config = false
vim.g.snacks_animate = false

-- Default expand with 4 spaces
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4

-- Preview commands in split
vim.opt.inccommand = "split"

-- Folding (nvim-ufo)
vim.opt.foldcolumn = "1"
vim.opt.foldenable = true
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99

-- Formatting options
-- See:
--   :h formatoptions
--   :h fo-table
--   :h textwidth
-- vim.opt.textwidth = 80
-- vim.opt.formatoptions:remove("o") -- Don't continue after 'o' or 'O'
-- vim.opt.formatoptions:remove("r") -- Don't continue after <cr>
