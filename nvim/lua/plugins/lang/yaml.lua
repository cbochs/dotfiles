return {

    -- add yaml to treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        opts = function(_, opts)
            table.insert(opts.ensure_installed, "yaml")
        end,
    },

    -- setup lspconfig for yaml
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                yamlls = {
                    settings = {
                        yaml = {
                            keyOrdering = false,
                            schemas = {
                                ["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json"] = "/*",
                                -- ["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.0/schema.json"] = "/*",
                            },
                            schemaStore = {
                                url = "https://www.schemastore.org/api/json/catalog.json",
                            },
                        },
                    },
                },
            },
            setup = {
                yamlls = function(_, _)
                    -- TODO: Remove me once we've moved to OAS 3.1.0
                    require("lazyvim.util").on_attach(function(client, _)
                        if client.name == "yamlls" then
                            vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
                                function(_, result, ctx, config)
                                    result.diagnostics = vim.tbl_filter(function(diagnostic)
                                        return (diagnostic.source:find("yaml-schema") or 0) > 0
                                    end, result.diagnostics)
                                    vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx, config)
                                end,
                                {}
                            )
                            -- local ns = vim.lsp.diagnostic.get_namespace(client.id)
                            -- vim.diagnostic.disable(nil, ns)
                        end
                    end)
                end,
            },
        },
    },

    -- setup OpenAPI linting for yaml
    {
        "jose-elias-alvarez/null-ls.nvim",
        dir = "~/git_personal/null-ls.nvim",
        opts = function(_, opts)
            local nls = require("null-ls")
            opts.sources = vim.list_extend(opts.sources, {
                nls.builtins.diagnostics.vacuum.with({
                    extra_args = {
                        "--ruleset",
                        "/Users/cbochula@cisco.com/git/janus-rails/.vacuum.yaml",
                        -- "janus-rails/.vacuum.yaml",
                    },
                }),
            })
        end,
    },
}
