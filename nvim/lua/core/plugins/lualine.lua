-- Statusbar
-- Repo: https://github.com/nvim-lualine/lualine.nvim

local M = {}

M.Details = function()
    return {
        "nvim-lualine/lualine.nvim",
        after = {
            "catppuccin",
            "gitsigns.nvim",
        },
        config = M.Setup,
    }
end

M.Setup = function()
    vim.api.nvim_cmd(
        { cmd = "highlight", args = { "LualineCustomLspInactive", "guifg=#313244"} },
        { output = false }
    )
    vim.api.nvim_cmd(
        { cmd = "highlight", args = { "LualineCustomLspActive", "guifg=#a6e3a1"} },
        { output = false }
    )

    local marked_status = function()
        local marks = require("grapple.marks")
        local config = require("grapple.config")
        local hl_group = "LualineCustomLspInactive"
        local text  = "[U]"

        local mark_key = marks.find_key(config.project_root, { buffer = 0 })
        if mark_key ~= nil then
            hl_group = "LualineCustomLspActive"
            text  = "[" .. string.sub(tostring(mark_key), 1, 1) .. "]"
        end

        return "%#" .. hl_group .. "#" .. text .. "%*"
    end

    local lsp_status = function()
        local attached_lsp = vim.lsp.get_active_clients()
        local hl_group = "LualineCustomLspInactive"
        local text  = "●"

        if #attached_lsp > 0 then
            hl_group = "LualineCustomLspActive"
            text = text .. " [" .. attached_lsp[1].name .. "]"
        end

        return "%#" .. hl_group .. "#" .. text .. "%*"
    end

    -- Only show the jira associated with the branch
    -- PORTAL-XXXXX = 12 characters
    local format_branch = function(str)
        return string.sub(str, 1, 12)
    end

    require("lualine").setup({
        options = {
            theme = "catppuccin",
            globalstatus = true,
            component_separators = "",
            section_separators = "",
        },
        sections = {
            lualine_a = { "mode" },
            lualine_b = { marked_status, lsp_status,  "diagnostics" },
            lualine_c = { },
            lualine_x = { { "branch", fmt = format_branch } },
            lualine_y = { "filetype", "location" },
            lualine_z = { { "filename", file_status = false } },
        },
        winbar = {}
    })
end

return M
