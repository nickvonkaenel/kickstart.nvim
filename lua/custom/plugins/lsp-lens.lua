return {
  'VidocqH/lsp-lens.nvim',
  config = function()
    require('lsp-lens').setup {
      enable = false,
      sections = {
        git_authors = false,
        implements = false,
        definition = function(count)
          if count == 1 then
            return ''
          end
          return count .. ' Defs'
        end,
        references = function(count)
          if count == 0 then
            return 'NO REFERENCES'
          elseif count == 1 then
            return '1 Ref'
          end
          return count .. ' Refs'
        end,
      },
    }
    vim.keymap.set('n', '<leader>tr', '<cmd>LspLensToggle<CR>', { desc = '[T]oggle [R]eference Count' })
  end,
}
