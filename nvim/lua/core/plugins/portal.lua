-- Quick Jumplist Navigation
-- Repo: https://github.com/cbochs/portal.nvim

local M = {}

M.Details = function()
    return {
        "cbochs/portal.nvim",
        branch = "main",
        requires = {
            "ThePrimeagen/harpoon",
        },
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
    vim.api.nvim_set_hl(0, "PortalBorder", { fg = "#fab387" })
    vim.api.nvim_set_hl(0, "PortalBorderNone", { fg = "#89b4fa" })

    vim.keymap.set("n", "<leader>o", portal.jump_backward, {})
    vim.keymap.set("n", "<leader>i", portal.jump_forward, {})
end

return M
