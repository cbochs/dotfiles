-- Quick Jumplist Navigation
-- Repo: https://github.com/cbochs/portal.nvim

local M = {}

M.Details = function()
    return {
        "cbochs/portal.nvim",
        requires = {
            { "cbochs/grapple.nvim", branch = "main" },
        },
        config = M.Setup,
    }
end

M.Setup = function()
    local portal = require("portal")

    portal.setup({
        query = { "different", "grapple" },
        escape = {
            ["<c-j>"] = true
        },
        integrations = {
            grapple = true,
        },
    })

    local grapple = require("grapple")
    require("grapple.debug")
    grapple.setup({
        scope = "lsp",
        popup_options = {
            width = 80,
            height = 12,
        }
    })

    vim.keymap.set("n", "<leader>o", portal.jump_backward, {})
    vim.keymap.set("n", "<leader>i", portal.jump_forward, {})

    vim.keymap.set("n", "<leader>m", grapple.toggle, {})
    vim.keymap.set("n", "<leader>M", grapple.reset, {})
    vim.keymap.set("n", "<leader>j", grapple.cycle_backward, {})
    vim.keymap.set("n", "<leader>k", grapple.popup_tags, {})
    vim.keymap.set("n", "<leader>K", grapple.popup_scopes, {})
end

return M
