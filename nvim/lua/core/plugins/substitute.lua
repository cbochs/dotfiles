-- Repo: https://github.com/gbprod/substitute.nvim
-- Description: Text replacement
-- Added: Dec 13, 2022

local M = {}

M.Details = function()
    return {
        "gbprod/substitute.nvim",
        config = function()
            local ok, substitute = pcall(require, "substitute")
            if not ok then
                return
            end
            substitute.setup({})

            vim.keymap.set("n", "r", substitute.operator, { silent = true })
            vim.keymap.set("n", "rr", substitute.line, { silent = true })
            vim.keymap.set("n", "R", substitute.eol, { silent = true })
            vim.keymap.set("x", "r", substitute.visual, { silent = true })
        end,
    }
end

return M
