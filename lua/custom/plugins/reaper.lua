local is_windows = vim.fn.has 'win32' == 1
local reaper_path = is_windows and 't:/REAPER/reaper.exe' or '/Applications/REAPER/REAPER.app/Contents/MacOS/REAPER'

vim.api.nvim_create_user_command('Reaper', function()
  vim.cmd('!open -a ' .. reaper_path)
end, {})

vim.api.nvim_create_user_command('Reascript', function(opts)
  local escaped_arg = vim.fn.shellescape(opts.args)
  vim.cmd('!' .. reaper_path .. ' ' .. escaped_arg)
end, { nargs = 1 })

vim.api.nvim_create_user_command('RunActiveReascript', function(opts)
  local open_reaper = opts.args == 'open'
  local ext = vim.fn.expand '%:e'
  local filepath = vim.fn.expand '%:p'
  if not filepath:find 'REAPER' then
    vim.notify('Reascript command only supports ReaScript files', vim.log.levels.ERROR)
    return
  end
  if ext == 'dat' then
    -- Find '/scripts/' in the filepath
    local scripts_index = filepath:find '/scripts/'
    if not scripts_index then
      vim.notify('/scripts/ not found in the filepath', vim.log.levels.ERROR)
      return
    end

    -- Get the folder name after '/scripts/'
    local after_scripts = filepath:sub(scripts_index + #'/scripts/')
    local folder_name = after_scripts:match '([^/]+)'
    if not folder_name then
      vim.notify('Could not find folder name after /scripts/', vim.log.levels.ERROR)
      return
    end

    -- Replace underscores with spaces
    local search_name = folder_name:gsub('_', ' ')

    -- Find 'nvk-ReaScripts/' in the filepath
    local nvk_index = filepath:find 'nvk%-ReaScripts/'
    if not nvk_index then
      vim.notify('nvk-ReaScripts/ not found in the filepath', vim.log.levels.ERROR)
      return
    end

    -- Get the path up to 'nvk-ReaScripts/'
    local nvk_path = filepath:sub(1, nvk_index + #'nvk-ReaScripts/' - 1)

    -- Get the first folder after 'nvk-ReaScripts/'
    local after_nvk = filepath:sub(nvk_index + #'nvk-ReaScripts/')
    local target_dir = after_nvk:match '([^/]+)'
    if not target_dir then
      vim.notify('Could not find folder after nvk-ReaScripts/', vim.log.levels.ERROR)
      return
    end

    -- Construct the search directory
    local search_dir = nvk_path .. target_dir

    -- Search for .lua files in 'search_dir' (recursively) that contain 'search_name' (case-insensitive)
    local lua_files = vim.fn.globpath(search_dir, '**/*.lua', true, true)

    local shortest_name_length = nil
    local chosen_file = nil

    for _, file in ipairs(lua_files) do
      local filename = vim.fn.fnamemodify(file, ':t')
      if filename:lower():find(search_name:lower()) then
        local name_length = #filename
        if not shortest_name_length or name_length < shortest_name_length then
          shortest_name_length = name_length
          chosen_file = file
        end
      end
    end

    if not chosen_file then
      vim.notify('No matching .lua files found in ' .. search_dir, vim.log.levels.ERROR)
      return
    end

    -- Set 'filepath' to the chosen file
    filepath = chosen_file
  elseif ext ~= 'lua' then
    vim.notify('Reascript command only supports .lua and .dat files', vim.log.levels.ERROR)
    return
  end

  vim.cmd 'write' -- Save the current file
  local cleanup_script = vim.fn.stdpath 'config' .. '/reaper/cleanup.lua'
  -- local escaped_filepath = vim.fn.fnameescape(filepath)
  -- vim.notify(escaped_filepath)
  vim.cmd('Reascript ' .. cleanup_script)
  vim.cmd('Reascript ' .. filepath)
  if open_reaper then
    vim.cmd 'Reaper'
  end
end, { nargs = '?' })

vim.keymap.set('n', '<leader>rr', function()
  vim.cmd 'RunActiveReascript'
end, { desc = '[R]un [R]eascript' })

vim.keymap.set('n', '<leader>ro', function()
  vim.cmd { cmd = 'RunActiveReascript', args = { 'open' } }
end, { desc = '[R]un Reascript [O]pen Reaper' })

return {}
