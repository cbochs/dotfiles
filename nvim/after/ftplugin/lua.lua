-- Set markdown-specific surrounding in 'mini.surround'
vim.b.minisurround_config = {
  custom_surroundings = {
    s = {
      input = { '%[%[().-()%]%]' },
      output = { left = '[[', right = ']]' },
    },
  },
}
