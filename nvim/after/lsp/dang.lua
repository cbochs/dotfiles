return {
  cmd = { 'dang', '--lsp' },
  cmd_env = {
    DAGGER_X_RELEASE = 'v1.0.0-beta.21',
  },
  filetypes = { 'dang' },
  root_markers = {
    '.git',
    'dagger-module.toml',
    'dagger.json',
    'dagger.toml',
  },
}
