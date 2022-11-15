-- Plugins
-- Reference: https://github.com/wbthomason/packer.nvim

local M = {}

-- stylua: ignore start
M.Plugins = {
    "catppuccin",           -- colour theme
    "duck",                 -- a waddling companion
    "lualine",              -- statusbar
    "gitsigns",             -- git information
    "leap",                 -- file navigation
    "marks",                -- mark highlight
    "mason",                -- lsp server installer
    "mini",                 -- assortment of plugins
    "modes",                -- cursorline highlighting
    "noice",                -- overhauled ui
    "neodev",               -- better neovim environment
    "nvim-cmp",             -- auto completion
    "nvim-surround",        -- smart parenthesis
    "nvim-treesitter",      -- syntax highlighting
    "null-ls",              -- lsp linting and formatting
    "portal",               -- jump navigation
    "telescope",            -- fuzzy search
    "telescope-fzf-native", -- fzf integration
    "toggleterm",           -- integrated terminal
}
-- stylua: ignore end

function M.Startup(plugins)
    return require("packer").startup(function()
        use("wbthomason/packer.nvim")
        use("kyazdani42/nvim-web-devicons")

        for _, plugin_name in ipairs(plugins) do
            use(require("core.plugins." .. plugin_name).Details())
        end
    end)
end

return M
