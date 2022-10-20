-- Git Status Information
-- Repo: https://github.com/lewis6991/gitsigns.nvim

local M = {}

M.Details = function()
    return {
        "lewis6991/gitsigns.nvim",
        config = M.Setup,
    }
end

M.Setup = function()
    require("gitsigns").setup({
        on_attach = function(bufnr)
            local gitsigns = require("gitsigns")
            local default_opts = { buffer = bufnr, silent = true }

            vim.keymap.set("n", "<leader>gb", gitsigns.toggle_current_line_blame, default_opts)
            vim.keymap.set("n", "<leader>gd", gitsigns.diffthis, default_opts)
            vim.keymap.set("n", "<leader>gs", ":diffput<cr>", default_opts)
        end
    })
end

return M
