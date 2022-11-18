-- File Navigation As A Buffer
-- Repo: https://github.com/ggandor/leap.nvim

local M = {}

M.Details = function()
    return {
        "elihunter173/dirbuf.nvim",
        config = function()
            require("dirbuf").setup({
                sort_order = "directories_first",
            })
        end,
    }
end

return M
