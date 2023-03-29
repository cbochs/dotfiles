return {
    {
        "vim-test/vim-test",
        -- dir = "~/git_personal/vim-test",
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
                function! Zellij(cmd)
                    let bin = join(['zellij', 'run', '--direction', 'right', '--cwd', getcwd()])
                    let cmd = join([bin, '--', a:cmd])
                    execute 'silent !'.cmd
                endfunction

                let g:test#custom_strategies = { 'zellij': function('Zellij') }
                let test#strategy = 'zellij'
                let test#ruby#rspec#executable = "docker compose exec -e RAILS_ENV=test -e RUBYOPT='-W0 -W:no-deprecated' portal bin/rspec"
            ]])
        end,
    },
}
