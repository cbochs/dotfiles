-- Keybindings
-- Reference: https://neovim.io/doc/user/api.html#nvim_set_keymap()

local keymap = vim.keymap.set
local default_opts = { silent = true }
local noremap_opts = { silent = true, noremap = true }
local remap_opts   = { silent = true, remap = true }

local NORMAL = "n"
local VISUAL = "v"
local INSERT = "i"
local TERM   = "t"

-- Leader keybindings
keymap(NORMAL, "<leader>w", ":w<cr>",   default_opts) -- write file
keymap(VISUAL, "<leader>y", '"+y',      default_opts) -- yank to clipboard
keymap(NORMAL, "<leader>z", "<c-z>",    noremap_opts) -- suspend nvim
keymap(NORMAL, "<leader>,", "",         default_opts) -- reload nvim
keymap(NORMAL, "<leader>/", ":noh<cr>", default_opts) -- clear search

keymap(NORMAL, "<leader>\"", 'ysiW"', remap_opts)
keymap(NORMAL, "<leader>'", "ysiW'",  remap_opts)
keymap(NORMAL, "<leader>)", "ysiW)",  remap_opts)
keymap(NORMAL, "<leader>{", "ysiW{",  remap_opts)
keymap(NORMAL, "<leader>[", "ysiW[",  remap_opts)

-- Janus-rails debug keybindings
keymap(NORMAL, "<leader>dj", ":JanusRspec<cr>", default_opts)

-- Toggle terminal keybindings
keymap(TERM,   "<c-j>",     "<c-\\><c-n>", noremap_opts)
keymap(NORMAL, "<leader>t", ":ToggleTerm<cr>", default_opts)

-- Escape keybindings
keymap(INSERT, "<c-j>", "<esc>", default_opts)
keymap(VISUAL, "<c-j>", "<esc>", default_opts)

-- Quit keybindings
local quit = require("core.keymaps.quit")
keymap(NORMAL, "<leader>q", quit.smart, default_opts) -- smart quit
keymap(NORMAL, "<leader>Q", ":qa<cr>", default_opts)  -- exit nvim

-- Window keybindings
keymap(NORMAL, "<c-h>",   "<c-w>h",      noremap_opts)
keymap(NORMAL, "<c-j>",   "<c-w>j",      noremap_opts)
keymap(NORMAL, "<c-k>",   "<c-w>k",      noremap_opts)
keymap(NORMAL, "<c-l>",   "<c-w>l",      noremap_opts)
keymap(NORMAL, "<c-s-j>", ":split<cr>",  default_opts)
keymap(NORMAL, "<c-s-l>", ":vsplit<cr>", default_opts)

-- Buffer keybindings (DISABLED)
keymap(NORMAL, "<c-b>h", ":bprevious<cr>", default_opts)
keymap(NORMAL, "<c-b>l", ":bnext<cr>",     default_opts)

-- Utility keybindings
keymap(NORMAL, "<cr>", "o<esc>", noremap_opts) -- add new line
keymap(NORMAL, "U",    "<c-r>",  noremap_opts) -- redo
keymap(NORMAL, "H",    "^",      noremap_opts) -- Go to: line beginning
keymap(NORMAL, "L",    "$",      noremap_opts) -- Go to: line ending
keymap(NORMAL, "x",    "\"_x",   noremap_opts) -- blackhole single chars
keymap(VISUAL, "<",    "<gv",    noremap_opts) -- indent line
keymap(VISUAL, ">",    ">gv",    noremap_opts) -- outdent line

-- Disable arrow keys
local all_modes = { NORMAL, VISUAL, INSERT }
keymap(all_modes, "<left>",  "", default_opts)
keymap(all_modes, "<up>",    "", default_opts)
keymap(all_modes, "<down>",  "", default_opts)
keymap(all_modes, "<right>", "", default_opts)
