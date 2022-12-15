-- Repo: https://github.com/folke/which-key.nvim
-- Description: Keymap hints and descriptions

return {
    "folke/which-key.nvim",
    config = function()
        local ok, which_key = pcall(require, "which-key")
        if not ok then
            return
        end
        which_key.setup({})
    end,
}
