-- Quick File Navigation
-- Repo: https://github.com/ggandor/leap.nvim

local M = {}

M.Details = function()
    return {
        "ggandor/leap.nvim",
        requires = {
            "ggandor/flit.nvim",
            "ggandor/leap-ast.nvim",
        },
        config = M.Setup,
    }
end

M.Setup = function()
    local leap = require("leap")
    leap.setup({
        equivilence_classes = {
            " \t\r\n", -- space-like characters
            "([{",     -- opening braces
            ")]}",     -- closing braces
            "`\"'",    -- quote-like characters
        }
    })
    leap.add_default_mappings()

    require("flit").setup({})
end

return M
