-- Reference: https://neovim.io/doc/user/lua.html
-- Example: https://github.com/martinsione/dotfiles/tree/master/src/.config/nvim

vim.g.mapleader = " "

require("core.options")
require("core.autocmds")
require("core.keymaps")
require("core.filetypes")
-- require("core.centre_scroll")

require("core.plugins").startup()

require("core.commands")
require("core.languages")

vim.cmd.colorscheme("catppuccin")
