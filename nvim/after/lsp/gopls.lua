return {
  settings = {
    -- stylua: ignore
    gopls = {
      gofumpt = true,            -- Prefer gofumpt formatter
      usePlaceholders = false,   -- Disable completion placeholders
      completeUnimported = true, -- Auto-imports
      semanticTokens = true,     -- Enable semantic highlighting
    },
  },
}
