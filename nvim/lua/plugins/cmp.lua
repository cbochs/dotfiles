if true then
    return {}
end

return {
    {
        "hrsh7th/nvim-cmp",
        opts = function(_, opts)
            local cmp = require("cmp")

            opts.window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            }

            opts.mapping = vim.tbl_extend("force", opts.mapping, {
                ["<C-F>"] = cmp.mapping.confirm({ select = true }),
                ["<CR>"] = cmp.config.disable,
                ["<S-CR>"] = cmp.config.disable,
                -- ["<S-Tab>"] = cmp.config.disable,
                -- ["<Tab>"] = cmp.config.disable,
            })

            opts.cmdline = {}
            opts.cmdline.command = {
                -- stylua: ignore
                -- mapping = cmp.mapping.preset.cmdline({
                --     ["<C-N>"] = function(fb) fb() end,
                --     ["<C-P>"] = function(fb) fb() end,
                -- }),
                sources = cmp.config.sources({
                    { name = "cmdline" },
                    { name = "path" },
                }),
            }
            opts.cmdline.search = {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({ { name = "buffer" } }),
            }
        end,
        config = function(_, opts)
            -- vim.pretty_print(opts)
            local cmp = require("cmp")
            cmp.setup(opts)
            -- cmp.setup.cmdline(":", opts.cmdline.command)
            -- cmp.setup.cmdline("/", opts.cmdline.search)
        end,
    },
}
