-- Language Servers & Diagnostics
-- References:
-- - https://neovim.io/doc/user/options.html#options
--
-- Help
-- - :help vim.lsp
-- - :help vim.lsp.buf (quickstart)
-- - :help vim.fs

local diagnostic_signs = { Error = "", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(diagnostic_signs) do
    local hl = 'DiagnosticSign' .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
end

local on_attach = function(_, bufnr)
    local keymap = vim.keymap.set
    local buffer_opts = { silent = true, noremap = true, buffer = bufnr }

    local builtin = require("telescope.builtin")

    -- keymap("n", "gi",        vim.lsp.buf.implementation, buffer_opts)
    -- keymap("n", "gd",        vim.lsp.buf.definition, buffer_opts)
    -- keymap("n", "gD",        vim.lsp.buf.type_definition)
    -- keymap("n", "gr",        vim.lsp.buf.references, buffer_opts)
    keymap("n", "gD",        builtin.lsp_type_definitions, buffer_opts)
    keymap("n", "gS",        builtin.lsp_workspace_symbols, buffer_opts)
    keymap("n", "gd",        builtin.lsp_definitions, buffer_opts)
    keymap("n", "gi",        builtin.lsp_implementations, buffer_opts)
    keymap("n", "gr",        builtin.lsp_references, buffer_opts)
    keymap("n", "gs",        builtin.lsp_document_symbols, buffer_opts)
    keymap("n", "gS",        builtin.lsp_workspace_symbols, buffer_opts)

    keymap("n", "K",         vim.lsp.buf.hover, buffer_opts)
    keymap("n", "ga",        vim.lsp.buf.code_action, buffer_opts)
    keymap("n", "gf",        vim.lsp.buf.format, buffer_opts)
    keymap("v", "gf",         vim.lsp.buf.format, buffer_opts)
    keymap("n", "<leader>r", vim.lsp.buf.rename, buffer_opts)
    -- keymap("n", "<leader>",     vim.lsp.buf.signature_help, buffer_opts)
    keymap("n", "<c-n>",     vim.diagnostic.goto_next, buffer_opts)
    keymap("n", "<c-p>",     vim.diagnostic.goto_prev, buffer_opts)
    keymap("n", "<leader>l", vim.diagnostic.open_float, buffer_opts)
end

local lsp_config = require("lspconfig")
local lsp_cmp    = require("cmp_nvim_lsp")

local default_caps = vim.lsp.protocol.make_client_capabilities()
local capabilities = lsp_cmp.default_capabilities(default_caps)

lsp_config.sumneko_lua.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            diagnostics = { globals = { "vim", "use" } },
            runtime   = { version = "LuaJIT" },
            telemetry = { enabled = false },
            workspace = { library = vim.api.nvim_get_runtime_file("", true) },
        }
    },
    single_file_support = false,
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

lsp_config.pyright.setup({
    capabilities = capabilities,
    on_attach = on_attach
})
    -- settings = {
    --     python = {
    --         analysis = {
    --             autoImportCompletions = true,
    --             autoSearchPaths = true,
    --             diagnosticMode = 'workspace',
    --             typeCheckingMode = 'on',
    --             useLibraryCodeForTypes = true,
    --             venvPath = '$HOME/.local/share/virtualenvs', -- pipenv
    --         }
    --     }
    -- }

--[[
vim.api.nvim_create_augroup("LanguageServers", { clear = true })

local root_dir = function(file_paths)
    local found_files = vim.fs.find(file_paths, { upward = true })
    local root_dir = vim.fs.dirname(found_files[1])
    return root_dir
end

vim.api.nvim_create_autocmd("FileType", {
    group = "LanguageServers",
    pattern = "rust",
    callback = function()
        vim.lsp.start({
            name = "rust-analyzer",
            cmd = { "rust-analyzer" },
            root_dir = root_dir({ "Cargo.toml" }),
            capabilities = capabilities,
        })
    end
})

vim.api.nvim_create_autocmd("LspAttach", {
    group = "LanguageServers",
    pattern = "rust",
    callback = function(args)
        local keymap = vim.keymap.set
        local buffer_opts = { silent = true, noremap = true, buffer = args.buf }
        keymap("n", "K", vim.lsp.buf.hover, buffer_opts)
    end
})
--]]
