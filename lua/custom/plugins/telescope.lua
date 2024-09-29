return { -- Fuzzy Finder (files, lsp, etc)
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { -- If encountering errors, see telescope-fzf-native README for installation instructions
      'nvim-telescope/telescope-fzf-native.nvim',

      -- `build` is used to run some command when the plugin is installed/updated.
      -- This is only run then, not every time Neovim starts up.
      build = 'make',

      -- `cond` is a condition used to determine whether this plugin should be
      -- installed and loaded.
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },

    -- Useful for getting pretty icons, but requires a Nerd Font.
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    { 'nvim-telescope/telescope-file-browser.nvim' },
  },
  config = function()
    -- Telescope is a fuzzy finder that comes with a lot of different things that
    -- it can fuzzy find! It's more than just a "file finder", it can search
    -- many different aspects of Neovim, your workspace, LSP, and more!
    --
    -- The easiest way to use Telescope, is to start by doing something like:
    --  :Telescope help_tags
    --
    -- After running this command, a window will open up and you're able to
    -- type in the prompt window. You'll see a list of `help_tags` options and
    -- a corresponding preview of the help.
    --
    -- Two important keymaps to use while in Telescope are:
    --  - Insert mode: <c-/>
    --  - Normal mode: ?
    --
    -- This opens a window that shows you all of the keymaps for the current
    -- Telescope picker. This is really useful to discover what Telescope can
    -- do as well as how to actually do it!

    -- [[ Configure Telescope ]]
    -- See `:help telescope` and `:help telescope.setup()`
    require('telescope').setup {
      -- You can put your default mappings / updates / etc. in here
      --  All the info you're looking for is in `:help telescope.setup()`
      --
      defaults = {
        wrap_results = false,
        layout_strategy = 'horizontal',
        dynamic_preview_title = true,
        hl_result_eol = true,
        sorting_strategy = 'ascending',
        results_title = '', -- Remove `Results` title
        layout_config = {
          horizontal = {
            prompt_position = 'top',
            preview_width = 0.55,
            results_width = 0.8,
          },
          vertical = {
            mirror = false,
          },
          width = 0.8,
          height = 0.80,
          preview_cutoff = 120,
        },
        file_ignore_patterns = { 'ICONS/', '.git/', 'ICONS\\', '.git\\', '.*shorthand.json' },
        mappings = {
          i = {
            ['<escape>'] = require('telescope.actions').close,
            ['<C-j>'] = require('telescope.actions').move_selection_next,
            ['<C-k>'] = require('telescope.actions').move_selection_previous,
            ['<C-u>'] = false,
            ['<C-f>'] = require('telescope.actions').preview_scrolling_up,
            ['<C-c>'] = require('telescope.actions').close,
            ['<C-l>'] = require('telescope.actions').delete_buffer,
            ['<C-Down>'] = require('telescope.actions').cycle_history_next,
            ['<C-Up>'] = require('telescope.actions').cycle_history_prev,
          },
          n = {
            ['q'] = require('telescope.actions').close,
          },
        },
      },
      pickers = {
        help_tags = {
          mappings = {
            i = {
              ['<CR>'] = 'file_vsplit',
            },
          },
        },
      },
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
        file_browser = {
          display_stat = false,
          auto_depth = true,
          hijack_netrw = true,
          mappings = {
            ['i'] = {
              ['<C-u>'] = false,
              ['<C-Down>'] = require('telescope.actions').cycle_history_next,
              ['<C-Up>'] = require('telescope.actions').cycle_history_prev,
              ['<C-f>'] = require('telescope.actions').preview_scrolling_up,
            },
          },
        },
      },
    }

    -- Enable Telescope extensions if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')
    pcall(require('telescope').load_extension, 'file_browser')
    pcall(require('telescope').load_extension, 'frecency')

    -- Setup Telescope File Browser
    vim.keymap.set('n', '<leader>ee', ':Telescope file_browser<CR>', { desc = 'Fil[E] Brows[E]r', silent = true })
    vim.keymap.set('n', '<leader>en', ':Nvk<CR>', { desc = '[N]vk-ReaScripts', silent = true })
    vim.keymap.set('n', '<leader>ev', ':Nvim<CR>', { desc = '[N]vim config', silent = true })

    -- See `:help telescope.builtin`
    local builtin = require 'telescope.builtin'
    vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
    vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>sp', builtin.builtin, { desc = '[S]earch Telesco[P]e' })
    vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
    vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
    vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
    vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
    vim.keymap.set('n', '<leader>sa', builtin.buffers, { desc = '[S]earch [A]ctive Buffers' })
    vim.keymap.set('n', '<leader>st', '<cmd>TodoTelescope<CR>', { desc = '[S]earch [T]odo' })
    vim.keymap.set('n', '<leader>gs', builtin.git_status, { desc = '[G]it [S]tatus' })
    vim.keymap.set('n', '<leader>gb', builtin.git_branches, { desc = '[G]it [B]ranches' })
    vim.keymap.set('n', '<leader>gc', builtin.git_commits, { desc = '[G]it [C]ommits' })
    vim.keymap.set('n', '<leader>P', builtin.commands, { desc = 'Command [P]alette' })
    vim.keymap.set('n', '<leader>p', '<cmd>Telescope frecency<CR>', { desc = 'File [P]icker' })

    -- Slightly advanced example of overriding default behavior and theme
    vim.keymap.set('n', '<leader>/', function()
      -- You can pass additional configuration to Telescope to change the theme, layout, etc.
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = '[/] Fuzzily search in current buffer' })

    -- It's also possible to pass additional configuration options.
    --  See `:help telescope.builtin.live_grep()` for information about particular keys
    vim.keymap.set('n', '<leader>s/', function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
    end, { desc = '[S]earch [/] in Open Files' })

    -- Shortcut for searching your Neovim configuration files
    vim.keymap.set('n', '<leader>sc', function()
      builtin.find_files { cwd = vim.fn.stdpath 'config' }
    end, { desc = '[S]earch Nvim [C]onfig' })

    vim.keymap.set('n', '<leader>sn', function()
      builtin.find_files { cwd = vim.g.nvk_path }
    end, { desc = '[S]earch [N]vk-ReaScripts' })
  end,
}
