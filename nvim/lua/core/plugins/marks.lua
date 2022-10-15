-- Mark Highlighting
-- Repo:

local M = {}

M.Details = function()
    return {
        "chentoast/marks.nvim",
        config = function()
            require("marks").setup({})
        end,
    }
end

return M
