-- LSP Linting & Formatting
-- Repo: https://github.com/jose-elias-alvarez/null-ls.nvim

local M = {}

M.Details = function()
    return {
        "jose-elias-alvarez/null-ls.nvim",
        requires = {
            "nvim-lua/plenary.nvim",
        },
        config = M.Setup,
    }
end

M.Setup = function()
    local null_ls = require("null-ls")
    null_ls.setup({
        sources = {
            -- null_ls.builtins.diagnostics.selene.with({
            --     cwd = function(_)
            --         local found_paths = vim.fs.find("selene.toml", { upward = true })
            --         if not found_paths then
            --             return
            --         end
            --         local file_path = found_paths[1]
            --         return vim.fs.dirname(file_path)
            --     end,
            -- }),
            null_ls.builtins.diagnostics.luacheck.with({
                cwd = function(_)
                    local found_paths = vim.fs.find(".luacheckrc", { upward = true })
                    if not found_paths then
                        return
                    end
                    local file_path = found_paths[1]
                    return vim.fs.dirname(file_path)
                end,
            }),
            null_ls.builtins.diagnostics.ruff,
            null_ls.builtins.formatting.black,
            null_ls.builtins.formatting.stylua,
            null_ls.builtins.formatting.usort,
        },
    })
end

return M
