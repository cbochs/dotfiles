local actions = require("telescope.actions")
local defaults = require("telescope.config").values
local finders = require("telescope.finders")
local pickers = require("telescope.pickers")

local action_state = require("telescope.actions.state")
local action_set = require("telescope.actions.set")

vim.api.nvim_create_user_command("ReloadConfig", function()
    -- Stop LSP servers
    vim.api.nvim_cmd({ cmd = "LspStop" }, { output = false })

    -- Unload all packages
    for name, _ in pairs(package.loaded) do
        if name:match("^core") then
            package.loaded[name] = nil
        end
    end

    -- Load all packages
    dofile(vim.env.MYVIMRC)

    -- Compile plugins
    vim.api.nvim_cmd({ cmd = "PackerCompile" }, { output = false })
end, {})

vim.api.nvim_create_user_command("JanusRspec", function()
    local term = require("toggleterm")

    -- Used for running a specific rspec test
    local use_line_number = true

    local current_cursor = vim.api.nvim_win_get_cursor(0)
    local current_buffer = vim.api.nvim_buf_get_name(0)
    local current_dir = vim.fn.getcwd()
    local current_line = current_cursor[1] -- [ line, col ]

    local sanitized_current_dir = string.gsub(current_dir, "%p", "%%%1")
    local relative_buffer_path = string.gsub(current_buffer, sanitized_current_dir .. "/", "")

    -- Use the correct rspec file when triggering from rails code
    if string.match(relative_buffer_path, "^app") then
        use_line_number = false
        relative_buffer_path = string.gsub(relative_buffer_path, "^app", "spec")
        relative_buffer_path = string.gsub(relative_buffer_path, ".rb$", "_spec.rb")
    end

    -- Run the whole rspec test when at the top of the file
    if current_line == 1 then
        use_line_number = false
    end

    local docker_command = "docker compose exec portal bin/rspec %s"
    if use_line_number then
        docker_command = docker_command .. ":%s"
    end

    term.exec(string.format(docker_command, relative_buffer_path, current_line))
end, {})

vim.api.nvim_create_user_command("JanusRake", function(opts)
    opts = opts or {}

    local entry_maker = function(entry)
        -- command = { "docker", "compose", "exec", "portal", "bundle", "exec", "bin/rake", "-W", ".*" },
        -- Format: "rake [task] [path]:[line_num]:in `block in <main>'"
        local entry_split = {}
        for item in string.gmatch(entry, "[^%s]+") do
            table.insert(entry_split, item)
        end

        local location = {}
        for item in string.gmatch(entry_split[3], "[^:]+") do
            table.insert(location, item)
        end

        local task = entry_split[2]
        local path = string.gsub(location[1], "/portal", vim.fn.getcwd())
        local lnum = location[2]

        return {
            value = entry,
            display = task,
            ordinal = task,
            lnum = tonumber(lnum),
            path = path,
        }
    end

    pickers
        .new(opts, {
            prompt_title = "Janus Rake",
            finder = finders.new_oneshot_job(
                -- { "docker", "compose", "exec", "portal", "bundle", "exec", "bin/rake", "-W", ".*" },
                { "cat", "dev/rake_tasks" },
                {
                    cwd = "~/git/janus-rails",
                    entry_maker = entry_maker,
                }
            ),
            previewer = defaults.file_previewer(opts),
            sorter = defaults.generic_sorter(opts),
            attach_mappings = function(prompt_bufnr, map)
                actions.select_default:replace(function()
                    actions.close(prompt_bufnr)
                    local selection = action_state.get_selected_entry()
                    print(vim.inspect(selection))
                    vim.fn.setreg("+", selection.display)
                end)

                map("i", "<c-f>", function()
                    action_set.select(prompt_bufnr, "default")
                end)

                map("n", "<c-f>", function()
                    action_set.select(prompt_bufnr, "default")
                end)

                return true
            end,
        })
        :find()
end, {})
