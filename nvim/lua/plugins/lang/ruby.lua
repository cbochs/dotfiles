return {

    -- add ruby to treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        opts = function(_, opts)
            table.insert(opts.ensure_installed, "ruby")
        end,
    },

    -- setup lspconfig for Ruby
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                solargraph = {
                    mason = false,
                    initialization_options = {
                        autoformat = true,
                        diagnostics = true,
                        formatting = true,
                    },
                },
                -- ruby_ls = {
                --     mason = false,
                --     initializationOptions = {
                --         enabledFeatures = {
                --             documentSymbol = true,
                --             documentLink = true,
                --             hover = true,
                --             foldingRanges = true,
                --             selectionRanges = true,
                --             semanticHighlighting = true,
                --             formatting = true,
                --             onTypeFormatting = false,
                --             diagnostics = true,
                --             codeActions = true,
                --             codeActionResolve = true,
                --             documentHighlight = true,
                --             inlayHints = true,
                --             pathCompletion = true,
                --             codeLens = true,
                --         },
                --     },
                -- },
            },
            setup = {
                ruby_ls = function(server, server_opts)
                    require("lazyvim.util").on_attach(function(client, buffer)
                        local callback = function()
                            local params = vim.lsp.util.make_text_document_params(buffer)

                            client.request("textDocument/diagnostic", { textDocument = params }, function(err, result)
                                if err then
                                    return
                                end

                                vim.lsp.diagnostic.on_publish_diagnostics(
                                    nil,
                                    result,
                                    vim.tbl_extend("keep", params, { diagnostics = result.items }),
                                    { client_id = client.id }
                                )
                            end)
                        end

                        callback() -- call on attach

                        vim.api.nvim_create_autocmd(
                            { "BufEnter", "BufWritePre", "BufReadPost", "InsertLeave", "TextChanged" },
                            {
                                buffer = buffer,
                                callback = callback,
                            }
                        )
                    end)
                    require("lspconfig")[server].setup(server_opts)
                end,
            },
        },
    },

    -- -- setup rubocop formatting for ruby
    -- {
    --     "jose-elias-alvarez/null-ls.nvim",
    --     opts = function(_, opts)
    --         local nls = require("null-ls")
    --         opts.sources = vim.list_extend(opts.sources, {
    --             nls.builtins.formatting.rubocop,
    --         })
    --     end,
    -- },

    -- add "alternate" and "related" keybinds for Rails projects
    {
        "tpope/vim-rails",
        ft = "ruby",
        keys = {
            { "ga", "<cmd>A<cr>", desc = "Goto alternate file (Rails)" },
            { "gb", "<cmd>R<cr>", desc = "Goto related file (Rails)" },
        },
    },
}
