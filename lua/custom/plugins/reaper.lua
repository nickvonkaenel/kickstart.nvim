local is_windows = vim.fn.has 'win32' == 1
local reaper_path = is_windows and 't:/REAPER/reaper.exe' or '/Applications/REAPER/REAPER.app/Contents/MacOS/REAPER'

vim.api.nvim_create_user_command('Reaper', function()
  vim.cmd('!open -a ' .. reaper_path)
end, {})

vim.api.nvim_create_user_command('Reascript', function(opts)
  local escaped_arg = vim.fn.shellescape(opts.args)
  vim.cmd('!' .. reaper_path .. ' ' .. escaped_arg)
end, { nargs = 1 })

vim.keymap.set('n', '<leader>r', function()
  local ext = vim.fn.expand '%:e'
  local filepath = vim.fn.expand '%:p'
  if not filepath:find 'nvk%-ReaScripts' then
    vim.notify('Reascript command only supports nvk-ReaScripts files', vim.log.levels.ERROR)
    return
  end
  if ext == 'dat' then
  elseif ext ~= 'lua' then
    vim.notify('Reascript command only supports .lua and .dat files', vim.log.levels.ERROR)
    return
  end

  vim.cmd 'write' -- Save the current file
  local cleanup_script = vim.fn.stdpath 'config' .. '/reaper/cleanup.lua'
  local escaped_filepath = vim.fn.fnameescape(filepath)
  vim.cmd('Reascript ' .. cleanup_script)
  vim.cmd('Reascript ' .. escaped_filepath)
  vim.cmd 'Reaper'
end, { desc = '[R]un [R]eascript' })

return {}
