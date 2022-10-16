-- Plugins
-- Reference: https://github.com/wbthomason/packer.nvim

local M = {}

M.Plugins = {
    "catppuccin",           -- colour theme
    "comment",              -- comment out lines
    "lualine",              -- statusbar
    "gitsigns",             -- git information
    "leap",                 -- buffer navigation
    "marks",                -- mark highlight
    "mason",                -- lsp server installer
    "modes",                -- cursorline highlighting
    -- "noice",                -- overhauled ui
    "nvim-cmp",             -- auto completion
    "nvim-surround",        -- smart parenthesis
    "nvim-treesitter",      -- syntax highlighting
    "telescope",            -- fuzzy search
    "telescope-fzf-native", -- fzf integration
    "toggleterm",           -- integrated terminal
    -- "which-key"          -- keymap hints
}

M.Startup = function(plugins)
    return require("packer").startup(function()
        use "wbthomason/packer.nvim"
        use "kyazdani42/nvim-web-devicons"

        for _, plugin_name in ipairs(plugins) do
            use(require("core.plugins." .. plugin_name).Details())
        end
    end)
end

return M
