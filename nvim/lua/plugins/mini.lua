return {
    "echasnovski/mini.nvim",
    event = "BufReadPre",
    config = function()
        -- Adds "q" (quote) and "b" (bracket) textobjects
        require("mini.ai").setup({ f = false })

        -- Adds visual "ga" and "gA" alignment keymaps
        require("mini.align").setup()

        -- Simple commenting
        require("mini.comment").setup({
            mappings = {
                comment_line = "<leader>c",
            },
        })
    end,
}
