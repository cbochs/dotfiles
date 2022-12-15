-- Repo: https://github.com/akinsho/toggleterm.nvim
-- Description: Toggleable terminal

return {
    "akinsho/toggleterm.nvim",
    config = function()
        local ok, toggleterm = pcall(require, "toggleterm")
        if not ok then
            return
        end
        toggleterm.setup({
            direction = "float",
        })
    end,
}
