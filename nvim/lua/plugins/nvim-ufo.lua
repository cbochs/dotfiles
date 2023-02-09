-- Repo: https://github.com/cbochs/portal.nvim
-- Description: Better jumplist navigation

return {
    "kevinhwang91/nvim-ufo",
    dependencies = {
        "kevinhwang91/promise-async",
    },
    keys = {
        "za",
        "zA",
        "zc",
        "zC",
        "zo",
        "zO",
        { "zR", "<cmd>lua require('ufo').openAllFolds()<cr>", desc = "Open folds" },
        { "zM", "<cmd>lua require('ufo').closeAllFolds()<cr>", desc = "Close folds" },
    },
    config = {
        provider_selector = function(_, _, _)
            return { "treesitter", "indent" }
        end,
    },
}
