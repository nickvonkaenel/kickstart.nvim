return {
  -- Neoscroll is a smooth scrolling plugin for Neovim
  'karb94/neoscroll.nvim',
  config = function()
    require('neoscroll').setup {
      easing = 'quadratic',
    }
  end,
}
