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
    require("notify").setup({
        render = "minimal",
        stages = "static",
        timeout = 1000,
    })

    require("noice").setup({
        lsp = {
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = true,
            },
        },
        presets = {
            bottom_search = true,
            command_palette = true,
            long_message_to_split = true,
            inc_rename = false,
            lsp_doc_border = false,
        },
        routes = {
            { -- filter annoying buffer messages
                filter = {
                    event = "msg_show",
                    kind = "",
                    any = {
                        { find = "written" },
                        { find = "line less" },
                        { find = "fewer lines" },
                        { find = "more line" },
                        { find = "change; before" },
                        { find = "change; after" },
                    },
                },
                opts = { skip = true },
            },
            {
                filter = {
                    event = "msg_show",
                    kind = "search_count",
                },
                opts = { skip = true },
            },
        },
    })
end

return M
