-- Mini Plugins
-- Repo: https://github.com/echasnovski/mini.nvim

local M = {}

M.Details = function()
    return {
        "echasnovski/mini.nvim",
        config = M.Setup
    }
end

M.Setup = function()
    require("mini.ai").setup()
end

return M
