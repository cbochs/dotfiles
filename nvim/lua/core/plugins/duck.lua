-- Companion Character
-- Repo: https://github.com/tamton-aquib/duck.nvim

local M = {}

M.Details = function()
    return {
        "tamton-aquib/duck.nvim",
        config = M.Setup,
    }
end

M.Setup = function()
    local duck = require("duck")
    duck.setup({
        character = "🐤",
        speed = -100,
        width = 2,
        height = 1,
    })
    vim.keymap.set("n", "<leader>xu", duck.hatch, { silent = true })
    vim.keymap.set("n", "<leader>xd", duck.cook, { silent = true })
end

return M
