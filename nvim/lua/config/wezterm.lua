local Wezterm = {}

function Wezterm.run_with_callback(on_exit, ...)
    vim.system({ "nvim-wezterm", ... }, { text = true }, on_exit)
end

function Wezterm.run(...)
    Wezterm.run_with_callback(nil, ...)
end

function Wezterm.lazygit()
    Wezterm.run("lazygit")
end

function Wezterm.github_open()
    local file_name = vim.fn.expand("%:~:.")
    local line_number = vim.fn.line(".")

    Wezterm.run("github-open", file_name, line_number)
end

function Wezterm.github_link()
    local file_name = vim.fn.expand("%:~:.")
    local line_number = vim.fn.line(".")

    Wezterm.run_with_callback(function(result)
        if result.code ~= 0 then
            return
        end

        vim.schedule(function()
            vim.fn.setreg("+", vim.trim(result.stdout))
            vim.notify("Copied Github link.")
        end)
    end, "github-link", file_name, line_number)
end

function Wezterm.preview_readme()
    local file_name = vim.fn.expand("%:~:.")
    local line_number = vim.fn.line(".")

    Wezterm.run("vscode-open", file_name, line_number)
end

Wezterm.test = {}

local test_history = {}

function Wezterm.test.run(...)
    local args = { ... }
    test_history.file_name = args[1]
    test_history.line_number = args[2]

    Wezterm.run("test", ...)
end

function Wezterm.test.file()
    local file_name = vim.fn.expand("%:~:.")

    Wezterm.test.run(file_name)
end

function Wezterm.test.near()
    local file_name = vim.fn.expand("%:~:.")
    local line_number = vim.fn.line(".")

    Wezterm.test.run(file_name, line_number)
end

function Wezterm.test.last()
    if not test_history.file_name then
        vim.notify("No test run yet.")
        return
    end

    Wezterm.test.run(test_history.file_name, test_history.line_number)
end

return Wezterm
