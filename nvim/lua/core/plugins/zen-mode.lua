-- Repos:
-- - https://github.com/folke/zen-mode.nvim
-- - https://github.com/folke/twilight.nvim
-- Description:
-- Added: Dec 15, 2022

return {
    "folke/zen-mode.nvim",
    requires = "folke/twilight.nvim",
    config = function()
        local ok, _ = pcall(require, "zen-mode")
        if not ok then
            return
        end

        require("twilight").setup({
            context = 20,
        })

        require("zen-mode").setup({
            window = {
                options = {
                    colorcolumn = "",
                    number = false,
                    relativenumber = false,
                    signcolumn = "no",
                },
            },
            plugins = {
                gitsigns = { enabled = true },
            },
        })

        -- Personal zen mode
        vim.keymap.set("n", "zm", require("zen-mode").toggle, { silent = true })

        -- Pairing zen mode
        vim.keymap.set("n", "zM", function()
            require("zen-mode").toggle({
                window = {
                    options = {
                        colorcolumn = "100",
                        number = true,
                        signcolumn = "yes",
                    },
                },
                plugins = {
                    gitsigns = { enabled = false },
                    twilight = { enabled = false },
                },
            })
        end, { silent = true })
    end,
}
