-- Repo: https://github.com/kylechui/nvim-surround
-- Description: Surround textobject with parentheses motions

return {
    "kylechui/nvim-surround",
    config = function()
        local ok, surround = pcall(require, "nvim-surround")
        if not ok then
            return
        end
        surround.setup({})
    end,
}
