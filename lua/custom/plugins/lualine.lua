-- if true then
--   return {}
-- end
return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local lualine = require 'lualine'
    local lazy_status = require 'lazy.status' -- to configure lazy pending updates count

    local colors = {
      bg = '#202020',
      fg = '#abb2bf',
      red = '#ef596f',
      orange = '#d19a66',
      yellow = '#e5c07b',
      green = '#89ca78',
      cyan = '#2bbac5',
      blue = '#61afef',
      purple = '#d55fde',
      white = '#abb2bf',
      black = '#000000',
      gray = '#434852',
      highlight = '#e2be7d',
      comment = '#7f848e',
      none = 'NONE',
    }
    local my_lualine_theme = {
      normal = {
        a = { bg = colors.blue, fg = colors.bg, gui = 'bold' },
        b = { bg = colors.bg, fg = colors.fg },
        c = { bg = colors.bg, fg = colors.fg },
      },
      insert = {
        a = { bg = colors.green, fg = colors.bg, gui = 'bold' },
        b = { bg = colors.bg, fg = colors.fg },
        c = { bg = colors.bg, fg = colors.fg },
      },
      visual = {
        a = { bg = colors.purple, fg = colors.bg, gui = 'bold' },
        b = { bg = colors.bg, fg = colors.fg },
        c = { bg = colors.bg, fg = colors.fg },
      },
      command = {
        a = { bg = colors.yellow, fg = colors.bg, gui = 'bold' },
        b = { bg = colors.bg, fg = colors.fg },
        c = { bg = colors.bg, fg = colors.fg },
      },
      replace = {
        a = { bg = colors.red, fg = colors.bg, gui = 'bold' },
        b = { bg = colors.bg, fg = colors.fg },
        c = { bg = colors.bg, fg = colors.fg },
      },
      inactive = {
        a = { bg = colors.inactive_bg, fg = colors.semilightgray, gui = 'bold' },
        b = { bg = colors.inactive_bg, fg = colors.semilightgray },
        c = { bg = colors.inactive_bg, fg = colors.semilightgray },
      },
    }

    -- configure lualine with modified theme
    lualine.setup {
      options = {
        theme = my_lualine_theme,
        section_separators = { left = '', right = '' },
        component_separators = { left = ' ', right = ' ' },
        always_divide_middle = false,
        disabled_filetypes = { 'NvimTree', 'alpha' },
      },
      sections = {
        lualine_c = {
          {
            'filename',
            path = 1,
          },
        },
        -- lualine_c = {
        --   {
        --     'buffers',
        --     show_filename_only = false, -- Shows shortened relative path when set to false.
        --     hide_filename_extension = false, -- Hide filename extension when set to true.
        --     show_modified_status = true, -- Shows indicator when the buffer is modified.
        --   },
        -- },
        lualine_x = {
          {
            lazy_status.updates,
            cond = lazy_status.has_updates,
            color = { fg = colors.orange },
          },
          { 'encoding' },
          { 'fileformat', symbols = { unix = '󰀶', dos = '󰨡', mac = '󰀶' } },
          { 'filetype' },
        },
      },
    }
  end,
}
