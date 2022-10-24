-- Quick Buffer Navigation
-- Repo: https://github.com/cbochs/grapple.nvim

local M = {}

M.Details = function()
    return {
        "cbochs/grapple.nvim",
        config = M.Setup,
    }
end

M.Setup = function()
    local grapple = require("grapple")
    grapple.setup()

    vim.keymap.set("n", "<leader>j", function() grapple.select({ name = "Jacob" }) end, {})
    vim.keymap.set("n", "<leader>J", function() grapple.toggle({ name = "Jacob" }) end, {})

    vim.keymap.set("n", "<leader>k", function() grapple.select({ name = "Kelvin" }) end, {})
    vim.keymap.set("n", "<leader>K", function() grapple.toggle({ name = "Kelvin" }) end, {})

    vim.keymap.set("n", "<leader>l", function() grapple.select({ name = "Leibniz" }) end, {})
    vim.keymap.set("n", "<leader>L", function() grapple.toggle({ name = "Leibniz" }) end, {})

    vim.keymap.set("n", "<leader>o", function() grapple.jump_backward() end, {})
    vim.keymap.set("n", "<leader>i", function() grapple.jump_forward() end, {})
end

return M
