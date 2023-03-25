return {
    {
        "vim-test/vim-test",
        ft = "ruby",
        keys = {
            { "<leader>T", "<cmd>TestFile<cr>", desc = "Run test (file)" },
            { "<leader>tf", "<cmd>TestFile<cr>", desc = "Run test (file)" },
            { "<leader>tn", "<cmd>TestNearest<cr>", desc = "Run test (nearest)" },
            { "<leader>ta", "<cmd>TestSuite<cr>", desc = "Run test (all)" },
            { "<leader>tl", "<cmd>TestLast<cr>", desc = "Run test (last)" },
            { "<leader>tv", "<cmd>TestVisit<cr>", desc = "Visit test" },
        },
        config = function(_, _)
            vim.cmd([[
                let test#strategy = "neovim"

                let test#ruby#rspec#executable = "docker compose exec -e RAILS_ENV=test -e RUBYOPT=-W0 portal bin/rspec"

                let test#lua#lua#executable = "make test"
                let test#lua#lua#file_pattern = "_spec.lua"
            ]])
        end,
    },
}
