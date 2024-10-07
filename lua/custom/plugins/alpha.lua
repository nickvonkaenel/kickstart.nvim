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

    local leader = 'SPC'

    local if_nil = vim.F.if_nil
    --- @param sc string
    --- @param txt string
    --- @param keybind string? optional
    --- @param keybind_opts table? optional
    local function button(sc, txt, keybind, keybind_opts)
      local sc_ = sc:gsub('%s', ''):gsub(leader, '<leader>')

      local opts = {
        position = 'left',
        shortcut = '',
        cursor = -2,
        width = 0,
        -- align_shortcut = 'right',
        hl_shortcut = 'Keyword',
        hl = 'SpecialComment',
      }
      if keybind then
        keybind_opts = if_nil(keybind_opts, { noremap = true, silent = true, nowait = true })
        opts.keymap = { 'n', sc_, keybind, keybind_opts }
      end

      local function on_press()
        local key = vim.api.nvim_replace_termcodes(keybind or sc_ .. '<Ignore>', true, false, true)
        vim.api.nvim_feedkeys(key, 't', false)
      end

      return {
        type = 'button',
        val = txt,
        on_press = on_press,
        opts = opts,
      }
    end

    dashboard.section.buttons.val = {
      button('o', 'open', '<cmd>ene<CR>'),
      button('s', 'search', '<cmd>Telescope find_files<CR>'),
      button('r', 'restore', '<cmd>SessionRestore<CR>'),
      button('n', 'nvk.tools', ':Nvk<CR>'),
      button('c', 'config', ':Nvim<CR>'),
      -- button('e', 'Browse Files', '<cmd>Telescope file_browser<CR>'),
      -- button('g', 'Find Word', '<cmd>Telescope live_grep<CR>'),
      -- button('l', 'LazyGit', '<cmd>LazyGit<CR>'),
      button('q', 'quit', '<cmd>qa<CR>'),
    }
    -- Set menu
    -- dashboard.section.buttons.val = {
    --   button('o', '  open', '<cmd>ene<CR>'),
    --   button('s', '󰱼  search', '<cmd>Telescope find_files<CR>'),
    --   button('r', '󰁯  restore', '<cmd>SessionRestore<CR>'),
    --   button('n', '󰋅  nvk.tools', ':Nvk<CR>'),
    --   button('c', '  config', ':Nvim<CR>'),
    --   -- button('e', '  Browse Files', '<cmd>Telescope file_browser<CR>'),
    --   -- button('g', '  Find Word', '<cmd>Telescope live_grep<CR>'),
    --   -- button('l', '  LazyGit', '<cmd>LazyGit<CR>'),
    --   button('q', '  quit', '<cmd>qa<CR>'),
    -- }

    -- dashboard.section.buttons.val = {
    --   button('r', ' Restore Session', '<cmd>SessionRestore<CR>'),
    --   button('n', ' nvk-ReaScripts', ':Nvk<CR>'),
    --   button('v', ' Neovim Config', ':Nvim<CR>'),
    --   button('f', ' Find File', '<cmd>Telescope find_files<CR>'),
    --   button('e', ' Browse Files', '<cmd>Telescope file_browser<CR>'),
    --   button('o', ' New File', '<cmd>ene<CR>'),
    --   button('g', ' Find Word', '<cmd>Telescope live_grep<CR>'),
    --   button('l', ' LazyGit', '<cmd>LazyGit<CR>'),
    --   button('q', ' Quit NVIM', '<cmd>qa<CR>'),
    -- }
    dashboard.section.header.opts.hl = 'String'

    dashboard.section.header.opts.position = 'left'
    dashboard.section.footer.opts.position = 'left'

    dashboard.opts.layout = {
      { type = 'padding', val = 2 },
      dashboard.section.header,
      { type = 'padding', val = 2 },
      -- dashboard.section.footer,
      -- { type = 'padding', val = 2 },
      dashboard.section.buttons,
    }
    -- dashboard.opts.opts.margin = 50
    local function centerText(text, width)
      if true then
        return text
      end
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
    local daynumber = tonumber(os.date '%H')
    local dayicon = (daynumber < 18 and daynumber > 4) and '' or ''

    dashboard.section.footer.val = {
      table.concat({ ('  ' .. time), (dayicon .. '  ' .. day), ('  ' .. date), version }, '           '):lower(),
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
        ---@diagnostic disable-next-line we know it's a table
        table.insert(dashboard.section.header.opts.hl, highlights)
      end
      return dashboard.opts
    end

    alpha.setup(applyColors({
      -- [[                               ███       ███  ]],
      -- [[                               ████      ████ ]],
      -- [[                               ████     █████ ]],
      -- [[                              █ ████    █████ ]],
      -- [[                              ██ ████   █████ ]],
      -- [[                              ███ ████  █████ ]],
      -- [[                              ████ ████ ████ ]],
      -- [[                              █████  ████████ ]],
      -- [[                              █████   ███████ ]],
      -- [[                              █████    ██████ ]],
      -- [[                              █████     █████ ]],
      -- [[                              ████      ████ ]],
      -- [[                               ███       ███  ]],
      -- [[                                                 ]],
      -- [[                               N  E  O  V  I  M  ]],
      -- '',
      -- '',
      -- '',
      '  ██████████░                      █░          █░                    █░       ',
      ' ███░    ██░       █████░  █░   █░ █░ ██░     ████░  ████░   ████░   █░  ████░',
      '██░      █░        █░   █░  █░ █░  ███░        █░   █░   █░ █░   █░  █░ ██░   ',
      '█░           █░    █░   █░  █░ █░  █░ █░       █░   █░   █░ █░   █░  █░    ██░',
      '     █░     █░     █░   █░   ██░   █░  █░  █░   ██░  ████░   ████░   █░ ████░ ',
      '  ████░   ███░                                                                ',
      '   ███████░        󰋅 reaper       game audio       sound design      neovim',
    }, {
      ['b'] = { fg = '#3399ff', ctermfg = 33 },
      ['a'] = { fg = '#53C670', ctermfg = 35 },
      ['g'] = { fg = '#39ac56', ctermfg = 29 },
      ['h'] = { fg = '#33994d', ctermfg = 23 },
      ['i'] = { fg = '#33994d', bg = '#39ac56', ctermfg = 23, ctermbg = 29 },
      ['j'] = { fg = '#53C670', bg = '#33994d', ctermfg = 35, ctermbg = 23 },
      ['k'] = { fg = '#30A572', ctermfg = 36 },
      ['n'] = { fg = '#55ba9c' }, -- #13BD99 doesn't look right on mac, will have to test on windows
      ['o'] = { fg = '#5ebda8' },
      ['p'] = { fg = '#808080' },
      ['q'] = { fg = '#808080' },
    }, {
      -- [[                               kkkka       gggg  ]],
      -- [[                               kkkkaa      ggggg ]],
      -- [[                              b kkkaaa     ggggg ]],
      -- [[                              bb kkaaaa    ggggg ]],
      -- [[                              bbb kaaaaa   ggggg ]],
      -- [[                              bbbb aaaaaa  ggggg ]],
      -- [[                              bbbbb aaaaaa igggg ]],
      -- [[                              bbbbb  aaaaaahiggg ]],
      -- [[                              bbbbb   aaaaajhigg ]],
      -- [[                              bbbbb    aaaaajhig ]],
      -- [[                              bbbbb     aaaaajhi ]],
      -- [[                              bbbbb      aaaaajh ]],
      -- [[                               bbbb       aaaaa  ]],
      -- [[                                                 ]],
      -- [[                               a  a  a  b  b  b  ]],
      -- '',
      -- '',
      -- '',
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
