-- Repo: https://github.com/ggandor/leap.nvim
-- Description: Buffer-based file explorer

return {
    "elihunter173/dirbuf.nvim",
    config = function()
        local ok, dirbuf = pcall(require, "dirbuf")
        if not ok then
            return
        end

        dirbuf.setup({
            sort_order = "directories_first",
        })
    end,
}
