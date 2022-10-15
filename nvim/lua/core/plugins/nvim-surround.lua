-- Smart Parenthesis
-- Repo: https://github.com/kylechui/nvim-surround

local M = {}

M.Details = function()
    return {
        "kylechui/nvim-surround",
        config = function()
            require("nvim-surround").setup({})
        end,
    }
end

return M
