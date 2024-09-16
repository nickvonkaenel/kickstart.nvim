return {
  'goolord/alpha-nvim',
  event = 'VimEnter',
  config = function()
    local alpha = require 'alpha'
    local dashboard = require 'alpha.themes.dashboard'

    dashboard.section.header.val = {
      '',
      '',
      '',
      '',
      '',
      '                                                                               ',
      '   ▓▓▓▓▓▓▓▓▓▓░                      ▓░          ▓░                    ▓░       ',
      '  ▓▓▓▓    ▓▓        ▓▓▓▓▓░  ▓░   ▓░ ▓░ ▓▓░     ▓▓▓▓░  ▓▓▓▓░   ▓▓▓▓░   ▓░ ▓▓▓▓▓░',
      ' ▒▓▓      ░         ▓░   ▓░  ▓░ ▓░  ▓▓▓░        ▓░   ▓░   ▓░ ▓░   ▓░  ▓░  ▓▓░  ',
      ' ▒▓           ▓     ▓░   ▓░  ▓░ ▓░  ▓░ ▓░       ▓░   ▓░   ▓░ ▓░   ▓░  ▓░   ▓▓░ ',
      '      ▓     ▓▓      ▓░   ▓░   ▓▓░   ▓░  ▓░ ▓░    ▓▓░  ▓▓▓▓░   ▓▓▓▓░   ▓░ ▓▓▓▓▓░',
      '   ▒▓▓▓   ▓▓▓                                                                  ',
      '    ▒▓▓▓▓▓▓         󰋅 Reaper  |    Game Audio  |    Sound Design  |   Neovim',
      '',
      '',
      '',
      '',
    }

    -- Set menu
    dashboard.section.buttons.val = {
      dashboard.button('o', '  > New File', '<cmd>ene<CR>'),
      dashboard.button('e', '  > Toggle file explorer', '<cmd>Telescope file_browser<CR>'),
      dashboard.button('f', '󰱼  > Find File', '<cmd>Telescope find_files<CR>'),
      dashboard.button('g', '  > Find Word', '<cmd>Telescope live_grep<CR>'),
      dashboard.button('r', '󰁯  > Restore Session', '<cmd>SessionRestore<CR>'),
      dashboard.button('l', '  > LazyGit', '<cmd>LazyGit<CR>'),
      dashboard.button('n', '󰋅  > Open nvk-ReaScripts', ':Nvk<CR>'),
      dashboard.button('v', '  > Open Neovim Config', ':Nvim<CR>'),
      dashboard.button('q', '  > Quit NVIM', '<cmd>qa<CR>'),
    }

    dashboard.section.header.opts.hl = 'String'

    -- Send config to alpha
    alpha.setup(dashboard.opts)

    -- Disable folding on alpha buffer
    vim.cmd [[autocmd FileType alpha setlocal nofoldenable]]
  end,
}
