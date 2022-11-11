-- Auto Completion
-- Repo: https://github.com/hrsh7th/nvim-cmp
-- Sources: https://github.com/hrsh7th/nvim-cmp/wiki/List-of-sources

local M = {}

M.Details = function()
    return {
        "hrsh7th/nvim-cmp",
        requires = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lsp-document-symbol",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-vsnip",
            "hrsh7th/vim-vsnip",
        },
        config = M.Setup,
    }
end

M.Setup = function()
    local cmp = require("cmp")

    -- Completion list options
    -- :h 'completeopt'
    vim.opt.completeopt = { "menu", "menuone", "noselect" }

    -- Buffer auto-completion
    cmp.setup({
        snippet = {
            expand = function(args)
                vim.fn["vsnip#anonymous"](args.body)
            end,
        },
        window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
            -- ["<esc>"] = cmp.mapping.close(),
            ["<c-e>"] = cmp.mapping.abort(),
            ["<c-@>"] = cmp.mapping.complete(),
            ["<c-f>"] = cmp.mapping.confirm({ select = true }),
            ["<c-n>"] = cmp.mapping.select_next_item(),
            ["<c-p>"] = cmp.mapping.select_prev_item(),
        }),
        sources = cmp.config.sources({
            -- Group 1
            { name = "nvim_lsp", max_item_count = 20 },
            { name = "nvim_lsp_signature_help" },
            { name = "vsnip" },
        }, {
            -- Group 2
            { name = "buffer", keyword_length = 2 },
        }),
        experimental = {
            ghost_text = true,
        },
    })

    -- Search auto-completion
    cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
            { name = "buffer", max_item_count = 20 },
            { name = "path", max_item_count = 20 },
        }),
    })

    -- Command auto-completion
    cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
            { name = "cmdline", max_item_count = 20 },
        }),
    })
end

return M
