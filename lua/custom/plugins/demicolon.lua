return {
  'mawkler/demicolon.nvim',
  keys = { ';', ',', ']', '[', ']d', '[d' }, -- Uncomment this to lazy load
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  opts = {
    keymaps = {
      horizontal_motions = false,
    },
  },
}
