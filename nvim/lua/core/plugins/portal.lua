-- Quick Jumplist Navigation
-- Repo: https://github.com/cbochs/portal.nvim

local M = {}

M.Details = function()
    return {
        "cbochs/portal.nvim",
        branch = "dev",
        -- branch = "main",
        config = M.Setup,
    }
end

M.Setup = function()
    local portal = require("portal")

    portal.setup({
        query = { "different", "grapple" },
        escape = {
            ["<c-j>"] = true,
        },
        lookback = 10,
        portal = {
            render_empty = false,
            options = {
                border = "rounded",
            },
        },
    })

    vim.keymap.set("n", "<leader>o", portal.jump_backward, {})
    vim.keymap.set("n", "<leader>i", portal.jump_forward, {})
end

return M
