-- Fancy UI
-- Repo: https://github.com/folke/noice.nvim

local M = {}

M.Details = function()
    return {
        "folke/noice.nvim",
        requires = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
        event = "VimEnter",
        config = M.Setup,
    }
end

M.Setup = function()
end

return M
