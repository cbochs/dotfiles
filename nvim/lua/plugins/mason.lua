local tools = {
    "black",
    "clangd",
    "lua-language-server",
    "luacheck",
    "pyright",
    "ruff",
    "rust-analyzer",
    "selene",
    "shfmt",
    "solargraph",
    "stylua",
    "usort",
}

return {
    "williamboman/mason.nvim",
    lazy = true,
    config = function()
        require("mason").setup()

        local registry = require("mason-registry")
        for _, tool in ipairs(tools) do
            local package = registry.get_package(tool)
            if not package:is_installed() then
                package:install()
            end
        end
    end,
}
