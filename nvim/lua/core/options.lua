-- Options (vim.go, vim.bo, vim.wo, vim.o)
--
-- References:
-- - https://neovim.io/doc/user/options.html#options
-- - https://neovim.io/doc/user/lua.html
-- - https://neovim.io/doc/user/eval.html#variables
--
-- Help
-- - :help options
-- - :help set
-- - :help vim.opt

local o = vim.opt

-- Buffer Appearance
o.cmdheight     = 0
o.colorcolumn   = "80,100"
o.cursorline    = true
o.laststatus    = 0
o.termguicolors = true
o.wrap          = false

-- Buffer Options
o.hidden     = true
o.hlsearch   = false
o.mouse      = "a"
o.scrolloff  = 999
-- o.timeoutlen = 0
o.wrapscan   = true

-- Left Gutter
o.number         = true
o.relativenumber = true
o.signcolumn     = "yes"

-- Tabbing / Spacing
o.expandtab   = true -- convert tab press to spaces
o.shiftwidth  = 4    -- auto tab indentation
o.softtabstop = 4    -- manual tab indentation
o.tabstop     = 4    -- visual representation of <tab>

-- Backup / Swap
o.backup      = false -- disable file write backups
o.writebackup = false -- disable file write backups
o.swapfile    = false -- disable new file swapfile?

-- Statusline
o.ruler    = false
o.showmode = false

-- Split direction
o.splitbelow = true
o.splitright = true
