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
                "let test#neovim#term_position = "vert"
                let test#ruby#rspec#executable = "docker compose exec -e RAILS_ENV=test -e DEPENDENCIES_NEXT=0 portal bin/rspec"
            ]])
        end,
    },
}
