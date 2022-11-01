-- Quick Jumplist Navigation
-- Repo: https://github.com/cbochs/portal.nvim

local M = {}

M.Details = function()
    return {
        "cbochs/portal.nvim",
        config = M.Setup,
    }
end

M.Setup = function()
    local portal = require("portal")
    local tag = require("portal.tag")

    portal.setup({
        jump = {
            query = { "tagged", "different" },
            labels = {
                escape = {
                    ["<c-j>"] = true
                }
            }
        }
    })

    vim.keymap.set("n", "<leader>o", portal.jump_backward, {})
    vim.keymap.set("n", "<leader>i", portal.jump_forward, {})
    vim.keymap.set("n", "<leader>m", tag.toggle, {})
end

return M
