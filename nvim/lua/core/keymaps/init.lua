-- Keybindings
-- Reference: https://neovim.io/doc/user/api.html#nvim_set_keymap()

-- stylua: ignore start

local keymap = vim.keymap.set
local opts = { silent = true }
local remap = { silent = true, remap = true }

local NORMAL = "n"
local VISUAL = "v"
local INSERT = "i"
local TERM   = "t"
local ALL    = { NORMAL, VISUAL, INSERT }

-- Leader keybindings
keymap(NORMAL, "<leader>w", ":w<cr>",      opts) -- write file
keymap(NORMAL, "<leader>z", "<c-z>",       opts) -- suspend nvim
keymap(NORMAL, "<leader>,", "",            opts) -- reload nvim
keymap(NORMAL, "<leader>/", ":noh<cr>",    opts) -- clear search
keymap(NORMAL, "<leader>e", ":Dirbuf<cr>", opts)

-- Yank keybindings
keymap(NORMAL, "<leader>y", '"+y',         opts)
keymap(VISUAL, "<leader>y", '"+y',         opts)

keymap(NORMAL, '<leader>"', 'ysiW"', remap)
keymap(NORMAL, "<leader>'", "ysiW'", remap)
keymap(NORMAL, "<leader>)", "ysiW)", remap)
keymap(NORMAL, "<leader>{", "ysiW{", remap)
keymap(NORMAL, "<leader>[", "ysiW[", remap)

-- Janus-rails debug keybindings
keymap(NORMAL, "<leader>dj", ":JanusRspec<cr>", opts)

-- Toggle terminal keybindings
keymap(TERM,   "<c-j>",     "<c-\\><c-n>",     opts)
keymap(NORMAL, "<leader>t", ":ToggleTerm<cr>", opts)

-- Escape keybindings
keymap(INSERT, "<c-j>", "<esc>", opts)
keymap(VISUAL, "<c-j>", "<esc>", opts)

-- Quit keybindings
local quit = require("core.keymaps.quit")
keymap(NORMAL, "<leader>q", quit.smart, opts) -- smart quit
keymap(NORMAL, "<leader>Q", ":qa<cr>",  opts) -- exit nvim

-- Centring keybindings
keymap(NORMAL, "<c-u>", "<c-u>zz", opts)
keymap(NORMAL, "<c-d>", "<c-d>zz", opts)

-- Window keybindings
keymap(NORMAL, "<c-h>",   "<c-w>h",      opts)
keymap(NORMAL, "<c-j>",   "<c-w>j",      opts)
keymap(NORMAL, "<c-k>",   "<c-w>k",      opts)
keymap(NORMAL, "<c-l>",   "<c-w>l",      opts)
keymap(NORMAL, "<c-s-j>", ":split<cr>",  opts)
keymap(NORMAL, "<c-s-l>", ":vsplit<cr>", opts)

-- Utility keybindings
keymap(NORMAL, "<cr>",  "o<esc>",        opts) -- add new line
keymap(NORMAL, "U",     "<c-r>",         opts) -- redo
keymap(NORMAL, "H",     "_",             opts) -- Go to: line beginning
keymap(NORMAL, "L",     "$",             opts) -- Go to: line ending
keymap(NORMAL, "x",     '"_x',           opts) -- blackhole single chars
keymap(VISUAL, "<",     "<gv",           opts) -- indent line
keymap(VISUAL, ">",     ">gv",           opts) -- outdent line
keymap(VISUAL, "<s-j>", ":m '>+1<cr>gv", opts) -- move lin(s) down
keymap(VISUAL, "<s-k>", ":m '<-2<cr>gv", opts) -- move line(s) up

-- Disable arrow keys
keymap(ALL, "<left>",  "", opts)
keymap(ALL, "<up>",    "", opts)
keymap(ALL, "<down>",  "", opts)
keymap(ALL, "<right>", "", opts)

-- stylua: ignore end
