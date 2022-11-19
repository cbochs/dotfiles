-- Quick File Navigation & File Tagging
-- Repo: https://github.com/cbochs/grapple.nvim

local M = {}

M.Details = function()
    return {
        "cbochs/grapple.nvim",
        branch = "main",
        config = M.Setup,
    }
end

M.Setup = function()
    local grapple = require("grapple")

    grapple.setup({
        scope = function()
            local root_files = vim.fs.find(".git", { upward = true })
            if #root_files == 0 then
                -- Fallback to grapple's default
                return nil
            end
            return vim.fs.dirname(root_files[1])
        end,
    })

    vim.keymap.set("n", "<leader>m", grapple.toggle, {})
    vim.keymap.set("n", "<leader>M", grapple.reset, {})
    vim.keymap.set("n", "<leader>j", grapple.cycle_backward, {})
    vim.keymap.set("n", "<leader>k", grapple.popup_tags, {})
    vim.keymap.set("n", "<leader>K", grapple.popup_scopes, {})
end

return M
