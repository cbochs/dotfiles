return {
    "jackMort/ChatGPT.nvim",
    keys = {
        { "<leader>gpt", "<cmd>ChatGPT<cr>" },
    },
    dependencies = {
        "MunifTanjim/nui.nvim",
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
    },
    config = true,
}
