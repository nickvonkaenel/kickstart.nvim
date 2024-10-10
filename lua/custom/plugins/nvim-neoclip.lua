return {
  'AckslD/nvim-neoclip.lua',
  dependencies = {
    -- you'll need at least one of these
    -- {'nvim-telescope/telescope.nvim'},
    -- {'ibhagwan/fzf-lua'},
  },

  config = function()
    require('neoclip').setup {
      keys = {
        telescope = {
          i = {
            select = '<tab>', -- not sure what this does
            paste = { '<cr>', '<c-p>' },
            paste_behind = { '<s-cr>', '<c-P>' },
            replay = '<c-q>', -- replay a macro
            delete = '<c-l>', -- delete an entry
            edit = '<c-e>', -- edit an entry
            custom = {},
          },
          n = {
            select = '<tab>',
            paste = 'p',
            --- It is possible to map to more than one key.
            -- paste = { 'p', '<c-p>' },
            paste_behind = 'P',
            replay = 'q',
            delete = 'd',
            edit = 'e',
            custom = {},
          },
        },
        -- fzf = {
        --   select = 'default',
        --   paste = 'ctrl-p',
        --   paste_behind = 'ctrl-k',
        --   custom = {},
        -- },
      },
    }
    vim.keymap.set('n', '<leader>sy', '<cmd>Telescope neoclip<cr>', { desc = '[S]earch [Y]anked Text' })
  end,
}
