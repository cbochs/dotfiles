-- Git Status Information
-- Repo: https://github.com/lewis6991/gitsigns.nvim

local M = {}

M.Details = function()
    return {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup()
        end,
    }
end

return M
