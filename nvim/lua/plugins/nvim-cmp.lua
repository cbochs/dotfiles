local icons = {
    Class = " ",
    Color = " ",
    Constant = " ",
    Constructor = " ",
    Enum = "了 ",
    EnumMember = " ",
    Field = " ",
    File = " ",
    Folder = " ",
    Function = " ",
    Interface = "ﰮ ",
    Keyword = " ",
    Method = "ƒ ",

    Property = " ",
    Snippet = "﬌ ",
    Struct = " ",
    Text = " ",
    Unit = " ",
    Value = " ",
    Variable = " ",
}

local function cmp_format()
    return function(_entry, vim_item)
        if icons[vim_item.kind] then
            vim_item.kind = icons[vim_item.kind] .. vim_item.kind
        end
        return vim_item
    end
end

return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        -- Reference: https://github.com/hrsh7th/nvim-cmp/wiki/List-of-sources
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lsp-document-symbol",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        "hrsh7th/cmp-path",
        "saadparwaiz1/cmp_luasnip",
    },
    config = function()
        vim.o.completeopt = "menuone,noselect"

        local cmp = require("cmp")

        -- Buffer auto-completion
        cmp.setup({
            completion = {
                completeopt = "menu,menuone,noinsert",
            },
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end,
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            mapping = cmp.mapping.preset.insert({
                ["<c-e>"] = cmp.mapping.abort(),
                ["<c-f>"] = cmp.mapping.confirm({ select = true }),
                ["<c-n>"] = cmp.mapping.select_next_item(),
                ["<c-p>"] = cmp.mapping.select_prev_item(),
                ["<c-space>"] = cmp.mapping.complete(),
            }),
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "luasnip" },
                { name = "nvim_lsp_document_symbol" },
                { name = "nvim_lsp_signature_help" },
                { name = "buffer" },
            }),
            formatting = {
                format = cmp_format(),
            },
            experimental = {
                ghost_text = true,
            },
        })

        -- Search auto-completion
        cmp.setup.cmdline("/", {
            mapping = cmp.mapping.preset.cmdline({
                ["<c-e>"] = cmp.mapping.abort(),
                ["<c-f>"] = cmp.mapping.confirm({ select = true }),
            }),
            sources = cmp.config.sources({
                { name = "buffer" },
                { name = "path" },
            }),
        })

        -- Command auto-completion
        cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline({
                ["<c-e>"] = cmp.mapping.abort(),
                ["<c-f>"] = cmp.mapping.confirm({ select = true }),
            }),
            sources = cmp.config.sources({
                { name = "path" },
                { name = "cmdline" },
            }),
        })
    end,
}
