return {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_)
        local icons = require("lazyvim.config").icons

        return {
            options = {
                theme = "auto",
                globalstatus = true,
                disabled_filetypes = { statusline = { "dashboard", "lazy", "alpha", "grapple" } },
                component_separators = "",
                section_separators = "",
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "grapple" },
                lualine_c = {},
                lualine_x = {
                    {
                        function()
                            return require("noice").api.status.mode.get()
                        end,
                        cond = function()
                            return package.loaded["noice"] and require("noice").api.status.mode.has()
                        end,
                    },
                    {
                        "diff",
                        symbols = {
                            added = icons.git.added,
                            modified = icons.git.modified,
                            removed = icons.git.removed,
                        },
                    },
                    {
                        "branch",
                        fmt = function(str)
                            return string.sub(str, 1, 12)
                        end,
                    },
                },
                lualine_y = {
                    "location",
                    { "filetype", icons_enabled = false },
                },
                lualine_z = {
                    { "filename", file_status = true },
                },
            },
        }
    end,
}
