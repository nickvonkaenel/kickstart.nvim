if not vim.g.neovide then
  return
end

-- vim.g.neovide_transparency = 0.8
-- vim.g.neovide_window_blurred = true
vim.g.neovide_fullscreen = false

vim.g.neovide_input_macos_option_key_is_meta = 'only_left'

vim.g.neovide_cursor_animation_length = 0.03

vim.g.neovide_cursor_trail_size = 0.4

vim.g.neovide_scroll_animation_length = 0.2

vim.g.neovide_hide_mouse_when_typing = true

vim.g.neovide_underline_stroke_scale = 2.0

vim.keymap.set('n', '<D-s>', ':w<CR>') -- Save
vim.keymap.set('v', '<D-c>', '"+y') -- Copy
vim.keymap.set('n', '<D-v>', '"+P') -- Paste normal mode
vim.keymap.set('v', '<D-v>', '"+P') -- Paste visual mode
vim.keymap.set('c', '<D-v>', '<C-R>+') -- Paste command mode
vim.keymap.set('i', '<D-v>', '<ESC>l"+Pli') -- Paste insert mode

-- Allow clipboard copy paste in neovim
vim.api.nvim_set_keymap('', '<D-v>', '+p<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('!', '<D-v>', '<C-R>+', { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<D-v>', '<C-R>+', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<D-v>', '<C-R>+', { noremap = true, silent = true })

vim.g.neovide_scale_factor = 1.0
local change_scale_factor = function(delta)
  vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
end
vim.keymap.set('n', '<C-=>', function()
  change_scale_factor(1.25)
end)
vim.keymap.set('n', '<C-->', function()
  change_scale_factor(1 / 1.25)
end)
