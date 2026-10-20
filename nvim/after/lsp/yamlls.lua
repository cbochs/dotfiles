return {
  settings = {
    redhat = {
      telemetry = {
        enabled = false,
      },
    },
    yaml = {
      validate = true,
      format = {
        enable = false, -- Prefer yamlfix
      },
      customTags = {
        '!reference sequence',
      },
      schemaStore = {
        enable = false, -- Prefer SchemaStore.nvim
        url = '',
      },
    },
  },
  before_init = function(_, config)
    -- provide schemas before client init instead of explicitly in the setting
    -- to allow for lazy-loading the schemastore config.
    config.settings.yaml.schemas = require('schemastore').yaml.schemas()
  end,
  on_init = function(client)
    -- nvim-lspconfig sets this to `true` (the default is `false`), must
    -- override in local config to make sure yamlls is not publishing itself as
    -- a formating provider.
    client.server_capabilities.documentFormattingProvider = false
  end,
}
