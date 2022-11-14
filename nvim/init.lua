-- Reference: https://neovim.io/doc/user/lua.html
-- Example: https://github.com/martinsione/dotfiles/tree/master/src/.config/nvim

-- vim.lsp.set_log_level("debug")
vim.g.mapleader = " "

require("core.options")
require("core.autocmds")
require("core.keymaps")
require("core.filetypes")
-- require("core.centre_scroll")

local plugins = require("core.plugins")
plugins.Startup(plugins.Plugins)

require("core.commands")
require("core.languages")
