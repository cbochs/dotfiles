-- Reference: https://github.com/wbthomason/packer.nvim

local plugins = {}


-- stylua: ignore start
plugins.packages = {
    "diffview",        -- git merge tool
    "dirbuf",          -- simple file explorer
    "gitsigns",        -- git information
    "grapple",         -- quick file navigation
    "leap",            -- file navigation
    "lualine",         -- statusbar
    "mason",           -- lsp server installer
    "mini",            -- assortment of plugins
    "neodev",          -- better neovim environment
    "noice",           -- overhauled ui
    "null-ls",         -- lsp linting and formatting
    "nvim-bqf",        -- better quickfix menu
    "nvim-cmp",        -- auto completion
    "nvim-surround",   -- smart parenthesis
    "nvim-treesitter", -- syntax highlighting
    "portal",          -- jump navigation
    "substitute",      -- text replacement
    "telescope",       -- fuzzy search
    "toggleterm",      -- integrated terminal

    -- colour themes
    "catppuccin",
    "kanagawa",
    "oxocarbon",
}
-- stylua: ignore end

function plugins.startup(packages)
    packages = packages or plugins.packages

    return require("packer").startup(function()
        use("wbthomason/packer.nvim")
        use("kyazdani42/nvim-web-devicons")

        for _, plugin_name in ipairs(packages) do
            local ok, plugin = pcall(require, "core.plugins." .. plugin_name)
            if ok then
                use(plugin)
            else
                print(string.format("No module file found for %s", plugin_name))
            end
        end
    end)
end

return plugins
