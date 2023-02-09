-- Repo: https://github.com/jackMort/ChatGPT.nvim
-- Description:
-- Added: Dec 15, 2022

return {
    "jackMort/ChatGPT.nvim",
    requires = {
        "MunifTanjim/nui.nvim",
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
    },
    config = function()
        local ok, _ = pcall(require, "chatgpt")
        if not ok then
            return
        end
        require("chatgpt").setup()

        vim.keymap.set("n", "gpt", ":ChatGPT<cr>", { silent = true })
    end,
}
