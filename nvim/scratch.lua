vim.api.nvim_create_user_command("SortSpec", function()
    local buf_id = vim.api.nvim_get_current_buf()
    local parser = vim.treesitter.get_parser(buf_id)
    local tree = parser:parse()[1]
    local query = vim.treesitter.query.parse(parser:lang(), [[ (table_constructor) @tbl ]])

    if not tree:root():child():type() == "return_statement" then
        return vim.notify("Module must only have a return statement", vim.log.levels.WARN)
    end

    local root_iter = query:iter_captures(tree:root(), buf_id, 0, -1)
    local _, root, _ = root_iter()

    for field_node, _ in root:iter_children() do
        if not field_node:named() then
            goto continue
        end

        local spec_iter = query:iter_captures(field_node, buf_id)
        local _, spec_node, _ = spec_iter()

        for prop_node, _ in spec_node:iter_children() do
            if not prop_node:named() then
                goto continue
            end

            vim.print({
                node = prop_node:type(),
                text = vim.treesitter.get_node_text(prop_node, buf_id),
            })

            ::continue::
        end

        -- vim.print({
        --     node = spec_node,
        --     name = spec_node:type(),
        -- })
        ::continue::
    end
end, { force = true })

if true then
    return
end

-- local buf_id = vim.fn.bufadd("./scratch_plugins.lua")
local buf_id = vim.fn.bufadd("./lua/plugins/init.lua")
local parser = vim.treesitter.get_parser(buf_id)
local tree = parser:parse()
local root = tree[1]:root()

---See :h add_predicate
vim.treesitter.query.add_predicate("is-root-spec?", function(match, _, _, predicate)
    local capture_id = predicate[2] -- { predicate_name, capture_id }

    ---@type TSNode | nil
    local node = match[capture_id]
    if not node then
        return false
    end

    local expected_root = node:parent():parent()
    if not expected_root:equal(root) then
        return false
    end

    return true
end, true)

vim.treesitter.query.add_predicate("is-root-prop?", function(match, _, _, predicate)
    local capture_id = predicate[2] -- { predicate_name, capture_id }

    ---@type TSNode | nil
    local node = match[capture_id]
    if not node then
        return false
    end

    local expected_root = node:parent():parent():parent():parent():parent():parent()
    if not expected_root:equal(root) then
        return false
    end

    return true
end, true)


-- stylua: ignore
local plugin_query = vim.treesitter.query.parse(parser:lang(), [[
    ((expression_list
     (table_constructor
      (field
       (table_constructor) @plugin))) @return
     (#is-root-spec? @return))
]])

local plugin_captures = {}
for id, name in ipairs(plugin_query.captures) do
    plugin_captures[name] = id
end

-- stylua: ignore
local url_query = vim.treesitter.query.parse(parser:lang(), [[
    (field !name value: (string (string_content) @url))
]])

-- stylua: ignore
local spec_query = vim.treesitter.query.parse(parser:lang(), [[
    ((field name: (identifier) @name) @property
     (#is-root-prop? @property))
]])

local spec_captures = {}
for id, name in ipairs(spec_query.captures) do
    spec_captures[name] = id
end

-- stylua: ignore
local spec_properties = { "dir", "url", "name", "dev", "lazy", "enabled", "dependencies", "init", "opts", "config", "main", "build", "branch", "tag", "commit", "version", "pin", "submodules", "event", "cmd", "ft", "keys", "module", "priority", "optional" }
local spec_order = {}
for i, property in ipairs(spec_properties) do
    spec_order[property] = i
end

local plugins, ranges, edits = {}, {}, {}

for _, match, _ in plugin_query:iter_matches(root, buf_id, 0, -1) do
    local plugin_id = plugin_captures["plugin"]
    local plugin_node = match[plugin_id]

    -- Get the plugin's url
    ---@diagnostic disable-next-line: missing-parameter
    local url_iter = url_query:iter_captures(plugin_node, buf_id)
    local _, url_node, _ = url_iter()
    local plugin_url = vim.treesitter.get_node_text(url_node, buf_id)

    -- Sort the plugin's properties
    local props, prop_ranges, prop_edits = {}, {}, {}

    ---@diagnostic disable-next-line: missing-parameter
    for _, match, _ in spec_query:iter_matches(plugin_node, buf_id) do
        local prop_id = spec_captures["property"]
        local prop_node = match[prop_id]
        local prop_text = vim.treesitter.get_node_text(prop_node, buf_id)
        local prop_range = { prop_node:range() }

        local name_id = spec_captures["name"]
        local name_node = match[name_id]
        local name_text = vim.treesitter.get_node_text(name_node, buf_id)

        table.insert(props, {
            name = string.lower(name_text),
            text = prop_text,
        })

        table.insert(prop_ranges, {
            ["start"] = { line = prop_range[1], character = prop_range[2] },
            ["end"] = { line = prop_range[3], character = prop_range[4] }, -- +1 to account for trailing comma
        })

        if not spec_order[name_text] then
            vim.print(name_text)
        end
    end

    table.sort(props, function(prop_a, prop_b)
        return spec_order[prop_a.name] < spec_order[prop_b.name]
    end)

    for i, prop in ipairs(props) do
        table.insert(prop_edits, {
            range = prop_ranges[i],
            newText = prop.text,
        })
    end

    -- APPLY
    vim.lsp.util.apply_text_edits(prop_edits, buf_id, "utf-8")

    local plugin_range = { plugin_node:range() }
    local plugin_text = vim.treesitter.get_node_text(plugin_node, buf_id)

    table.insert(plugins, {
        name = string.lower(plugin_url),
        text = plugin_text,
    })

    table.insert(ranges, {
        ["start"] = { line = plugin_range[1], character = plugin_range[2] },
        ["end"] = { line = plugin_range[3], character = plugin_range[4] }, -- +1 to account for trailing comma
    })
end

table.sort(plugins, function(plugin_a, plugin_b)
    return string.lower(plugin_a.name) < string.lower(plugin_b.name)
end)

for i, plugin in ipairs(plugins) do
    table.insert(edits, {
        range = ranges[i],
        newText = plugin.text,
    })
end

vim.lsp.util.apply_text_edits(edits, buf_id, "utf-8")
