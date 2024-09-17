return {
  'goolord/alpha-nvim',
  event = 'VimEnter',
  config = function()
    local alpha = require 'alpha'
    local dashboard = require 'alpha.themes.dashboard'
    local time = os.date '%I:%M %p' -- 12-hour format with AM/PM
    local day = os.date '%A'
    local date = os.date '%b %d %Y' -- Month Day Year format (e.g., Sep 16 2024)
    local v = vim.version()
    local version = '  v' .. v.major .. '.' .. v.minor .. '.' .. v.patch
    ---@cast time string
    if time:sub(1, 1) == '0' then
      time = time:sub(2)
    end
    dashboard.section.header.val = {
      '  ▓▓▓▓▓▓▓▓▓▓░                      ▓░          ▓░                    ▓░       ',
      ' ▓▓▓░    ▓▓░       ▓▓▓▓▓░  ▓░   ▓░ ▓░ ▓▓░     ▓▓▓▓░  ▓▓▓▓░   ▓▓▓▓░   ▓░  ▓▓▓▓░',
      '▓▓░      ▓░        ▓░   ▓░  ▓░ ▓░  ▓▓▓░        ▓░   ▓░   ▓░ ▓░   ▓░  ▓░ ▓▓░   ',
      '▓░           ▓░    ▓░   ▓░  ▓░ ▓░  ▓░ ▓░       ▓░   ▓░   ▓░ ▓░   ▓░  ▓░    ▓▓░',
      '     ▓░     ▓░     ▓░   ▓░   ▓▓░   ▓░  ▓░  ▓░   ▓▓░  ▓▓▓▓░   ▓▓▓▓░   ▓░ ▓▓▓▓░ ',
      '  ▓▓▓▓░   ▓▓▓░                                                                ',
      '   ▓▓▓▓▓▓▓░        󰋅 Reaper  |    Game Audio  |    Sound Design  |   Neovim',
    }

    -- Set menu
    dashboard.section.buttons.val = {
      dashboard.button('o', '  > New File', '<cmd>ene<CR>'),
      dashboard.button('e', '  > Browse Files', '<cmd>Telescope file_browser<CR>'),
      dashboard.button('f', '󰱼  > Find File', '<cmd>Telescope find_files<CR>'),
      dashboard.button('g', '  > Find Word', '<cmd>Telescope live_grep<CR>'),
      dashboard.button('r', '󰁯  > Restore Session', '<cmd>SessionRestore<CR>'),
      dashboard.button('l', '  > LazyGit', '<cmd>LazyGit<CR>'),
      dashboard.button('n', '󰋅  > Open nvk-ReaScripts', ':Nvk<CR>'),
      dashboard.button('v', '  > Open Neovim Config', ':Nvim<CR>'),
      dashboard.button('q', '  > Quit NVIM', '<cmd>qa<CR>'),
    }

    dashboard.section.header.opts.hl = 'String'

    dashboard.opts.layout = {
      { type = 'padding', val = 4 },
      dashboard.section.header,
      { type = 'padding', val = 4 },
      dashboard.section.buttons,
      { type = 'padding', val = 2 },
      dashboard.section.footer,
    }
    -- dashboard.opts.opts.margin = 50
    local function centerText(text, width)
      local totalPadding = width - #text
      local leftPadding = math.floor(totalPadding / 2)
      local rightPadding = totalPadding - leftPadding
      return string.rep(' ', leftPadding) .. text .. string.rep(' ', rightPadding)
    end

    local function leftText(text, width)
      local totalPadding = width - #text + 1
      return text .. string.rep(' ', totalPadding)
    end

    print(os.date '%H')
    local dayicon = tonumber(os.date '%H') < 18 and '' or ''

    dashboard.section.footer.val = {
      centerText('  ' .. time, 50),
      '',
      centerText(dayicon .. '  ' .. day, 50),
      '',
      centerText('  ' .. date, 50),
      '',
      centerText(version, 50),
    }

    -- Send config to alpha
    alpha.setup(dashboard.opts)

    -- Disable folding on alpha buffer
    vim.cmd [[autocmd FileType alpha setlocal nofoldenable]]
  end,
}
