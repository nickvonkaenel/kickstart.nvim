return {
  'HiPhish/rainbow-delimiters.nvim',
  config = function()
    local rainbow_delimiters = require 'rainbow-delimiters'
    ---@type rainbow_delimiters.config
    vim.g.rainbow_delimiters = {
      -- strategy = {
      --   [''] = rainbow_delimiters.strategy['global'],
      --   vim = rainbow_delimiters.strategy['local'],
      -- },
      -- query = {
      --   [''] = 'rainbow-delimiters',
      --   lua = 'rainbow-blocks',
      -- },
      -- priority = {
      --   [''] = 110,
      --   lua = 210,
      -- },
      test = { { { { {} } } } }, -- just to show the colors
      highlight = {
        'RainbowDelimiterYellow',
        'RainbowDelimiterViolet',
        -- 'RainbowDelimiterOrange',
        -- 'RainbowDelimiterBlue',
        -- 'RainbowDelimiterCyan',
        'RainbowDelimiterGreen',
        'RainbowDelimiterRed',
      },
    }
  end,
}
