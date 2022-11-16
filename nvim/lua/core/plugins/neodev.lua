-- Better Neovim Development
-- Repo: https://github.com/folke/neodev.nvim

local M = {}

M.Details = function()
    return {
        "folke/neodev.nvim",
        config = function()
            require("neodev").setup()
        end,
    }
end

return M
