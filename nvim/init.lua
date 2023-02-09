-- Reference: https://neovim.io/doc/user/lua.html
-- Example: https://github.com/martinsione/dotfiles/tree/master/src/.config/nvim

vim.g.mapleader = " "

require("core.options")
require("core.autocmds")
require("core.keymaps")
require("core.filetypes")

require("core.lazy")

-- require("core.plugins").startup()
require("core.commands")

vim.cmd.colorscheme("kanagawa")
