-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
-- Disable the space keys normal behavior in normal and visual mode
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Setup path for nvk-ReaScripts
local is_windows = vim.fn.has 'win32' == 1
vim.g.nvk_path = is_windows and 't:/REAPER/Scripts/nvk-ReaScripts' or '/Applications/REAPER/Scripts/nvk-ReaScripts'

vim.api.nvim_create_user_command('Nvk', function()
  -- Execute Neotree reveal
  -- set cwd to nvk-ReaScripts
  vim.cmd('cd ' .. vim.g.nvk_path)
  vim.cmd('Telescope file_browser path=' .. vim.g.nvk_path)
end, {})

-- Create a command to open nvim config
vim.api.nvim_create_user_command('Nvim', function()
  -- Execute Neotree reveal
  vim.cmd('cd ' .. vim.fn.stdpath 'config')
  vim.cmd('Telescope file_browser path=' .. vim.fn.stdpath 'config')
end, {})

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update

-- Alternatively, if you want to lazy load them
-- require('luasnip.loaders.from_vscode').lazy_load { paths = './snippets/lua/reascript-api-shorthand.code-snippets' }

--
-- NOTE: Here is where you install your plugins.
require('lazy').setup({
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  -- NOTE: Plugins can also be added by using a table,
  -- with the first argument being the link and the following
  -- keys can be used to configure plugin behavior/loading/etc.
  --
  -- Use `opts = {}` to force a plugin to be loaded.
  --

  -- Here is a more advanced example where we pass configuration
  -- options to `gitsigns.nvim`. This is equivalent to the following Lua:
  --    require('gitsigns').setup({ ... })
  --
  -- See `:help gitsigns` to understand what the configuration keys do
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  -- NOTE: Plugins can also be configured to run Lua code when they are loaded.
  --
  -- This is often very useful to both group configuration, as well as handle
  -- lazy loading plugins that don't need to be loaded immediately at startup.
  --
  -- For example, in the following configuration, we use:
  --  event = 'VimEnter'
  --
  -- which loads which-key before all the UI elements are loaded. Events can be
  -- normal autocommands events (`:help autocmd-events`).
  --
  -- Then, because we use the `config` key, the configuration only runs
  -- after the plugin has been loaded:
  --  config = function() ... end

  -- NOTE: Plugins can specify dependencies.
  --
  -- The dependencies are proper plugin specifications as well - anything
  -- you do for a plugin at the top level, you can do for a dependency.
  --
  -- Use the `dependencies` key to specify the dependencies of a particular plugin

  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      },
    },
  },
  { 'Bilal2453/luvit-meta', lazy = true },
  -- The following two comments only work if you have downloaded the kickstart repo, not just copy pasted the
  -- init.lua. If you want these files, they are in the repository, so you can just download them and
  -- place them in the correct locations.

  -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
  --
  --  Here are some example plugins that I've included in the Kickstart repository.
  --  Uncomment any of the lines below to enable them (you will need to restart nvim).
  --
  -- require 'kickstart.plugins.debug',
  require 'kickstart.plugins.indent_line',
  require 'kickstart.plugins.lint',
  require 'kickstart.plugins.autopairs',
  require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    This is the easiest way to modularize your config.
  --
  --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  --    For additional information, see `:help lazy.nvim-lazy.nvim-structuring-your-plugins`
  { import = 'custom.plugins' },
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

vim.filetype.add {
  extension = {
    dat = 'lua',
  },
}

require('plenary.filetype').add_file 'dat'

-- vim.diagnostic.config {
--   virtual_text = true,
--   signs = true,
--   underline = true,
--   update_in_insert = false,
-- }

-- Can uncomment to make comments italic
vim.cmd [[highlight Comment cterm=italic gui=italic]]

-- vim.cmd 'highlight Underlined gui=underline'

-- Set undercurl for different diagnostic types without changing the text color
local groups = { 'DiagnosticUnderlineError', 'DiagnosticUnderlineWarn', 'DiagnosticUnderlineInfo', 'DiagnosticUnderlineHint' }

for _, group in ipairs(groups) do
  -- Get the current highlight group
  local hl = vim.api.nvim_get_hl(0, { name = group })
  -- Apply undercurl and preserve the existing colors
  vim.api.nvim_set_hl(0, group, { undercurl = true, sp = hl.sp or hl.fg })
end

-- Subtle background contrast for QuickFixLine in One Dark Pro theme
vim.api.nvim_set_hl(0, 'QuickFixLine', { bg = '#808080', fg = '#000000', bold = true })
-- vim.api.nvim_set_hl(0, 'qfFileName', { bg = 'NONE', fg = '#61afef' })
vim.api.nvim_set_hl(0, 'qfLineNr', { bg = 'NONE', fg = '#98c379' })

vim.api.nvim_set_hl(0, 'TelescopeSelection', { fg = '#c678dd', bg = '#1e1e1e' }) -- make telescope selections more visible
vim.api.nvim_set_hl(0, 'TelescopePreviewDirectory', {
  bold = true,
  italic = true,
})

-- Make arguments italic
vim.cmd [[
  hi! link @parameter TSParameterItalic
  hi TSParameterItalic gui=italic
]]

require 'custom.options'
require 'custom.keymaps'
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
