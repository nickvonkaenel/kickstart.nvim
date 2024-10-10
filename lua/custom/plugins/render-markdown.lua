return {
  -- Make sure to set this up properly if you have lazy=true
  'MeanderingProgrammer/render-markdown.nvim',
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {
    file_types = { 'markdown', 'Avante' },
    checkbox = {
      checked = {
        highlight = 'NONE',
      },
    },
  },
  ft = { 'markdown', 'Avante' },
}
