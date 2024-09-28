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
      '  ██████████░                      █░          █░                    █░       ',
      ' ███░    ██░       █████░  █░   █░ █░ ██░     ████░  ████░   ████░   █░  ████░',
      '██░      █░        █░   █░  █░ █░  ███░        █░   █░   █░ █░   █░  █░ ██░   ',
      '█░           █░    █░   █░  █░ █░  █░ █░       █░   █░   █░ █░   █░  █░    ██░',
      '     █░     █░     █░   █░   ██░   █░  █░  █░   ██░  ████░   ████░   █░ ████░ ',
      '  ████░   ███░                                                                ',
      '   ███████░        󰋅 Reaper  |    Game Audio  |    Sound Design  |   Neovim',
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
      { type = 'padding', val = 2 },
      dashboard.section.header,
      { type = 'padding', val = 4 },
      dashboard.section.buttons,
      { type = 'padding', val = 4 },
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
    -- alpha.setup(dashboard.opts)

    -- Disable folding on alpha buffer
    vim.cmd [[autocmd FileType alpha setlocal nofoldenable]]

    -- helper function for utf8 chars
    local function getCharLen(s, pos)
      local byte = string.byte(s, pos)
      if not byte then
        return nil
      end
      return (byte < 0x80 and 1) or (byte < 0xE0 and 2) or (byte < 0xF0 and 3) or (byte < 0xF8 and 4) or 1
    end

    local function applyColors(logo, colors, logoColors)
      dashboard.section.header.val = logo

      for key, color in pairs(colors) do
        local name = 'Alpha' .. key
        vim.api.nvim_set_hl(0, name, color)
        colors[key] = name
      end

      dashboard.section.header.opts.hl = {}
      for i, line in ipairs(logoColors) do
        local highlights = {}
        local pos = 0

        for j = 1, #line do
          local opos = pos
          pos = pos + getCharLen(logo[i], opos + 1)

          local color_name = colors[line:sub(j, j)]
          if color_name then
            table.insert(highlights, { color_name, opos, pos })
          end
        end

        table.insert(dashboard.section.header.opts.hl, highlights)
      end
      return dashboard.opts
    end

    alpha.setup(applyColors({
      [[                               ███       ███  ]],
      [[                               ████      ████ ]],
      [[                               ████     █████ ]],
      [[                              █ ████    █████ ]],
      [[                              ██ ████   █████ ]],
      [[                              ███ ████  █████ ]],
      [[                              ████ ████ ████ ]],
      [[                              █████  ████████ ]],
      [[                              █████   ███████ ]],
      [[                              █████    ██████ ]],
      [[                              █████     █████ ]],
      [[                              ████      ████ ]],
      [[                               ███       ███  ]],
      [[                                                 ]],
      [[                               N  E  O  V  I  M  ]],
      '',
      '',
      '',
      '  ██████████░                      █░          █░                    █░       ',
      ' ███░    ██░       █████░  █░   █░ █░ ██░     ████░  ████░   ████░   █░  ████░',
      '██░      █░        █░   █░  █░ █░  ███░        █░   █░   █░ █░   █░  █░ ██░   ',
      '█░           █░    █░   █░  █░ █░  █░ █░       █░   █░   █░ █░   █░  █░    ██░',
      '     █░     █░     █░   █░   ██░   █░  █░  █░   ██░  ████░   ████░   █░ ████░ ',
      '  ████░   ███░                                                                ',
      '   ███████░        󰋅 Reaper       Game Audio       Sound Design      Neovim',
    }, {
      ['b'] = { fg = '#3399ff', ctermfg = 33 },
      ['a'] = { fg = '#53C670', ctermfg = 35 },
      ['g'] = { fg = '#39ac56', ctermfg = 29 },
      ['h'] = { fg = '#33994d', ctermfg = 23 },
      ['i'] = { fg = '#33994d', bg = '#39ac56', ctermfg = 23, ctermbg = 29 },
      ['j'] = { fg = '#53C670', bg = '#33994d', ctermfg = 35, ctermbg = 23 },
      ['k'] = { fg = '#30A572', ctermfg = 36 },
      ['n'] = { fg = '#13BD99' },
      ['o'] = { fg = '#5ebda8' },
      ['p'] = { fg = '#808080' },
      ['q'] = { fg = '#808080' },
    }, {
      [[                               kkkka       gggg  ]],
      [[                               kkkkaa      ggggg ]],
      [[                              b kkkaaa     ggggg ]],
      [[                              bb kkaaaa    ggggg ]],
      [[                              bbb kaaaaa   ggggg ]],
      [[                              bbbb aaaaaa  ggggg ]],
      [[                              bbbbb aaaaaa igggg ]],
      [[                              bbbbb  aaaaaahiggg ]],
      [[                              bbbbb   aaaaajhigg ]],
      [[                              bbbbb    aaaaajhig ]],
      [[                              bbbbb     aaaaajhi ]],
      [[                              bbbbb      aaaaajh ]],
      [[                               bbbb       aaaaa  ]],
      [[                                                 ]],
      [[                               a  a  a  b  b  b  ]],
      '',
      '',
      '',
      '  nnnnnnnnnno                      no          no                    no       ',
      ' nnno    nno       nnnnno  no   no no nno     nnnno  nnnno   nnnno   no  nnnno',
      'nno      no        no   no  no no  nnno        no   no   no no   no  no nno   ',
      'no           no    no   no  no no  no no       no   no   no no   no  no    nno',
      '     no     no     no   no   nno   no  no  no   nno  nnnno   nnnno   no nnnno ',
      '  nnnno   nnno                                                                ',
      '   nnnnnnno        q pppppp  p  q  pppp ppppp  p  q  ppppp pppppp  p  q pppppp',
    }))
  end,
}
