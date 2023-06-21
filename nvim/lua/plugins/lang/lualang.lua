return {
    -- setup lspconfig for lua
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                lua_ls = {
                    settings = {
                        Lua = {
                            hint = {
                                enable = true,
                            },
                        },
                    },
                },
            },
        },
    },
}
