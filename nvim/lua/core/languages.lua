-- Language Servers & Diagnostics
-- References:
-- - https://neovim.io/doc/user/options.html#options
--
-- Help
-- - :help vim.lsp
-- - :help vim.lsp.buf (quickstart)
-- - :help vim.fs

vim.api.nvim_create_augroup("LspFormat", { clear = true })

local diagnostic_signs = { Error = "", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(diagnostic_signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

local on_attach = function(_, bufnr)
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
    keymap("n", "<c-n>", vim.diagnostic.goto_next, buffer_opts)
    keymap("n", "<c-p>", vim.diagnostic.goto_prev, buffer_opts)
    -- keymap("n", "<leader>l", vim.diagnostic.open_float, buffer_opts)

    vim.api.nvim_clear_autocmds({ group = "LspFormat", buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
        group = "LspFormat",
        buffer = bufnr,
        callback = function()
            vim.lsp.buf.format({
                buffer = bufnr,
                filter = function(client)
                    return client.name == "null-ls"
                end,
            })
        end,
    })
end

local lsp_config = require("lspconfig")
local lsp_cmp = require("cmp_nvim_lsp")

local default_caps = vim.lsp.protocol.make_client_capabilities()
local capabilities = lsp_cmp.default_capabilities(default_caps)

lsp_config.clangd.setup({
    capabilities = capabilities,
    on_attach = on_attach,
})

lsp_config.pyright.setup({
    capabilities = capabilities,
    on_attach = on_attach,
})

lsp_config.rust_analyzer.setup({
    on_attach = on_attach,
    capabilities = capabilities,
})

lsp_config.solargraph.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    cmd = { "asdf", "exec", "solargraph", "stdio" },
})

lsp_config.sumneko_lua.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            format = { enable = false },
            diagnostics = {
                enable = false,
                globals = { "vim", "use" },
            },
            runtime = { version = "LuaJIT" },
            telemetry = { enabled = false },
            workspace = { library = vim.api.nvim_get_runtime_file("", true) },
            -- workspace = {
            --     library = {
            --         [vim.fn.expand('$VIMRUNTIME/lua')] = true,
            --         [vim.fn.stdpath('config') .. '/lua'] = true,
            --     }
            -- }
        },
    },
    single_file_support = false,
})
