-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Fix for shell on Windows. Source: https://vi.stackexchange.com/questions/22869/how-can-neovim-on-windows-be-configured-to-use-gitbash-as-the-shell-without-brea
-- Lazygit was not working without this fix
if vim.fn.has 'win32' == 1 then
  vim.o.shell = 'bash.exe'
  vim.o.shellcmdflag = '-c'
  vim.o.shellredir = '>%s 2>&1'
  vim.o.shellquote = ''
  vim.o.shellxescape = ''
  -- vim.o.shelltemp = false  -- Uncomment if needed
  vim.o.shellxquote = ''
  vim.o.shellpipe = '2>&1| tee'
  vim.env.TMP = '/tmp' -- Sets the TMP environment variable
end

-- Allow for cursor to go into empty space in visual block mode
vim.opt.virtualedit = 'block'
-- Enable true colors
vim.opt.termguicolors = true
-- Make line numbers default
vim.opt.number = true
vim.opt.relativenumber = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
-- vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Set tab width to 4 spaces
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Optional: Make backspace key work as expected
vim.opt.softtabstop = 4
vim.opt.smarttab = true

-- Make sure cursorline is off
vim.o.cursorline = false

vim.opt.fillchars = { eob = ' ' }

-- vim.o.autoindent = true -- copy indent from current line when starting a new line

--[[
c       Auto-wrap comments using textwidth,
        inserting the current comment
        leader automatically.

r       Automatically insert the current comment leader after hitting
        <Enter> in Insert mode.

o       Automatically insert the current comment leader after hitting
        'o' or 'O' in Normal mode.  In case comment is unwanted
        in a specific place use CTRL-U to quickly delete
        it. i_CTRL-U
]]
vim.api.nvim_create_autocmd('FileType', {
  pattern = '*',
  callback = function()
    vim.opt_local.formatoptions:remove { 'r', 'o' }
  end,
})

-- Set filetype to `bigfile` for files larger than 1.5 MB
-- Only vim syntax will be enabled (with the correct filetype)
-- LSP, treesitter and other ft plugins will be disabled.
-- mini.animate will also be disabled.
vim.g.bigfile_size = 1024 * 1024 * 1.5 -- 1.5 MB

vim.o.guifont = 'MesloLGM Nerd Font:h14' -- for gui like Neovide and Nvy
