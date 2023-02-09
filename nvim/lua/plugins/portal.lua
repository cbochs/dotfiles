-- Repo: https://github.com/cbochs/portal.nvim
-- Description: Better jumplist navigation

return {
    "cbochs/portal.nvim",
    branch = "main",
    keys = {
        { "<leader>o", "<cmd>lua require('portal').jump_backward()<cr>", desc = "Portal jump backwards" },
        { "<leader>i", "<cmd>lua require('portal').jump_forward()<cr>", desc = "Portal jump forwards" },
    },
    config = {
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
    },
}
