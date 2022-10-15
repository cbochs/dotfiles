-- Statusbar
-- Repo: https://github.com/feline-nvim/feline.nvim

local M = {}

M.Details = function()
    return {
        "feline-nvim/feline.nvim",
        after = {
            "catppuccin",
            "gitsigns.nvim",
        },
        config = M.Setup,
    }
end

M.Setup = function()
    local feline = require("feline")
    local components = require("catppuccin.groups.integrations.feline")

    components.setup()
    feline.setup({
        components = components.get()
    })
end

return M
