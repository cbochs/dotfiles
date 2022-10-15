-- Commenting
-- Repo: https://github.com/numToStr/Comment.nvim

local M = {}

M.Details = function()
    return {
        "numToStr/Comment.nvim",
        config = M.Setup,
    }
end

M.Setup = function()
    require("comment").setup({
        toggler = {
            line = "<leader>c",
        }
    })
end

return M
