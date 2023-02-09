local function setup_diagnostics()
    local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

    -- Automatically update diagnostics
    vim.diagnostic.config({
        underline = true,
        update_in_insert = false,
        virtual_text = { spacing = 4, prefix = "●" },
        severity_sort = true,
    })

    for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end
end

local function setup_formatting(client, bufnr)
    if client.name ~= "null-ls" then
        return
    end

    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = "LspFormat", buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = "LspFormat",
            buffer = bufnr,
            callback = function(c)
                vim.lsp.buf.format({ filter = c.name == "null-ls" })
            end,
        })
    end
end

local function setup_keymaps(_client, bufnr)
    local keymap = vim.keymap.set
    local buffer_opts = { silent = true, noremap = true, buffer = bufnr }

    local builtin = require("telescope.builtin")

    keymap("n", "gD", builtin.lsp_type_definitions, buffer_opts)
    keymap("n", "gS", builtin.lsp_workspace_symbols, buffer_opts)
    keymap("n", "gd", builtin.lsp_definitions, buffer_opts)
    keymap("n", "gi", builtin.lsp_implementations, buffer_opts)
    keymap("n", "gr", builtin.lsp_references, buffer_opts)
    keymap("n", "gs", builtin.lsp_document_symbols, buffer_opts)
    keymap("n", "gS", builtin.lsp_workspace_symbols, buffer_opts)

    keymap("n", "K", vim.lsp.buf.hover, buffer_opts)
    keymap("n", "ga", vim.lsp.buf.code_action, buffer_opts)
    keymap("n", "gf", vim.lsp.buf.format, buffer_opts)
    keymap("n", "<leader>r", vim.lsp.buf.rename, buffer_opts)
    keymap("n", "]d", vim.diagnostic.goto_next, buffer_opts)
    keymap("n", "[d", vim.diagnostic.goto_prev, buffer_opts)
end

return {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = {
        { "folke/neodev.nvim", config = true },
    },
    config = function()
        require("mason")

        vim.api.nvim_create_augroup("LspFormat", { clear = true })

        local function on_attach(client, bufnr)
            setup_formatting(client, bufnr)
            setup_keymaps(client, bufnr)
        end

        local servers = {
            clangd = {},
            pyright = {},
            solargraph = {
                cmd = { "asdf", "exec", "solargraph", "stdio" },
            },
            sumneko_lua = {
                single_file_support = true,
                settings = {
                    Lua = {
                        completion = {
                            workspaceWord = true,
                            callSnippet = "Both",
                        },
                        diagnostics = { enable = false },
                        format = { enable = false },
                        telemetry = { enabled = false },
                        runtime = { version = "LuaJIT" },
                        workspace = {
                            checkThirdParty = false,
                            library = vim.api.nvim_get_runtime_file("", true),
                        },
                    },
                },
            },
        }

        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
        capabilities.textDocument.foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
        }

        local options = {
            on_attach = on_attach,
            capabilities = capabilities,
            flags = {
                debounce_text_changes = 150,
            },
        }

        for server, opts in pairs(servers) do
            opts = vim.tbl_deep_extend("force", {}, options, opts or {})
            require("lspconfig")[server].setup(opts)
        end

        -- require("plugins.rust-tools").setup(options)
        require("plugins.null-ls").setup(options)
    end,
}
