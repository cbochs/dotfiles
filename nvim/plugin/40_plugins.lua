-- ┌─────────────────────────┐
-- │ Plugins outside of MINI │
-- └─────────────────────────┘

local add = vim.pack.add
local now, now_if_args, later = Config.now, Config.now_if_args, Config.later

now(function()
  add({ 'https://github.com/rebelot/kanagawa.nvim' })

  require('kanagawa').setup({
    compile = true,
    dimInactive = true,
  })

  vim.cmd('colorscheme kanagawa')
end)

later(function()
  add({ 'https://github.com/Wansmer/treesj' })

  local util = require('treesj.langs.utils')
  local json = require('treesj.langs.json')

  require('treesj').setup({
    -- prefer overriding `gj` instead of leader mappings
    use_default_keymaps = false,

    -- 50% more than the 120 default
    max_join_length = 180,

    -- Custom languages
    langs = {
      jsonnet = util.merge_preset(json, {}),
    },
  })
end)

-- Tree-sitter ================================================================

now_if_args(function()
  -- Define hook to update tree-sitter parsers after plugin is updated
  local ts_update = function() vim.cmd('TSUpdate') end
  Config.on_packchanged('nvim-treesitter', { 'update' }, ts_update, ':TSUpdate')

  local add_dang_parser = function()
    require('nvim-treesitter.parsers').dang = {
      install_info = {
        url = 'https://github.com/vito/dang',
        location = 'treesitter',
        files = { 'src/parser.c' },
        branch = 'main',
      },
    }
  end
  Config.new_autocmd('User', 'TSUpdate', add_dang_parser)

  add({
    {
      src = 'https://github.com/nvim-treesitter/nvim-treesitter',
      version = 'main',
    },
    {
      src = 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects',
      version = 'main',
    },
  })

  local languages = {
    -- These are already pre-installed with Neovim. Used as an example.
    'lua',
    'vimdoc',
    'markdown',

    -- Add here more languages with which you want to use tree-sitter
    -- To see available languages:
    -- - Execute `:=require('nvim-treesitter').get_available()`
    -- - Visit 'SUPPORTED_LANGUAGES.md' file at
    --   https://github.com/nvim-treesitter/nvim-treesitter/blob/main

    'c',
    'dang',
    'dockerfile',
    'git_config',
    'gitignore',
    'go',
    'gomod',
    'gosum',
    'gotmpl',
    'gowork',
    'graphql',
    'html',
    'json',
    'json5',
    'jsonnet',
    'markdown_inline',
    'nix',
    'ruby',
    'rust',
    'toml',
    'yaml',
  }

  local isnt_installed = function(lang)
    return #vim.api.nvim_get_runtime_file('parser/' .. lang .. '.*', false) == 0
  end
  local to_install = vim.tbl_filter(isnt_installed, languages)
  if #to_install > 0 then require('nvim-treesitter').install(to_install) end

  -- Enable tree-sitter after opening a file for a target language
  local filetypes = {}
  for _, lang in ipairs(languages) do
    for _, ft in ipairs(vim.treesitter.language.get_filetypes(lang)) do
      table.insert(filetypes, ft)
    end
  end

  local ts_start = function(ev) vim.treesitter.start(ev.buf) end
  Config.new_autocmd('FileType', filetypes, ts_start, 'Start tree-sitter')

  -- Configure additional filetypes and extensions
  vim.filetype.add({
    extension = {
      dang = 'dang',
    },
  })
end)

-- Language servers ===========================================================

now_if_args(function()
  add({
    'https://github.com/neovim/nvim-lspconfig',
    'https://github.com/b0o/schemastore.nvim',
  })

  vim.lsp.enable({
    'dang',
    'gopls',
    'jsonnet_ls',
    'lua_ls',
    'marksman',
    'nil_ls',
    'ruff',
    'rust_analyzer',
    'terraformls',
    'ty',
    'yamlls',
  })
end)

-- Formatting =================================================================

later(function()
  add({ 'https://github.com/stevearc/conform.nvim' })

  require('conform').setup({
    default_format_opts = {
      -- Allow formatting from LSP server if no dedicated formatter is available
      lsp_format = 'fallback',
    },

    -- stylua: ignore
    formatters_by_ft = {
      dang      = { command = 'dang', args = { 'fmt' } },
      fish      = { 'fish_indent' },
      go        = { 'goimports', 'gofumpt' },
      http      = { 'kulala-fmt' },
      json      = { 'pretty_format_json' },
      jsonnet   = { 'jsonnetfmt' },
      lua       = { 'stylua' },
      markdown  = { 'mdformat' },
      python    = { 'ruff' },
      rust      = { 'rustfmt' },
      sh        = { 'shfmt' },
      terraform = { 'terraform_fmt' },
      yaml      = { 'yamlfix' },
    },

    formatters = {
      -- Hermit uses mdformat with compact tables and the GFM plugin
      mdformat = {
        prepend_args = { '--compact-tables' },
      },

      -- Hermit uses the pretty-format-json precommit hook
      -- This is effectively a json.dumps from python3 with some default settings.
      -- Source: https://github.com/pre-commit/pre-commit-hooks/blob/v6.0.0/pre_commit_hooks/pretty_format_json.py
      pretty_format_json = {
        command = 'python3',
        args = {
          '-c',
          'import json, sys; print(json.dumps(json.load(sys.stdin), indent=2, ensure_ascii=True, sort_keys=True))',
        },
        stdin = true,
      },

      -- Hermit uses a default set of rules for yamlfix
      yamlfix = {
        prepend_args = {
          '--config-file',
          vim.fn.stdpath('config') .. '/hermit/yamlfix.toml',
        },
      },
    },
  })

  local pre_write = function(args)
    if Config.toggles.format then
      MiniTrailspace.trim()
      MiniTrailspace.trim_last_lines()

      require('conform').format({ bufnr = args.buf })
    end
  end
  Config.new_autocmd('BufWritePre', nil, pre_write, 'Format')
end)

-- Linting ====================================================================

later(function()
  add({ 'https://github.com/mfussenegger/nvim-lint' })

  local lint = require('lint')

  -- stylua: ignore
  lint.linters_by_ft = {
    dockerfile = { 'hadolint' },
    markdown   = { 'markdownlint' },
    sh         = { 'shellcheck' },
    yaml       = { 'yamllint' },
  }

  -- Hermit uses a default set of rules for markdownlint
  local markdownlint = vim.deepcopy(lint.linters.markdownlint)
  markdownlint.args = vim.list_extend(
    { '--config', vim.fn.stdpath('config') .. '/hermit/markdownlint.yaml' },
    markdownlint.args
  )
  lint.linters.markdownlint = markdownlint

  -- Hermit uses a default set of rules for yamllint
  local yamllint = vim.deepcopy(lint.linters.yamllint)
  yamllint.args = vim.list_extend(
    { '--config-file', vim.fn.stdpath('config') .. '/hermit/yamllint.yaml' },
    yamllint.args
  )
  lint.linters.yamllint = yamllint

  local post_write = function(ev)
    local bufname = vim.api.nvim_buf_get_name(ev.buf)
    local basename = vim.fn.fnamemodify(bufname, ':t')

    local filter_gitlabci = function(linter)
      return not (linter.name == 'yamllint' and basename == '.gitlab-ci.yml')
    end

    require('lint').try_lint(nil, {
      filter = filter_gitlabci,
    })
  end
  Config.new_autocmd('BufWritePost', nil, post_write, 'Lint')
end)

-- Snippets ===================================================================

-- Although 'mini.snippets' provides functionality to manage snippet files, it
-- deliberately doesn't come with those.
--
-- The 'rafamadriz/friendly-snippets' is currently the largest collection of
-- snippet files. They are organized in 'snippets/' directory (mostly) per language.
-- 'mini.snippets' is designed to work with it as seamlessly as possible.
-- See `:h MiniSnippets.gen_loader.from_lang()`.
later(function() add({ 'https://github.com/rafamadriz/friendly-snippets' }) end)
