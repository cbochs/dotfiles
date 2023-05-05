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
                    initializationOptions = {
                        autoformat = true,
                        diagnostics = true,
                        formatting = true,
                    },
                },
                -- ruby_ls = {
                --     mason = false,
                --     initializationOptions = {
                --         enabledFeatures = {
                --             codeActionResolve = true,
                --             codeActions = true,
                --             codeLens = true,
                --             diagnostics = true,
                --             documentHighlight = true,
                --             documentLink = true,
                --             documentSymbol = true,
                --             foldingRanges = true,
                --             formatting = true,
                --             hover = true,
                --             inlayHints = true,
                --             onTypeFormatting = false,
                --             pathCompletion = true,
                --             selectionRanges = true,
                --             semanticHighlighting = true,
                --         },
                --     },
                -- },
            },
            setup = {
                ruby_ls = function(server, server_opts)
                    require("lazyvim.util").on_attach(function(client, buffer)
                        local diagnostic_handler = function()
                            local params = vim.lsp.util.make_text_document_params(buffer)
                            client.request("textDocument/diagnostic", { textDocument = params }, function(err, result)
                                if err then
                                    local err_msg = string.format("ruby-lsp - diagnostics error - %s", vim.inspect(err))
                                    vim.notify(err_msg)
                                end
                                if not result then
                                    return
                                end
                                vim.lsp.diagnostic.on_publish_diagnostics(
                                    nil,
                                    vim.tbl_extend("keep", params, { diagnostics = result.items }),
                                    { client_id = client.id }
                                )
                            end)
                        end

                        diagnostic_handler()

                        local ruby_group = vim.api.nvim_create_augroup("ruby_ls", { clear = false })
                        vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePre", "InsertLeave", "TextChanged" }, {
                            buffer = buffer,
                            callback = diagnostic_handler,
                            group = ruby_group,
                        })
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
