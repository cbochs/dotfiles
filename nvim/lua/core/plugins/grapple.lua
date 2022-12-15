-- Repo: https://github.com/cbochs/grapple.nvim
-- Description: File tagging and navigation

return {
    "cbochs/grapple.nvim",
    branch = "dev",
    config = function()
        local ok, grapple = pcall(require, "grapple")
        if not ok then
            return
        end

        grapple.setup({
            scope = "git",
        })

        vim.keymap.set("n", "<leader>m", grapple.toggle, {})
        vim.keymap.set("n", "<leader>M", grapple.reset, {})
        vim.keymap.set("n", "<leader>j", grapple.cycle_forward, {})
        vim.keymap.set("n", "<leader>k", grapple.popup_tags, {})
        vim.keymap.set("n", "<leader>K", grapple.popup_scopes, {})
    end,
}
