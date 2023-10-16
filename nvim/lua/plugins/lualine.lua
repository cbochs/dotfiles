return {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_)
        local icons = require("lazyvim.config").icons

        local function fg(name)
            return function()
                local hl = vim.api.nvim_get_hl(0, { name = name })
                return hl and hl.foreground and { fg = string.format("#%06x", hl.foreground) }
            end
        end

        return {
            options = {
                theme = "auto",
                globalstatus = true,
                disabled_filetypes = { statusline = { "dashboard", "lazy", "alpha", "grapple" } },
                component_separators = "",
                section_separators = "",
            },
            sections = {
                lualine_a = {
                    "mode",
                },
                lualine_b = {
                    "diagnostics",
                },
                lualine_x = {
                    {
                        function()
                            return require("noice").api.status.mode.get()
                        end,
                        cond = function()
                            return package.loaded["noice"] and require("noice").api.status.mode.has()
                        end,
                        color = fg("Constant"),
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
                    { "filetype", icon = false },
                    "location",
                },
                lualine_z = {
                    { "filename", file_status = true },
                },
            },
            extensions = { "neo-tree" },
        }
    end,
}
