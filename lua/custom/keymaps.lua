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

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.api.nvim_set_keymap('n', '<leader>cs', ':Telescope colorscheme<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', { noremap = true, silent = true })

-- Toggle transparency
vim.keymap.set('n', '<leader>wt', function()
  local theme = require 'onedarkpro.config'
  theme.config.options.transparency = not theme.config.options.transparency
  require('onedarkpro').setup(theme.config.options)
  vim.cmd.colorscheme 'onedark_dark'
end, { desc = 'Toggle [T]ransparency' })

-- Move selected lines down
vim.api.nvim_set_keymap('v', 'J', ":m '>+1<CR>gv=gv", { noremap = true, silent = true })

-- Move selected lines up
vim.api.nvim_set_keymap('v', 'K', ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set('i', 'jk', '<ESC>', { noremap = true, silent = true, desc = 'Exit insert mode with jk' })
-- increment/decrement numbers
vim.keymap.set('n', '<leader>+', '<C-a>', { desc = 'Increment number' }) -- increment
vim.keymap.set('n', '<leader>-', '<C-x>', { desc = 'Decrement number' }) -- decrement

-- window management
vim.keymap.set('n', '<leader>wv', '<C-w>v', { desc = 'Split [W]indow [V]ertically' }) -- split window vertically
vim.keymap.set('n', '<leader>wh', '<C-w>s', { desc = 'Split [W]indow [H]orizontally' }) -- split window horizontally
vim.keymap.set('n', '<leader>we', '<C-w>=', { desc = 'Make [W]indow splits [=]equal size' }) -- make split windows equal width & height
vim.keymap.set('n', '<leader>wx', '<cmd>close<CR>', { desc = '[X] Close current split' }) -- close current split window

vim.keymap.set('n', '<leader>to', '<cmd>tabnew<CR>', { desc = '[O]pen new tab' }) -- open new tab
vim.keymap.set('n', '<leader>tx', '<cmd>tabclose<CR>', { desc = '[X] Close current tab' }) -- close current tab
vim.keymap.set('n', '<leader>tn', '<cmd>tabn<CR>', { desc = 'Go to [N]ext tab' }) --  go to next tab
vim.keymap.set('n', '<leader>tp', '<cmd>tabp<CR>', { desc = 'Go to [P]revious tab' }) --  go to previous tab
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
vim.keymap.set('n', '<leader>qQ', '<cmd>q!<CR>', { desc = '[QQ]uit no save' })
vim.keymap.set('n', '<leader>al', '<cmd>Alpha<CR>', { desc = '[A][L]pha' })

-- Source the current file
vim.keymap.set('n', '<leader>so', function()
  vim.cmd 'source %'
  vim.notify('Current file sourced', vim.log.levels.INFO)
end, { desc = '[S][O]urce current file' })

vim.keymap.set('v', '<C-d>', function()
  -- Yank the selected text into register 'h'
  vim.cmd 'normal! "hy'

  -- Get the yanked text and escape special characters
  local pattern = vim.fn.escape(vim.fn.getreg 'h', '/\\')

  -- Build the substitute command
  -- local cmd = ':%s/' .. pattern .. '//gc'
  local cmd = ':.,$s/' .. pattern .. '//gc' -- replace all occurrences until the end of the file with confirmation

  -- Enter the command line with the substitute command
  vim.api.nvim_feedkeys(cmd, 'n', false)

  -- Move the cursor back three positions to before 'gc'
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<left><left><left>', true, false, true), 'n', true)
end, { noremap = true, silent = true })
