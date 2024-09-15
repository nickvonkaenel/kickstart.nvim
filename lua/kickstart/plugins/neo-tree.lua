-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

local nvk_path = vim.g.nvk_path
local nvim_path = vim.fn.stdpath 'config'

vim.api.nvim_create_user_command('Nvk', function()
  -- Execute Neotree reveal
  vim.cmd('Neotree reveal ' .. nvk_path)
  -- Toggle relative numbers separately
  vim.cmd 'set relativenumber!'
end, {})

-- Create a command to open nvim config
vim.api.nvim_create_user_command('Nvim', function()
  -- Execute Neotree reveal
  vim.cmd('Neotree reveal ' .. nvim_path)
  -- Toggle relative numbers separately
  vim.cmd 'set relativenumber!'
end, {})

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
    { '\\', ':Neotree reveal<CR>:set relativenumber!<CR>', desc = '[E]xplore Tre[e]', silent = true },
    { '<leader>ee', ':Neotree reveal<CR>:set relativenumber!<CR>', desc = '[E]xplore Tre[e]', silent = true },
    { '<leader>er', ':Neotree reveal reveal_force_cwd<CR>:set relativenumber!<CR>', desc = '[E]xplore Fo[R]ce cwd', silent = true },
    { '<leader>en', ':Neotree reveal ' .. nvk_path .. '<CR>:set relativenumber!<CR>', desc = '[E]xplore [N]vk-ReaScripts', silent = true },
    { '<leader>ev', ':Neotree reveal ' .. nvim_path .. '<CR>:set relativenumber!<CR>', desc = '[E]xplore n[V]im config', silent = true },
    { '<leader>eo', ':Neotree float buffers<CR>', desc = '[E]xplore [O]pen files', silent = true },
    { '<leader>eg', ':Neotree float git_status<CR>', desc = '[E]xplore [G]it status', silent = true },
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
