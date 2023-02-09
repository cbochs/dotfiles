return {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    config = {
        on_attach = function(bufnr)
            gitsigns = require("gitsigns")
            local default_opts = { buffer = bufnr, silent = true }
            vim.keymap.set("n", "<leader>gb", gitsigns.toggle_current_line_blame, default_opts)
            vim.keymap.set("n", "<leader>gd", gitsigns.diffthis, default_opts)
            vim.keymap.set("n", "<leader>gs", ":diffput<cr>", default_opts)
        end,
    },
}
