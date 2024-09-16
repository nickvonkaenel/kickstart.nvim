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
      dashboard.button('e', '  > New File', '<cmd>ene<CR>'),
      dashboard.button('SPC ee', '  > Toggle file explorer', ':Neotree reveal<CR>:set relativenumber!<CR>'),
      dashboard.button('SPC sf', '󰱼  > Find File', '<cmd>Telescope find_files<CR>'),
      dashboard.button('SPC sg', '  > Find Word', '<cmd>Telescope live_grep<CR>'),
      dashboard.button('SPC wr', '󰁯  > Restore Session', '<cmd>SessionRestore<CR>'),
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
