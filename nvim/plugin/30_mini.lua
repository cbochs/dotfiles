-- ┌────────────────────┐
-- │ MINI configuration │
-- └────────────────────┘

local now, now_if_args, later = Config.now, Config.now_if_args, Config.later

-- Step one ===================================================================

-- Common configuration presets.
--
-- Example usage:
-- - `<C-s>` in Insert mode - save and go to Normal mode
-- - `go` / `gO` - insert empty line before/after in Normal mode
-- - `gy` / `gp` - copy / paste from system clipboard
-- - `\` + key - toggle common options. Like `\h` toggles highlighting search.
-- - `<C-hjkl>` (four combos) - navigate between windows.
-- - `<M-hjkl>` in Insert/Command mode - navigate in that mode.
--
-- See also:
-- - `:h MiniBasics.config.options` - list of adjusted options
-- - `:h MiniBasics.config.mappings` - list of created mappings
-- - `:h MiniBasics.config.autocommands` - list of created autocommands
now(function()
  require('mini.basics').setup({
    -- Manage options in 'plugin/10_options.lua' for didactic purposes
    options = {
      basic = false,
    },
    mappings = {
      -- Basic mappings (better 'jk', save with Ctrl+S, ...)
      basic = true,
      -- Create `<C-hjkl>` mappings for window navigation
      windows = true,
      -- Create `<M-hjkl>` mappings for navigation in Insert and Command modes
      move_with_alt = true,
    },
  })
end)

-- Icon provider.
now(function()
  -- Set up to not prefer extension-based icon for some extensions
  local ext3_blocklist = { scm = true, txt = true, yml = true }
  local ext4_blocklist = { json = true, yaml = true }
  require('mini.icons').setup({
    use_icons = false,
    use_file_extension = function(ext, _)
      return not (ext3_blocklist[ext:sub(-3)] or ext4_blocklist[ext:sub(-4)])
    end,
  })

  -- Mock 'nvim-tree/nvim-web-devicons' for plugins without 'mini.icons' support.
  -- Not needed for 'mini.nvim' or MiniMax, but might be useful for others.
  later(MiniIcons.mock_nvim_web_devicons)

  -- Add LSP kind icons. Useful for 'mini.completion'.
  later(MiniIcons.tweak_lsp_kind)
end)

-- Notifications provider.
--
-- Example usage:
-- - `:h vim.notify()` - show notification (hides automatically)
-- - `<Leader>en` - show notification history
--
-- See also:
-- - `:h MiniNotify.config` for some of common configuration examples.
now(function() require('mini.notify').setup() end)

-- Session management. A thin wrapper around `:h mksession`.
now(function() require('mini.sessions').setup() end)

-- Statuscolumn. Sets `:h 'statuscolumn'` for improved window's left column.
--
-- See also:
-- - `:h MiniStatuscolumn.config` - general overview of available configuration.
-- - `:h MiniStatuscolumn.gen_content.main()` - simplified content customization.
now(function() require('mini.statuscolumn').setup() end)

-- Start screen. This is what is shown when you open Neovim like `nvim`.
--
-- See also:
-- - `:h MiniStarter-example-config` - non-default config examples
-- - `:h MiniStarter-lifecycle` - how to work with Starter buffer
now(function()
  local starter = require('mini.starter')

  starter.setup({
    header = [[
            __:.__
           (_:..'"=
            ::/ o o\         AHAH!
           ;'-'   (_)     Spaceman Spiff      .
           '-._  ;-'        wins again !  _'._|\/:
           .:;  ;                .         '- '   /_
          :.. ; ;,                \       _/,    "_<
         :.|..| ;:                 \__   '._____  _)
         :.|.'| ||                            _/ /
         :.|..| :'                           `;--:
         '.|..|:':       _               _ _ :|_\:
      .. _:|__| '.\.''..' ) ___________ ( )_):|_|:
:....::''::/  | : :|''| "/ /_=_=_=_=_=/ :_[__'_\3_)
 ''''      '-''-'-'.__)-'
    ]],
    content_hooks = {
      starter.gen_hook.aligning('center', 'center'),
    },
  })
end)

-- Statusline. Sets `:h 'statusline'` to show more info in a line below window.
--
-- See also:
-- - `:h MiniStatusline-example-content` - example of default content. Use it to
--   configure a custom statusline by setting `config.content.active` function.
now(function() require('mini.statusline').setup() end)

-- Tabline. Sets `:h 'tabline'` to show all listed buffers in a line at the top.
now(function() require('mini.tabline').setup() end)

-- Step one or two ============================================================
-- Load now if Neovim is started like `nvim -- path/to/file`, otherwise - later.
-- This ensures a correct behavior for files opened during startup.

-- Completion and signature help.
--
-- Implements async "two stage" autocompletion:
-- - Based on attached LSP servers that support completion.
-- - Fallback (based on built-in keyword completion) if there is no LSP candidates.
now_if_args(function()
  -- Customize post-processing of LSP responses for a better user experience.
  -- Don't show 'Text' suggestions (usually noisy) and show snippets last.
  local process_items_opts = { kind_priority = { Text = -1, Snippet = 99 } }
  local process_items = function(items, base)
    return MiniCompletion.default_process_items(items, base, process_items_opts)
  end
  require('mini.completion').setup({
    lsp_completion = {
      -- Without this config autocompletion is set up through `:h 'completefunc'`.
      -- Although not needed, setting up through `:h 'omnifunc'` is cleaner
      -- (sets up only when needed) and makes it possible to use `<C-u>`.
      source_func = 'omnifunc',
      auto_setup = false,
      process_items = process_items,
    },
  })

  -- Set 'omnifunc' for LSP completion only when needed.
  local on_attach = function(ev)
    vim.bo[ev.buf].omnifunc = 'v:lua.MiniCompletion.completefunc_lsp'
  end
  Config.new_autocmd('LspAttach', nil, on_attach, "Set 'omnifunc'")

  -- Advertise to servers that Neovim now supports certain set of completion and
  -- signature features through 'mini.completion'.
  vim.lsp.config('*', { capabilities = MiniCompletion.get_lsp_capabilities() })
end)

-- Navigate and manipulate the file system.
--
-- See also:
-- - `:h MiniFiles-navigation` - more details about how to navigate
-- - `:h MiniFiles-manipulation` - more details about how to manipulate
-- - `:h MiniFiles-examples` - examples of common setups
now_if_args(function()
  -- Enable directory/file preview
  require('mini.files').setup({ windows = { max_number = 1 } })

  local add_marks = function()
    -- Use `g?` to see available bookmarks
    MiniFiles.set_bookmark('c', vim.fn.stdpath('config'), { desc = 'Config' })
    MiniFiles.set_bookmark('w', vim.fn.getcwd, { desc = 'Working directory' })
    MiniFiles.set_bookmark('x', '/etc/nix-darwin', { desc = 'Nix config' })
  end
  Config.new_autocmd('User', 'MiniFilesExplorerOpen', add_marks, 'Add bookmarks')

  local center_window = function(args)
    local win_id = args.data.win_id
    local config = vim.api.nvim_win_get_config(win_id)
    config.width = math.max(50, math.min(70, math.floor(vim.o.columns * 0.5)))
    config.col = (vim.o.columns - config.width) / 2
    vim.api.nvim_win_set_config(win_id, config)
  end
  Config.new_autocmd('User', 'MiniFilesWindowUpdate', center_window, 'Center window')
end)

-- Miscellaneous small but useful functions.
--
-- See also:
-- - `:h MiniMisc.setup_auto_root()` - change current working directory based on the current file path.
-- - `:h MiniMisc.setup_restore_cursor()` - Restore latest cursor position on file open.
-- - `:h MiniMisc.setup_auto_root()` - synchronize terminal emulator background with Neovim's background.
now_if_args(function()
  require('mini.misc').setup()

  MiniMisc.setup_auto_root()
  MiniMisc.setup_restore_cursor()
  MiniMisc.setup_termbg_sync()
end)

-- Step two ===================================================================

-- Extra 'mini.nvim' functionality.
--
-- See also:
-- - `:h MiniExtra.pickers` - pickers. Most are mapped in `<Leader>f` group.
-- - `:h MiniExtra.gen_ai_spec` - 'mini.ai' textobject specifications
-- - `:h MiniExtra.gen_highlighter` - 'mini.hipatterns' highlighters
later(function() require('mini.extra').setup() end)

-- Extend and create a/i textobjects, like `:h a(`, `:h a'`, and more).
--
-- See also:
-- - `:h text-objects` - general info about what textobjects are
-- - `:h MiniAi-builtin-textobjects` - list of all supported textobjects
-- - `:h MiniAi-textobject-specification` - examples of custom textobjects
later(function()
  local ai = require('mini.ai')
  ai.setup({
    custom_textobjects = {
      g = MiniExtra.gen_ai_spec.buffer(),
      f = ai.gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }),
    },
    search_method = 'cover',
  })
end)

-- Align text interactively. Example usage:
--
-- See also:
-- - `:h MiniAlign-example` - hands-on list of examples to practice aligning
-- - `:h MiniAlign.gen_step` - list of support step customizations
-- - `:h MiniAlign-algorithm` - how alignment is done on algorithmic level
later(function()
  require('mini.align').setup({
    modifiers = {
      -- Split by delimiter
      S = function(_, opts)
        local prompt = '(mini.align) Enter split plain delimiter: '

        -- Ask for input. Use `pcall` to allow `<C-c>` to cancel user input
        vim.cmd('echohl Question')
        local ok, input = pcall(vim.fn.input, { prompt = prompt, default = '' })
        vim.cmd('echohl None | echo "" | redraw')

        if not ok then return end
        if input == '' then return end

        opts.split_pattern = vim.pesc(input)
      end,
    },
  })
end)

-- Go forward/backward with square brackets.
--
-- See also:
-- - `:h MiniBracketed` - overall mapping design and list of targets
later(function() require('mini.bracketed').setup() end)

-- Remove buffers. Opened files occupy space in tabline and buffer picker.
-- When not needed, they can be removed. Example usage:
-- - `<Leader>bw` - completely wipeout current buffer (see `:h :bwipeout`)
-- - `<Leader>bW` - completely wipeout current buffer even if it has changes
-- - `<Leader>bd` - delete current buffer (see `:h :bdelete`)
later(function() require('mini.bufremove').setup() end)

-- Show next key clues in a bottom right window.
--
-- See also:
-- - `:h MiniClue-examples` - examples of common setups
-- - `:h MiniClue.ensure_buf_triggers()` - use it to enable triggers in buffer
-- - `:h MiniClue.set_mapping_desc()` - change mapping description not from config
later(function()
  local miniclue = require('mini.clue')
  -- stylua: ignore
  miniclue.setup({
    clues = {
      Config.leader_group_clues,
      miniclue.gen_clues.builtin_completion(),
      miniclue.gen_clues.g(),
      miniclue.gen_clues.marks(),
      miniclue.gen_clues.registers(),
      miniclue.gen_clues.square_brackets(),
      miniclue.gen_clues.windows({ submode_resize = true }),
      miniclue.gen_clues.z(),
    },

    -- Explicitly opt-in for set of common keys to trigger clue window
    triggers = {
      { mode = { 'n', 'x' }, keys = '<Leader>' }, -- Leader triggers
      { mode =   'n',        keys = '\\' },       -- mini.basics
      { mode = { 'n', 'x' }, keys = '[' },        -- mini.bracketed
      { mode = { 'n', 'x' }, keys = ']' },
      { mode =   'i',        keys = '<C-x>' },    -- Built-in completion
      { mode = { 'n', 'x' }, keys = 'g' },        -- `g` key
      { mode = { 'n', 'x' }, keys = "'" },        -- Marks
      { mode = { 'n', 'x' }, keys = '`' },
      { mode = { 'n', 'x' }, keys = '"' },        -- Registers
      { mode = { 'i', 'c' }, keys = '<C-r>' },
      { mode =   'n',        keys = '<C-w>' },    -- Window commands
      { mode = { 'n', 'x' }, keys = 's' },        -- `s` key (mini.surround, etc.)
      { mode = { 'n', 'x' }, keys = 'z' },        -- `z` key
    },
  })
end)

-- Command line tweaks. Improves command line editing with:
-- - Autocompletion. Basically an automated `:h cmdline-completion`.
-- - Autocorrection of words as-you-type. Like `:W`->`:w`, `:lau`->`:lua`, etc.
-- - Autopeek command range (like line number at the start) as-you-type.
later(function() require('mini.cmdline').setup() end)

-- Comment lines. Provides functionality to work with commented lines.
--
-- See also:
-- - `:h commenting`
-- - `:h commentstring`
later(function() require('mini.comment').setup() end)

-- Work with diff hunks that represent the difference between the buffer text and
-- some reference text set by a source. Default source uses text from Git index.
-- Also provides summary info used in developer section of 'mini.statusline'.
-- Example usage:
-- - `ghip` - apply hunks (`gh`) within *i*nside *p*aragraph
-- - `gHG` - reset hunks (`gH`) from cursor until end of buffer (`G`)
-- - `ghgh` - apply (`gh`) hunk at cursor (`gh`)
-- - `gHgh` - reset (`gH`) hunk at cursor (`gh`)
-- - `<Leader>go` - toggle overlay
--
-- See also:
-- - `:h MiniDiff-overview` - overview of how module works
-- - `:h MiniDiff-diff-summary` - available summary information
-- - `:h MiniDiff.gen_source` - available built-in sources
later(
  function()
    require('mini.diff').setup({
      mappings = {
        apply = '<leader>gh',
        reset = '<leader>gH',
        textobject = '<leader>gh',
      },
    })
  end
)

-- Git integration for more straightforward Git actions based on Neovim's state.
-- It is not meant as a fully featured Git client, only to provide helpers that
-- integrate better with Neovim. Example usage:
-- - `<Leader>gs` - show information at cursor
-- - `<Leader>gd` - show unstaged changes as a patch in separate tabpage
-- - `<Leader>gL` - show Git log of current file
-- - `:Git help git` - show output of `git help git` inside Neovim
--
-- See also:
-- - `:h MiniGit-examples` - examples of common setups
-- - `:h :Git` - more details about `:Git` user command
-- - `:h MiniGit.show_at_cursor()` - what information at cursor is shown
later(function() require('mini.git').setup() end)

-- Highlight patterns in text. Like `TODO`/`NOTE` or color hex codes.
--
-- See also:
-- - `:h MiniHipatterns-examples` - examples of common setups
-- - `:Pick hipatterns` - pick among all highlighted patterns
later(function()
  local hipatterns = require('mini.hipatterns')
  local hi_words = MiniExtra.gen_highlighter.words
  hipatterns.setup({
    highlighters = {
      -- Highlight a fixed set of common words. Will be highlighted in any place,
      -- not like "only in comments".
      fixme = hi_words({ 'FIXME', 'Fixme', 'fixme' }, 'MiniHipatternsFixme'),
      hack = hi_words({ 'HACK', 'Hack', 'hack' }, 'MiniHipatternsHack'),
      todo = hi_words({ 'TODO', 'Todo', 'todo' }, 'MiniHipatternsTodo'),
      note = hi_words({ 'NOTE', 'Note', 'note' }, 'MiniHipatternsNote'),

      -- Highlight hex color string (#aabbcc) with that color as a background
      hex_color = hipatterns.gen_highlighter.hex_color(),
    },
  })
end)

-- Visualize and work with indent scope.
--
-- See also:
-- - `:h MiniIndentscope.gen_animation` - available animation rules
later(
  function()
    require('mini.indentscope').setup({
      draw = {
        delay = 1000,
      },
    })
  end
)

-- Jump to next/previous single character.
later(
  function()
    require('mini.jump').setup({
      mappings = {
        repeat_jump = ',',
      },
    })
  end
)

-- Special key mappings. Provides helpers to map:
-- - Multi-step actions. Apply action 1 if condition is met; else apply
--   action 2 if condition is met; etc.
-- - Combos. Sequence of keys where each acts immediately plus execute extra
--   action if all are typed fast enough. Useful for Insert mode mappings to not
--   introduce delay when typing mapping keys without intention to execute action.
--
-- See also:
-- - `:h MiniKeymap-examples` - examples of common setups
-- - `:h MiniKeymap.map_multistep()` - map multi-step action
-- - `:h MiniKeymap.map_combo()` - map combo
later(function()
  require('mini.keymap').setup()

  -- Navigate 'mini.completion' menu with `<Tab>` /  `<S-Tab>`
  MiniKeymap.map_multistep('i', '<Tab>', { 'pmenu_next' })
  MiniKeymap.map_multistep('i', '<S-Tab>', { 'pmenu_prev' })

  -- On `<CR>` try to accept current completion item, fall back to accounting
  -- for pairs from 'mini.pairs'
  MiniKeymap.map_multistep('i', '<CR>', { 'pmenu_accept', 'minipairs_cr' })

  -- On `<BS>` just try to account for pairs from 'mini.pairs'
  MiniKeymap.map_multistep('i', '<BS>', { 'minipairs_bs' })
end)

-- Move any selection in any direction.
--
-- Example usage in Normal mode:
-- - `<M-j>`/`<M-k>` - move current line down / up
-- - `<M-h>`/`<M-l>` - decrease / increase indent of current line
--
-- Example usage in Visual mode:
-- - `<M-h>`/`<M-j>`/`<M-k>`/`<M-l>` - move selection left/down/up/right
later(function() require('mini.move').setup() end)

-- Text edit operators.
--
-- See also:
-- - `:h MiniOperators-mappings` - overview of how mappings are created
-- - `:h MiniOperators-overview` - overview of present operators
later(function()
  -- stylua: ignore
  require('mini.operators').setup({
    evaluate = { prefix = 'g=' },
    exchange = { prefix = 'gX' }, -- Use `.` to repeat exchange operator
    multiply = { prefix = 'gm' },
    replace  = { prefix = 'gR' },
    sort     = { prefix = 'gs' },
  })

  -- Create mappings for swapping adjacent arguments.
  --
  -- Explanation: `gx`-`ia`-`gx`-`ila` <=> exchange current and last argument
  -- Usage: when on `a` in `(aa, bb)` press `)` followed by `(`.
  vim.keymap.set('n', '(', 'gXiagXila', { remap = true, desc = 'Swap arg left' })
  vim.keymap.set('n', ')', 'gXiagXina', { remap = true, desc = 'Swap arg right' })
end)

-- Autopairs functionality.
later(function() require('mini.pairs').setup() end)

-- Pick anything with single window layout and fast matching. T
later(function()
  local center_window = function()
    local height = math.floor(0.618 * vim.o.lines)
    local width = math.floor(0.618 * vim.o.columns)

    local row = math.floor(0.5 * (vim.o.lines - height))
    local col = math.floor(0.5 * (vim.o.columns - width))

    return {
      anchor = 'NW',
      height = height,
      width = width,
      row = row,
      col = col,
    }
  end

  require('mini.pick').setup({
    mappings = {
      send_to_quickfix = {
        char = '<c-q>',
        func = function()
          local matches = MiniPick.get_picker_matches()
          if not matches or not matches.all or #matches.all == 0 then return end

          MiniPick.default_choose_marked(matches.all, { list_type = 'quickfix' })
          return true
        end,
      },
    },
    window = {
      config = center_window,
    },
  })
end)

-- Manage and expand snippets (templates for a frequently used text).
--
-- See also:
-- - `:h MiniSnippets-overview` - overview of how module works
-- - `:h MiniSnippets-examples` - examples of common setups
-- - `:h MiniSnippets-session` - details about snippet session
-- - `:h MiniSnippets.gen_loader` - list of available loaders
later(function()
  -- Define language patterns to work better with 'friendly-snippets'
  local latex_patterns = { 'latex/**/*.json', '**/latex.json' }
  local lang_patterns = {
    tex = latex_patterns,
    plaintex = latex_patterns,
    -- Recognize special injected language of markdown tree-sitter parser
    markdown_inline = { 'markdown.json' },
  }

  local snippets = require('mini.snippets')
  local config_path = vim.fn.stdpath('config')
  snippets.setup({
    snippets = {
      -- Always load 'snippets/global.json' from config directory
      snippets.gen_loader.from_file(config_path .. '/snippets/global.json'),
      -- Load from 'snippets/' directory of plugins, like 'friendly-snippets'
      snippets.gen_loader.from_lang({ lang_patterns = lang_patterns }),
    },
    -- Snippet expansion conflicts with escape
    mappings = {
      expand = '',
    },
  })

  -- By default snippets available at cursor are not shown as candidates in
  -- 'mini.completion' menu. This requires a dedicated in-process LSP server
  -- that will provide them. To have that, uncomment next line (use `gcc`).
  MiniSnippets.start_lsp_server()
end)

-- Surround actions: add/delete/replace/find/highlight. Working with surroundings
-- is surprisingly common: surround word with quotes, replace `)` with `]`, etc.
-- This module comes with many built-in surroundings, each identified by a single
-- character. It searches only for surrounding that covers cursor and comes with
-- a special "next" / "last" versions of actions to search forward or backward
-- (just like 'mini.ai'). All text editing actions are dot-repeatable (see `:h .`).
--
-- Example usage (this may feel intimidating at first, but after practice it
-- becomes second nature during text editing):
-- - `saiw)` - *s*urround *a*dd for *i*nside *w*ord parenthesis (`)`)
-- - `sdf`   - *s*urround *d*elete *f*unction call (like `f(var)` -> `var`)
-- - `srb[`  - *s*urround *r*eplace *b*racket (any of [], (), {}) with padded `[`
-- - `sf*`   - *s*urround *f*ind right part of `*` pair (like bold in markdown)
-- - `shf`   - *s*urround *h*ighlight current *f*unction call
-- - `srn{{` - *s*urround *r*eplace *n*ext curly bracket `{` with padded `{`
-- - `sdl'`  - *s*urround *d*elete *l*ast quote pair (`'`)
-- - `vaWsa<Space>` - *v*isually select *a*round *W*ORD and *s*urround *a*dd
--                    spaces (`<Space>`)
--
-- See also:
-- - `:h MiniSurround-builtin-surroundings` - list of all supported surroundings
-- - `:h MiniSurround-surrounding-specification` - examples of custom surroundings
-- - `:h MiniSurround-vim-surround-config` - alternative set of action mappings
later(function() require('mini.surround').setup() end)

-- Highlight and remove trailspace.
later(function() require('mini.trailspace').setup() end)

-- Track and reuse file system visits. Every file/directory visit is persistently
-- tracked on disk to later reuse: show in special frecency order, etc. It also
-- supports adding labels to visited paths to quickly navigate between them.
--
-- See also:
-- - `:h MiniVisits-overview` - overview of how module works
-- - `:h MiniVisits-examples` - examples of common setups
later(function() require('mini.visits').setup() end)
