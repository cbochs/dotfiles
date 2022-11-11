-- Improve Telescope performance
-- Repo:

local M = {}

M.Details = function()
    return {
        "nvim-telescope/telescope-fzf-native.nvim",
        run = "make",
    }
end

return M
