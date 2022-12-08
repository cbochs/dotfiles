local M = {}

M.Details = function()
    return {
        "rebelot/kanagawa.nvim",
        -- requires = {
        --     {
        --         "nvim-zh/colorful-winsep.nvim",
        --         config = function()
        --             require("colorful-winsep").setup()
        --         end,
        --     },
        -- },
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
end

return M
