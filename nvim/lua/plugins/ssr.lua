return {
    "cshuaimin/ssr.nvim",
    keys = {
        {
            "<leader>s",
            "<cmd>lua require('ssr').open()<cr>",
            mode = { "n", "x" },
            desc = "Structured search and replace",
        },
    },
}
