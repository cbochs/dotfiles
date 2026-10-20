_G.Config = {}

vim.pack.add({ 'https://github.com/nvim-mini/mini.nvim' })

local misc = require('mini.misc')

-- stylua: ignore start
Config.now         = function(f) misc.safely('now', f) end
Config.later       = function(f) misc.safely('later', f) end
Config.now_if_args = vim.fn.argc(-1) > 0 and Config.now or Config.later
Config.on_event    = function(ev, f) misc.safely('event:' .. ev, f) end
Config.on_filetype = function(ft, f) misc.safely('filetype:' .. ft, f) end
-- stylua: ignore end

-- Define custom autocommand group and helper to create an autocommand.
--
-- See also:
-- - `:h autocommand`
-- - `:h nvim_create_augroup()`
-- - `:h nvim_create_autocmd()`
--
local group = vim.api.nvim_create_augroup('custom-config', {})
Config.new_autocmd = function(event, pattern, callback, desc)
  local opts = { group = group, pattern = pattern, callback = callback, desc = desc }
  vim.api.nvim_create_autocmd(event, opts)
end

-- Define custom `vim.pack.add()` hook helper.
--
-- See also
-- - `:h vim.pack-events`
--
Config.on_packchanged = function(plugin_name, kinds, callback, desc)
  local f = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if not (name == plugin_name and vim.tbl_contains(kinds, kind)) then return end
    if not ev.data.active then vim.cmd.packadd(plugin_name) end
    callback()
  end
  Config.new_autocmd('PackChanged', '*', f, desc)
end

-- Define custom toggles
--
Config.toggles2 = {}
Config.add_toggle = function(lhs, desc, get, set) end
