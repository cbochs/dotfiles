local Wezterm = {}

Wezterm.run_with_callback = function(on_exit, ...)
    vim.system({ "nvim-wezterm.sh", ... }, { text = true }, on_exit)
end

Wezterm.run = function(...)
    Wezterm.run_with_callback(nil, ...)
end

Wezterm.lazygit = function()
    Wezterm.run("lazygit")
end

Wezterm.github_open = function()
    local file_name = vim.fn.expand("%:~:.")
    local line_number = vim.fn.line(".")

    Wezterm.run("github-open", file_name, line_number)
end

Wezterm.github_link = function()
    local file_name = vim.fn.expand("%:~:.")
    local line_number = vim.fn.line(".")

    Wezterm.run_with_callback(function(result)
        if result.code ~= 0 then
            return
        end

        vim.schedule(function()
            vim.fn.setreg("+", result.stdout)
            vim.notify("Copied Github link.")
        end)
    end, "github-link", file_name, line_number)
end

Wezterm.test = {}

local test_history = {}

Wezterm.test.run = function(...)
    local args = { ... }
    test_history.file_name = args[1]
    test_history.line_number = args[2]

    Wezterm.run("test", ...)
end

Wezterm.test.file = function()
    local file_name = vim.fn.expand("%:~:.")

    Wezterm.test.run(file_name)
end

Wezterm.test.near = function()
    local file_name = vim.fn.expand("%:~:.")
    local line_number = vim.fn.line(".")

    Wezterm.test.run(file_name, line_number)
end

Wezterm.test.last = function()
    if not test_history.file_name then
        vim.notify("No test run yet.")
        return
    end

    Wezterm.test.run(test_history.file_name, test_history.line_number)
end

return Wezterm
