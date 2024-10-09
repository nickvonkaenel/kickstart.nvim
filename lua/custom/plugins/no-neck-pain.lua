return {
  'shortcuts/no-neck-pain.nvim',
  opts = {
    width = 120,
    buffers = {
      colors = {
        -- background = '#000000',
        blend = -0.1,
        -- text = '#808080', -- override text color of scratchpads
      },
      scratchPad = {
        enabled = true,
        fileName = 'notes',
        location = '~/',
      },
      bo = {
        filetype = 'md',
      },
    },
  },
}
