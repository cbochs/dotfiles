-- Repo:
-- Description:

return {
    "rebelot/kanagawa.nvim",
    config = function()
        local ok, kanagawa = pcall(require, "kanagawa")
        if not ok then
            return
        end

        kanagawa.setup({
            dimInactive = true,
            globalStatus = true,
        })

        vim.cmd.colorscheme("kanagawa")
    end,
}
