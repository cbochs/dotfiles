-- Quick Jumplist Navigation
-- Repo: https://github.com/cbochs/portal.nvim

local M = {}

M.Details = function()
    return {
        "cbochs/portal.nvim",
        requires = {
            "cbochs/grapple.nvim",
        },
        config = M.Setup,
    }
end

M.Setup = function()
    local portal = require("portal")
    local grapple = require("grapple")

    portal.setup({
        query = { "different", "grapple" },
        escape = {
            ["<c-j>"] = true
        },
        integrations = {
            grapple = true,
        },
    })
    grapple.setup({
        scope = "directory"
    })

    vim.keymap.set("n", "<leader>o", portal.jump_backward, {})
    vim.keymap.set("n", "<leader>i", portal.jump_forward, {})
    vim.keymap.set("n", "<leader>m", grapple.toggle, {})
    vim.keymap.set("n", "<leader>M", grapple.reset, {})
    vim.keymap.set("n", "<leader>j", grapple.cycle_forward, {})
end

return M
