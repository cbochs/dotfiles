-- Keymap Hints
-- Repo: https://github.com/folke/which-key.nvim

local M = {}

M.details = function()
    return { "folke/which-key.nvim" }
end

M.setup = function()
    require("which-key").setup({})
end

return M
