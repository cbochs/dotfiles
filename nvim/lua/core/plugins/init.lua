-- Plugins
-- Reference: https://github.com/wbthomason/packer.nvim

local M = {}

M.Plugins = {
    "catppuccin",           -- colour theme
    "comment",              -- comment out lines
    "duck",                 -- a waddling companion
    "lualine",              -- statusbar
    "gitsigns",             -- git information
    "grapple",              -- buffer navigation
    "leap",                 -- file navigation
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

function M.Startup(plugins)
    return require("packer").startup(function()
        use "wbthomason/packer.nvim"
        use "kyazdani42/nvim-web-devicons"

        for _, plugin_name in ipairs(plugins) do
            use(require("core.plugins." .. plugin_name).Details())
        end
    end)
end

return M
