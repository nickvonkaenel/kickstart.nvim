-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
  },
  opts = {
    enable_cursor_hijack = true, -- If enabled neotree will keep the cursor on the first letter of the filename when moving in the tree.
    name = {
      highlight_opened_files = true,
    },
    file_size = {
      enabled = true,
      required_width = 84, -- min width of window required to show this column
    },
    type = {
      enabled = true,
      required_width = 130, -- min width of window required to show this column
    },
    last_modified = {
      enabled = true,
      required_width = 108, -- min width of window required to show this column
    },
    created = {
      enabled = false,
      required_width = 140, -- min width of window required to show this column
    },
    filesystem = {
      filtered_items = {
        never_show = { '.git', 'node_modules', '__pycache__', '.DS_Store' },
      },
      hijack_netrw_behavior = 'open_current',
      window = {
        position = 'float',
        popup = {
          size = {
            width = '50%',
            height = '80%',
          },
        },
        mappings = {
          ['\\'] = 'close_window',
        },
      },
    },
  },
}
