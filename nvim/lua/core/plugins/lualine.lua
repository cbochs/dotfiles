-- Repo: https://github.com/nvim-lualine/lualine.nvim
-- Description: Statusline plugin

return {
    "nvim-lualine/lualine.nvim",
    after = {
        "gitsigns.nvim",
        "noice.nvim",
    },
    config = function()
        local ok, lualine = pcall(require, "lualine")
        if not ok then
            return
        end

        -- Only show the jira associated with the branch
        -- PORTAL-XXXXX = 12 characters
        local function format_branch(str)
            return string.sub(str, 1, 12)
        end

        lualine.setup({
            options = {
                theme = "kanagawa",
                globalstatus = true,
                component_separators = "",
                section_separators = "",
            },
            sections = {
                lualine_a = {
                    "mode",
                },
                lualine_b = {
                    {
                        function()
                            local key = require("grapple").key()
                            return "  [" .. key .. "]"
                        end,
                        cond = require("grapple").exists,
                    },
                },
                lualine_c = {},
                lualine_x = {
                    {
                        require("noice").api.statusline.mode.get,
                        cond = require("noice").api.statusline.mode.has,
                        color = { fg = "#ff9e64" },
                    },
                    { "branch", fmt = format_branch },
                },
                lualine_y = {
                    { "filetype", icon = false },
                    "location",
                },
                lualine_z = {
                    { "filename", file_status = true },
                },
            },
            winbar = {},
        })
    end,
}
