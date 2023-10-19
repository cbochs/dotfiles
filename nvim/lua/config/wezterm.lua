local Wezterm = {}

Wezterm.run = function(...)
    vim.fn.jobstart(("nvim-wezterm.sh %s"):format(table.concat({ ... }, " ")))
end

Wezterm.lazygit = function()
    Wezterm.run("lazygit")
end

Wezterm.open_in_github = function()
    Wezterm.run("open", vim.fn.expand("%"))
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
    local file_name = vim.fn.expand("%")

    Wezterm.test.run(file_name)
end

Wezterm.test.near = function()
    local file_name = vim.fn.expand("%")
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
