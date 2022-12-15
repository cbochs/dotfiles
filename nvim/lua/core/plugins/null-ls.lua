-- Repo: https://github.com/jose-elias-alvarez/null-ls.nvim
-- Description: LSP linting and formatting

return {
    "jose-elias-alvarez/null-ls.nvim",
    requires = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        local ok, null_ls = pcall(require, "null-ls")
        if not ok then
            return
        end

        local function root(names)
            return function()
                local found_paths = vim.fs.find(names, { upward = true })
                if not found_paths then
                    return
                end
                local file_path = found_paths[1]
                return vim.fs.dirname(file_path)
            end
        end

        local function format_callback()
            vim.lsp.buf.format({
                filter = function(client)
                    return client.name == "null-ls"
                end,
            })
        end

        null_ls.setup({
            sources = {
                null_ls.builtins.diagnostics.luacheck.with({
                    cwd = root(".luacheckrc"),
                }),
                null_ls.builtins.diagnostics.ruff,
                null_ls.builtins.formatting.black,
                null_ls.builtins.formatting.stylua,
                null_ls.builtins.formatting.usort,
            },
            on_attach = function(client, bufnr)
                if client.supports_method("textDocument/formatting") then
                    vim.api.nvim_clear_autocmds({ group = "LspFormat", buffer = bufnr })
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        group = "LspFormat",
                        buffer = bufnr,
                        callback = format_callback,
                    })
                end
            end,
        })
    end,
}
