-- Toggle Terminal
-- Repo: https://github.com/akinsho/toggleterm.nvim

local M = {}

M.Details = function()
    return {
        "akinsho/toggleterm.nvim",
        config = M.Setup,
    }
end

M.Setup = function()
    require("toggleterm").setup({
        direction = "float",
    })
end

return M
