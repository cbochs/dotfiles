-- Repo: https://github.com/lewis6991/gitsigns.nvim
-- Description: Git status decorations and information

return {
    "lewis6991/gitsigns.nvim",
    config = function()
        local ok, gitsigns = pcall(require, "gitsigns")
        if not ok then
            return
        end

        gitsigns.setup({
            on_attach = function(bufnr)
                local default_opts = { buffer = bufnr, silent = true }
                vim.keymap.set("n", "<leader>gb", gitsigns.toggle_current_line_blame, default_opts)
                vim.keymap.set("n", "<leader>gd", gitsigns.diffthis, default_opts)
                vim.keymap.set("n", "<leader>gs", ":diffput<cr>", default_opts)
            end,
        })
    end,
}
