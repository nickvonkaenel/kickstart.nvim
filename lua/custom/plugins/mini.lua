return { -- Collection of various small independent plugins/modules
  'echasnovski/mini.nvim',
  config = function()
    -- Better Around/Inside textobjects
    --
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
    --  - ci'  - [C]hange [I]nside [']quote
    require('mini.ai').setup {
      custom_textobjects = {
        F = require('mini.ai').gen_spec.treesitter { a = '@function.outer', i = '@function.inner' },
      },
      n_lines = 500,
    }
    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    --
    -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- - sd'   - [S]urround [D]elete [']quotes
    -- - sr)'  - [S]urround [R]eplace [)] [']
    require('mini.surround').setup()

    require('mini.files').setup {
      windows = {
        preview = true,
        width_preview = 105,
      },
      mappings = {
        show_help = '<C-/>',
      },
    }

    local minifiles_toggle = function(...)
      if not MiniFiles.close() then
        MiniFiles.open(...)
      end
    end
    vim.keymap.set('n', '<leader>f', minifiles_toggle, { desc = '[F]iles' })
    vim.api.nvim_set_hl(0, 'MiniFilesCursorLine', { link = 'NONE' }) -- remove cursorline highlight

    -- Open file in split window
    local map_split = function(buf_id, lhs, direction)
      local rhs = function()
        -- Make new window and set it as target
        local cur_target = MiniFiles.get_explorer_state().target_window
        local new_target = vim.api.nvim_win_call(cur_target, function()
          vim.cmd(direction .. ' split')
          return vim.api.nvim_get_current_win()
        end)

        MiniFiles.set_target_window(new_target)
      end

      -- Adding `desc` will result into `show_help` entries
      local desc = 'Split ' .. direction
      vim.keymap.set('n', lhs, rhs, { buffer = buf_id, desc = desc })
    end

    vim.api.nvim_create_autocmd('User', {
      pattern = 'MiniFilesBufferCreate',
      callback = function(args)
        local buf_id = args.data.buf_id
        -- Tweak keys to your liking
        map_split(buf_id, '<C-s>', 'belowright horizontal')
        map_split(buf_id, '<C-v>', 'belowright vertical')
      end,
    })

    -- Set working directory to the file system entry under cursor
    local files_set_cwd = function(path)
      -- Works only if cursor is on the valid file system entry
      local cur_entry_path = MiniFiles.get_fs_entry().path
      local cur_directory = vim.fs.dirname(cur_entry_path)
      vim.fn.chdir(cur_directory)
    end

    vim.api.nvim_create_autocmd('User', {
      pattern = 'MiniFilesBufferCreate',
      callback = function(args)
        vim.keymap.set('n', '<C-t>', files_set_cwd, { buffer = args.data.buf_id, desc = 'Set working directory' })
      end,
    })
    -- Makes the window transparent
    -- vim.api.nvim_create_autocmd('User', {
    --   pattern = 'MiniFilesWindowOpen',
    --   callback = function(args)
    --     local win_id = args.data.win_id
    --
    --     -- Customize window-local settings
    --     vim.wo[win_id].winblend = 20
    --     local config = vim.api.nvim_win_get_config(win_id)
    --     vim.api.nvim_win_set_config(win_id, config)
    --   end,
    -- })
  end,
}
