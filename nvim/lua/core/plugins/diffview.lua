-- Repo: https://github.com/sindrets/diffview.nvim
-- Description

return {
    "sindrets/diffview.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
        local ok, diffview = pcall(require, "diffview")
        if not ok then
            return
        end
        diffview.setup()
    end,
}
