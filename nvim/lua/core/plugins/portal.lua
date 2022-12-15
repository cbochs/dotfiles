-- Repo: https://github.com/cbochs/portal.nvim
-- Description: Better jumplist navigation

return {
    "cbochs/portal.nvim",
    branch = "dev",
    -- branch = "main",
    config = function()
        local ok, portal = pcall(require, "portal")
        if not ok then
            return
        end

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
    end,
}
