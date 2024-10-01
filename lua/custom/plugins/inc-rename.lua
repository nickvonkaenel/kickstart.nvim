return {
  'smjonas/inc-rename.nvim',
  config = function()
    require('inc_rename').setup()
    vim.keymap.set('n', '<leader>d', ':IncRename ', { desc = 'Rename' })
  end,
}
