-- stylua: ignore start

-- :h map-modes
--
-- Common modes
-- - n = normal
-- - i = insert
-- - x = visual
-- - s = select
-- - v = visual | select

local map         = vim.keymap.set
local nmap        = function(lhs, rhs, desc) map('n', lhs, rhs, { desc = desc }) end
local nmap_leader = function(lhs, rhs, desc) vim.keymap.set('n', '<Leader>' .. lhs, rhs, { desc = desc }) end
local xmap_leader = function(lhs, rhs, desc) vim.keymap.set('x', '<Leader>' .. lhs, rhs, { desc = desc }) end

-- General mappings ===========================================================
--
-- Many general mappings are created by 'mini.basics'. See 'plugin/30_mini.lua'

map({ 'i', 'v' }, '<c-j>', '<esc>',                  { desc = 'Escape' })
map({ 'n', 's' }, '<esc>', '<cmd>:noh<cr>',          { desc = 'Escape (clear highlights)' })
map({ 'n', 'v' }, ';', ':',                          { desc = 'Command-line mode'})
map({ 'n', 'x' }, 'j', 'v:count == 0 ? "gj" : "j"',  { desc = 'Down', expr = true, silent = true }) -- Handle wrapped lines
map({ 'n', 'x' }, 'k', 'v:count == 0 ? "gk" : "k"',  { desc = 'Up',   expr = true, silent = true }) -- Handle wrapped lines

-- Skip using buffer name for scratch files (like mini.starter buffer)
local open_files = function()
  local buf_ft = vim.o.filetype
  local is_files = buf_ft == 'minifiles'
  local is_start = buf_ft == 'ministarter'

  if is_files then
    MiniFiles.go_out()
  else
    local buf_ty = vim.bo.buftype
    local is_scratch = buf_ty == 'help' or buf_ty == 'quickfix'
    local use_buf = not is_start and not is_scratch
    MiniFiles.open(use_buf and vim.api.nvim_buf_get_name(0) or nil)
  end
end

map({ 'n' }, 'U',  '<c-r>',                                                     { desc = 'Redo' })       -- Helix-like
map({ 'n' }, 'gl', '$',                                                         { desc = 'Line end' })   -- Helix-like
map({ 'n' }, 'gh', '^',                                                         { desc = 'Line start' }) -- Helix-like
map({ 'n' }, 'gj', '<cmd>TSJToggle<cr>',                                        { desc = 'Split-join' }) -- Prefer treesj over mini.splitjoin
map({ 'n' }, '-',  open_files,                                                  { desc = 'Explore files' })
map({ 'n' }, 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>',                     { desc = 'Go to definition' })

map({ 'x' }, '<', '<gv', { desc = 'Decrease indent' }) -- Re-apply selection
map({ 'x' }, '>', '>gv', { desc = 'Increase indent' }) -- Re-apply selection

map({ 'n' },      '<leader>\\', '<c-w>v', { desc = 'Split vertically' })
map({ 'n' },      '<leader>-',  '<c-w>s', { desc = 'Split horizontally' })
map({ 'n', 'x' }, '<leader>y',  '"+y',    { desc = 'Copy to system clipboard' })

-- Custom toggles =============================================================

local function set_toggle(toggle)
    local get = function() return toggle.tbl[toggle.opt] end
    local set = function(v) toggle.tbl[toggle.opt] = v; return v end
    local tog = function()
      local new_state = set(not get())
      vim.print('Toggled ' .. toggle.opt .. ': ' .. tostring(new_state))
    end
    toggle.enabled = get

    nmap('<leader>u'     .. toggle.key, tog, 'Toggled ' .. toggle.opt)
    nmap('<localleader>' .. toggle.key, tog, 'Toggled ' .. toggle.opt)
end

vim.g.autoformat = true

Config.toggles = {
  format   = { key = 'f', opt = 'autoformat',     tbl = vim.g },
  number   = { key = 'n', opt = 'number',         tbl = vim.o },
  relative = { key = 'r', opt = 'relativenumber', tbl = vim.o },
  wrap     = { key = 'w', opt = 'wrap',           tbl = vim.o },
}

vim.tbl_map(set_toggle, Config.toggles)

-- Custom marks ===============================================================

local function set_mark(mark)
    local jump =
      mark.kind == 'mark' and function() vim.cmd.edit(vim.fs.joinpath(vim.fn.getcwd(), mark.path)) end or
      mark.kind == 'pick' and function()
        vim.schedule(function()
          MiniPick.set_picker_query(vim.split(mark.path, ''))
        end)
        MiniPick.builtin.files()
      end or
      mark.kind == 'file' and ''

    nmap('\'' .. mark.key, jump, mark.desc)
end

Config.marks = {
  { key = 'r', path = 'README.md',      kind = 'mark', desc = 'Repo README.md' },
  { key = 'R', path = 'README.md',      kind = 'pick', desc = 'All README.md' },
  { key = 'g', path = '.gitlab-ci.yml', kind = 'mark', desc = 'Repo .gitlab-ci.yml' }
}

vim.tbl_map(set_mark, Config.marks)

-- Leader mappings ============================================================

-- Used to provide 'mini.clue' with Leader group clues.
Config.leader_group_clues = {
  { mode = 'n', keys = '<Leader>b', desc = '+Buffer'       },
  { mode = 'n', keys = '<Leader>e', desc = '+Explore/Edit' },
  { mode = 'n', keys = '<Leader>f', desc = '+Find'         },
  { mode = 'n', keys = '<Leader>g', desc = '+Git'          },
  { mode = 'n', keys = '<Leader>o', desc = '+Other'        },
  { mode = 'n', keys = '<Leader>s', desc = '+Session'      },
  { mode = 'n', keys = '<Leader>v', desc = '+Visits'       },

  { mode = 'x', keys = '<Leader>g', desc = '+Git'      },
  { mode = 'x', keys = '<Leader>l', desc = '+Language' },
}

-- Section: b is for 'Buffer'
local new_scratch_buffer = function()
  vim.api.nvim_win_set_buf(0, vim.api.nvim_create_buf(true, true))
end

nmap_leader('bd', '<cmd>lua MiniBufremove.delete()<cr>',        'Delete')
nmap_leader('bD', '<Cmd>lua MiniBufremove.delete(0, true)<CR>', 'Delete!')
nmap_leader('bo', '<cmd>%bd|e#|bd#<cr>',                        'Delete others')
nmap_leader('bs', new_scratch_buffer,                           'Scratch')

-- Section: e is for 'Explore' and 'Edit'
local edit_plugin_file = function(filename)
  return string.format('<Cmd>edit %s/plugin/%s<CR>', vim.fn.stdpath('config'), filename)
end
local explore_quickfix = function()
  vim.cmd(vim.fn.getqflist({ winid = true }).winid ~= 0 and 'cclose' or 'copen')
end
local explore_locations = function()
  vim.cmd(vim.fn.getloclist(0, { winid = true }).winid ~= 0 and 'lclose' or 'lopen')
end

nmap_leader('ei', '<Cmd>edit $MYVIMRC<CR>',                 'Edit init.lua')
nmap_leader('ek', edit_plugin_file('20_keymaps.lua'),       'Edit keymaps')
nmap_leader('em', edit_plugin_file('30_mini.lua'),          'Edit mini config')
nmap_leader('eo', edit_plugin_file('10_options.lua'),       'Edit options')
nmap_leader('ep', edit_plugin_file('40_plugins.lua'),       'Edit plugins')
nmap_leader('eq', explore_quickfix,                         'Explore quickfix')
nmap_leader('eQ', explore_locations,                        'Explore location')
nmap_leader('en', '<Cmd>lua MiniNotify.show_history()<CR>', 'Explore notifications')

-- Section: f is for 'Fuzzy Find'. Common usage:
nmap_leader('f/', '<Cmd>Pick history scope="/"<CR>',                 '"/" history')
nmap_leader('f:', '<Cmd>Pick history scope=":"<CR>',                 '":" history')
nmap_leader('fa', '<Cmd>Pick git_hunks scope="staged"<CR>',          'Added hunks (all)')
nmap_leader('fA', '<Cmd>Pick git_hunks path="%" scope="staged"<CR>', 'Added hunks (buf)')
nmap_leader('fb', '<Cmd>Pick buffers<CR>',                           'Buffers')
nmap_leader('fc', '<Cmd>Pick git_commits<CR>',                       'Commits (all)')
nmap_leader('fC', '<Cmd>Pick git_commits path="%"<CR>',              'Commits (buf)')
nmap_leader('fd', '<Cmd>Pick diagnostic scope="all"<CR>',            'Diagnostic workspace')
nmap_leader('fD', '<Cmd>Pick diagnostic scope="current"<CR>',        'Diagnostic buffer')
nmap_leader('ff', '<Cmd>Pick files<CR>',                             'Files')
nmap_leader('fg', '<Cmd>Pick grep_live<CR>',                         'Grep live')
nmap_leader('fG', '<Cmd>Pick grep pattern="<cword>"<CR>',            'Grep current word')
nmap_leader('fh', '<Cmd>Pick help<CR>',                              'Help tags')
nmap_leader('fH', '<Cmd>Pick hl_groups<CR>',                         'Highlight groups')
nmap_leader('fl', '<Cmd>Pick buf_lines scope="all"<CR>',             'Lines (all)')
nmap_leader('fL', '<Cmd>Pick buf_lines scope="current"<CR>',         'Lines (buf)')
nmap_leader('fm', '<Cmd>Pick git_hunks<CR>',                         'Modified hunks (all)')
nmap_leader('fM', '<Cmd>Pick git_hunks path="%"<CR>',                'Modified hunks (buf)')
nmap_leader('fr', '<Cmd>Pick resume<CR>',                            'Resume')
nmap_leader('fR', '<Cmd>Pick lsp scope="references"<CR>',            'References (LSP)')
nmap_leader('fs', '<Cmd>Pick lsp scope="workspace_symbol_live"<CR>', 'Symbols workspace (live)')
nmap_leader('fS', '<Cmd>Pick lsp scope="document_symbol"<CR>',       'Symbols document')
nmap_leader('fv', '<Cmd>Pick visit_paths cwd=""<CR>',                'Visit paths (all)')
nmap_leader('fV', '<Cmd>Pick visit_paths<CR>',                       'Visit paths (cwd)')

-- g is for 'Git'. Common usage:
-- - `<Leader>gs` - show information at cursor
-- - `<Leader>go` - toggle 'mini.diff' overlay to show in-buffer unstaged changes
-- - `<Leader>gd` - show unstaged changes as a patch in separate tabpage
-- - `<Leader>gL` - show Git log of current file
local git_log_cmd = [[Git log --pretty=format:\%h\ \%as\ │\ \%s --topo-order]]
local git_log_buf_cmd = git_log_cmd .. ' --follow -- %'

nmap_leader('ga', '<Cmd>Git diff --cached<CR>',             'Added diff')
nmap_leader('gA', '<Cmd>Git diff --cached -- %<CR>',        'Added diff buffer')
nmap_leader('gc', '<Cmd>Git commit<CR>',                    'Commit')
nmap_leader('gC', '<Cmd>Git commit --amend<CR>',            'Commit amend')
nmap_leader('gd', '<Cmd>Git diff<CR>',                      'Diff')
nmap_leader('gD', '<Cmd>Git diff -- %<CR>',                 'Diff buffer')
nmap_leader('gl', '<Cmd>' .. git_log_cmd .. '<CR>',         'Log')
nmap_leader('gL', '<Cmd>' .. git_log_buf_cmd .. '<CR>',     'Log buffer')
nmap_leader('go', '<Cmd>lua MiniDiff.toggle_overlay()<CR>', 'Toggle overlay')
nmap_leader('gs', '<Cmd>lua MiniGit.show_at_cursor()<CR>',  'Show at cursor')

xmap_leader('gs', '<Cmd>lua MiniGit.show_at_cursor()<CR>', 'Show at selection')

-- o is for 'Other'. Common usage:
-- - `<Leader>oz` - toggle between "zoomed" and regular view of current buffer
nmap_leader('or', '<Cmd>lua MiniMisc.resize_window()<CR>', 'Resize to default width')
nmap_leader('ot', '<Cmd>lua MiniTrailspace.trim()<CR>',    'Trim trailspace')
nmap_leader('oz', '<Cmd>lua MiniMisc.zoom()<CR>',          'Zoom toggle')

-- s is for 'Session'. Common usage:
-- - `<Leader>sn` - start new session
-- - `<Leader>sr` - read previously started session
-- - `<Leader>sd` - delete previously started session
local session_new = function()
    local prompt = '(mini.session) Session name: '

    -- Ask for input. Use `pcall` to allow `<C-c>` to cancel user input
    vim.cmd('echohl Question')
    local ok, input = pcall(vim.fn.input, { prompt = prompt, default = '' })
    vim.cmd('echohl None | echo "" | redraw')

    if not ok then return end
    if input == '' then return end

    MiniSessions.write(input)
end

nmap_leader('sd', '<Cmd>lua MiniSessions.select("delete")<CR>', 'Delete')
nmap_leader('sn', session_new,                                  'New')
nmap_leader('sr', '<Cmd>lua MiniSessions.select("read")<CR>',   'Read')
nmap_leader('sw', '<Cmd>lua MiniSessions.write()<CR>',          'Write current')

-- v is for 'Visits'. Common usage:
-- - `<Leader>vv` - add    "core" label to current file.
-- - `<Leader>vV` - remove "core" label to current file.
-- - `<Leader>vc` - pick among all files with "core" label.
local make_pick_core = function(cwd, desc)
  return function()
    local sort_latest = MiniVisits.gen_sort.default({ recency_weight = 1 })
    local local_opts = { cwd = cwd, filter = 'core', sort = sort_latest }
    MiniExtra.pickers.visit_paths(local_opts, { source = { name = desc } })
  end
end

nmap_leader('vc', make_pick_core('',  'Core visits (all)'),       'Core visits (all)')
nmap_leader('vC', make_pick_core(nil, 'Core visits (cwd)'),       'Core visits (cwd)')
nmap_leader('vv', '<Cmd>lua MiniVisits.add_label("core")<CR>',    'Add "core" label')
nmap_leader('vV', '<Cmd>lua MiniVisits.remove_label("core")<CR>', 'Remove "core" label')
nmap_leader('vl', '<Cmd>lua MiniVisits.add_label()<CR>',          'Add label')
nmap_leader('vL', '<Cmd>lua MiniVisits.remove_label()<CR>',       'Remove label')

-- stylua: ignore end
