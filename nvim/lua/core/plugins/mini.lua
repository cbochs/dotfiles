-- Mini Plugins
-- Repo: https://github.com/echasnovski/mini.nvim

local M = {}

M.Details = function()
    return {
        "echasnovski/mini.nvim",
        config = M.Setup,
    }
end

M.Setup = function()
    require("mini.ai").setup({
        f = false,
    })
    require("mini.align").setup()
    require("mini.comment").setup({
        mappings = {
            comment_line = "<leader>c",
        },
    })
end

return M
