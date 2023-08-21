local Wezterm = {}

Wezterm.run = function(...)
    vim.fn.jobstart(("nvim-wezterm.sh %s"):format(table.concat({ ... }, " ")))
end

Wezterm.lazygit = function()
    Wezterm.run("lazygit")
end

Wezterm.test = {}
Wezterm.test.history = {}
Wezterm.test.run = function(file_name, line_number)
    Wezterm.test.history.file_name = file_name
    Wezterm.test.history.line_number = line_number

    if line_number then
        Wezterm.run("test", file_name, line_number)
    else
        Wezterm.run("test", file_name)
    end
end

Wezterm.test.file = function()
    Wezterm.run("test", vim.fn.expand("%"))
end

Wezterm.test.near = function()
    Wezterm.run("test", vim.fn.expand("%"), vim.fn.line("."))
end

Wezterm.test.last = function()
    if not Wezterm.test.history.file_name then
        vim.notify("No test run yet.")
        return
    end

    Wezterm.run("test", Wezterm.last_run.file_name, Wezterm.last_run.line_number)
end

return Wezterm
