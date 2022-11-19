-- Colour Theme
-- Repo: https://github.com/shaunsingh/oxocarbon.nvim

local M = {}

M.Details = function()
    return {
        "shaunsingh/oxocarbon.nvim",
        run = "./install.sh",
        config = function()
            vim.cmd.colorscheme("oxocarbon")
        end,
    }
end

return M
