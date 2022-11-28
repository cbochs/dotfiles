-- Plugins
-- Reference: https://github.com/wbthomason/packer.nvim

local M = {}

-- stylua: ignore start
M.Plugins = {
    "dirbuf",               -- simple file explorer
    "gitsigns",             -- git information
    "grapple",              -- quick file navigation
    "leap",                 -- file navigation
    "lualine",              -- statusbar
    "mason",                -- lsp server installer
    "mini",                 -- assortment of plugins
    "neodev",               -- better neovim environment
    "noice",                -- overhauled ui
    "null-ls",              -- lsp linting and formatting
    "nvim-cmp",             -- auto completion
    "nvim-surround",        -- smart parenthesis
    "nvim-treesitter",      -- syntax highlighting
    "nvim-bqf",             -- better quickfix menu
    "portal",               -- jump navigation
    "telescope",            -- fuzzy search
    "toggleterm",           -- integrated terminal

    -- colour themes
    "catppuccin",
    -- "oxocarbon",
}
-- stylua: ignore end

function M.Startup(plugins)
    return require("packer").startup(function()
        use("wbthomason/packer.nvim")
        use("kyazdani42/nvim-web-devicons")

        for _, plugin_name in ipairs(plugins) do
            local ok, plugin = pcall(require, "core.plugins." .. plugin_name)
            if ok then
                use(plugin.Details())
            else
                print("Unable to load plugin: " .. plugin_name)
            end
        end
    end)
end

return M