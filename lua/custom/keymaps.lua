-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
-- adding this to multicursor since it also uses <Esc> to collapse the cursors
-- vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>qf', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uick[F]ix list' })

-- Go to next/previous reference
vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references, { desc = '[G]oto [R]eferences' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
-- See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.api.nvim_set_keymap('n', '<leader>cs', ':Telescope colorscheme<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>k', '<cmd>lua vim.diagnostic.open_float()<CR>', { noremap = true, silent = true, desc = 'Show diagnostic message' })

-- Toggle transparency
vim.keymap.set('n', '<leader>tt', function()
  local theme = require 'onedarkpro.config'
  theme.config.options.transparency = not theme.config.options.transparency
  require('onedarkpro').setup(theme.config.options)
  vim.cmd.colorscheme 'onedark'
end, { desc = '[T]oggle [T]ransparency' })

-- Move selected lines down
vim.api.nvim_set_keymap('v', 'J', ":m '>+1<CR>gv=gv", { noremap = true, silent = true })

-- Move selected lines up
vim.api.nvim_set_keymap('v', 'K', ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set('i', 'jk', '<ESC>', { noremap = true, silent = true, desc = 'Exit insert mode with jk' })

-- window management
vim.keymap.set('n', '<leader>wv', '<C-w>v', { desc = 'Split Window Vertically' }) -- split window vertically
vim.keymap.set('n', '<leader>wh', '<C-w>s', { desc = 'Split Window Horizontally' }) -- split window horizontally
vim.keymap.set('n', '<leader>we', '<C-w>=', { desc = 'Make [W]indow splits [E]qual size' }) -- make split windows equal width & height
vim.keymap.set('n', '<leader>x', '<cmd>close<CR>', { desc = '[X] Close' }) -- close current split window

vim.keymap.set('n', '<leader>tn', '<cmd>tabnew<CR>', { desc = 'New tab' }) -- open new tab
vim.keymap.set('n', '<leader>tx', '<cmd>tabclose<CR>', { desc = '[X] Close current tab' }) -- close current tab
vim.keymap.set('n', '<leader>tl', '<cmd>tabn<CR>', { desc = 'Next tab' }) --  go to next tab
vim.keymap.set('n', '<leader>th', '<cmd>tabp<CR>', { desc = 'Previous tab' }) --  go to previous tab
vim.keymap.set('n', '<leader>tf', '<cmd>tabnew %<CR>', { desc = 'Open current bu[F]fer in new tab' }) --  move current buffer to new tab
vim.keymap.set('n', '<leader>1', '1gt') --  go to first tab
vim.keymap.set('n', '<leader>2', '2gt') --  go to second tab
vim.keymap.set('n', '<leader>3', '3gt') --  go to third tab
vim.keymap.set('n', '<leader>4', '4gt') --  go to fourth tab
vim.keymap.set('n', '<leader>5', '5gt') --  go to fifth tab
vim.keymap.set('n', '<leader>6', '6gt') --  go to sixth tab
vim.keymap.set('n', '<leader>7', '7gt') --  go to seventh tab
vim.keymap.set('n', '<leader>8', '8gt') --  go to eighth tab
vim.keymap.set('n', '<leader>9', '9gt') --  go to ninth tab

vim.keymap.set('n', '<leader>ww', '<cmd>write<CR>', { desc = '[W]rite [W]ork File' }) -- write current file
vim.keymap.set('n', '<leader>wa', '<cmd>wa<CR>', { desc = '[W]rite [A]ll' }) -- write all files
vim.keymap.set('n', '<leader>wq', '<cmd>wq<CR>', { desc = '[W]rite [Q]uit' }) -- write and quit
vim.keymap.set('n', '<leader>qq', '<cmd>q<CR>', { desc = '[Qq]uit' })

local hop = require 'hop'
local directions = require('hop.hint').HintDirection
vim.keymap.set('', 'f', function()
  hop.hint_words { direction = directions.AFTER_CURSOR + directions.AFTER_CURSOR, current_line_only = false }
end, { remap = true })
vim.keymap.set('', 'F', function()
  hop.hint_lines { direction = directions.BEFORE_CURSOR + directions.AFTER_CURSOR, current_line_only = false }
end, { remap = true })

vim.keymap.set('n', '<leader>qa', '<cmd>qa<CR>', { desc = '[Q]uit [A]ll' })
vim.keymap.set('n', '<leader>qn', '<cmd>q!<CR>', { desc = '[Q]uit [N]o Save' })
vim.keymap.set('n', '<leader>al', '<cmd>Alpha<CR>', { desc = '[A][L]pha' })

-- Source the current file
vim.keymap.set('n', '<leader>so', function()
  vim.cmd 'w'
  vim.cmd 'source %'
  vim.notify('Current file sourced', vim.log.levels.INFO)
end, { desc = '[S][O]urce current file' })

local function search_replace_selected(sub_command, flags)
  -- Yank the selected text into register 'h'
  vim.cmd 'normal! "hy'

  -- Get the yanked text and escape special characters
  local pattern = vim.fn.escape(vim.fn.getreg 'h', '/\\')

  -- Build the substitute command
  local cmd = ':' .. sub_command .. '/' .. pattern .. '//' .. flags

  -- Enter the command line with the substitute command
  vim.api.nvim_feedkeys(cmd, 'n', false)

  -- Move the cursor back three positions to before 'gc'
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<left><left><left>', true, false, true), 'n', true)
end

-- Replace remaining text in document with confirmation
vim.keymap.set('v', '<C-d>', function()
  search_replace_selected('.,$s', 'gc')
end, { noremap = true, silent = true })

-- Replace entire document with confirmation
vim.keymap.set('v', '<C-f>', function()
  search_replace_selected('%s', 'gc')
end, { noremap = true, silent = true })

vim.keymap.set('n', '<A-j>', '<cmd>cnext<CR>')
vim.keymap.set('n', '<A-k>', '<cmd>cprev<CR>')
vim.keymap.set('n', '<A-o>', '<cmd>copen<CR>')

vim.api.nvim_set_keymap('n', '<leader>to', '<cmd>terminal<CR>', { noremap = true, silent = true, desc = '[T]erminal [O]pen' })
vim.api.nvim_set_keymap('n', '<leader>tv', '<cmd>vsplit | terminal<CR>', { noremap = true, silent = true, desc = '[T]erminal [V]ertical split' })
vim.api.nvim_set_keymap('n', '<leader>th', '<cmd>split | terminal<CR>', { noremap = true, silent = true, desc = '[T]erminal [H]orizontal split' })

-- tried having esc mapped to close mini.files but realized that it breaks multiple cursors which could be useful for file renaming

-- vim.keymap.set('n', '<Esc>', function()
--   require('mini.files').close()
-- end, { desc = '[Esc] Close or Escape' })

-- Improve the movement keys with word wrap. Goes to next visible line unless count is set i.e. 3j
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

local opts = { noremap = true, silent = true }

-- Center screen when scrolling with C-d and C-u
vim.keymap.set('n', '<C-d>', '<C-d>zz', opts)
vim.keymap.set('n', '<C-u>', '<C-u>zz', opts)

-- Center screen when scrolling with C-f and C-b
vim.keymap.set('n', '<C-f>', '<C-f>zz', opts)
vim.keymap.set('n', '<C-b>', '<C-b>zz', opts)

-- Center screen when going to next/previous match with n and N
vim.keymap.set('n', 'n', 'nzzzv', opts)
vim.keymap.set('n', 'N', 'Nzzzv', opts)

-- Save without formatting
vim.keymap.set('n', '<leader>wn', '<cmd>noautocmd w<CR>', opts)

-- Map Tab to :bnext (next buffer) in normal mode
vim.api.nvim_set_keymap('n', '<Tab>', ':bnext<CR>', { noremap = true, silent = true })
-- Map Shift+Tab to :bprev (previous buffer) in normal mode
vim.api.nvim_set_keymap('n', '<S-Tab>', ':bprev<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>td', [[o-- TODO: ]], { noremap = true, silent = true })

vim.keymap.set('n', '<leader>z', '<cmd>NoNeckPain<CR>', { desc = '[Z]en Mode' })

local augend = require 'dial.augend'
require('dial.config').augends:on_filetype {
  typescript = {
    augend.integer.alias.decimal,
    augend.integer.alias.hex,
    augend.constant.new { elements = { 'true', 'false' } },
    augend.constant.new { elements = { 'let', 'const' } },
  },
  lua = {
    augend.integer.alias.decimal,
    -- augend.paren.alias.brackets,
    augend.constant.new { elements = { 'true', 'false' } },
    augend.constant.new { elements = { 'or', 'and', 'not' } },
  },
  markdown = {
    augend.integer.alias.decimal,
    augend.misc.alias.markdown_header,
    augend.constant.new { elements = { '- [ ]', '- [x]' }, word = false }, -- This pattern will match a checkbox at the start of the line},
  },
}
vim.keymap.set('n', '<C-a>', function()
  require('dial.map').manipulate('increment', 'normal')
end)
vim.keymap.set('n', '<C-x>', function()
  require('dial.map').manipulate('decrement', 'normal')
end)
vim.keymap.set('n', 'g<C-a>', function()
  require('dial.map').manipulate('increment', 'gnormal')
end)
vim.keymap.set('n', 'g<C-x>', function()
  require('dial.map').manipulate('decrement', 'gnormal')
end)
vim.keymap.set('v', '<C-a>', function()
  require('dial.map').manipulate('increment', 'visual')
end)
vim.keymap.set('v', '<C-x>', function()
  require('dial.map').manipulate('decrement', 'visual')
end)
vim.keymap.set('v', 'g<C-a>', function()
  require('dial.map').manipulate('increment', 'gvisual')
end)
vim.keymap.set('v', 'g<C-x>', function()
  require('dial.map').manipulate('decrement', 'gvisual')
end)

-- only yank lines if they aren't empty
vim.keymap.set('n', 'dd', function()
  if vim.fn.getline '.' == '' then
    return '"_dd'
  end
  return 'dd'
end, { expr = true })
