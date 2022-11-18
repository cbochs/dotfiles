-- Plugins
-- Reference: https://github.com/wbthomason/packer.nvim

local M = {}

-- stylua: ignore start
M.Plugins = {
    "dirbuf",               -- simple file explorer
    "catppuccin",           -- colour theme
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
    "portal",               -- jump navigation
    "telescope",            -- fuzzy search
    "toggleterm",           -- integrated terminal
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
                vim.warn("Unable to load plugin: " .. plugin_name)
            end
        end
    end)
end

return M
