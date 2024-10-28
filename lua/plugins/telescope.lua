return { -- Fuzzy finder (files, lsp, etc.)j
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope-ui-select.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable('make') == 1
      end,
    },
    {
      'nvim-tree/nvim-web-devicons',
      enabled = vim.g.have_nerd_font,
    },
  },
  config = function()
    require('telescope').setup({
      defaults = {
        scroll_strategy = 'limit',
        prompt_prefix = '❯ ',
        selection_caret = ' ',
        path_display = { 'truncate' },
        mappings = {
          i = {
            ['<C-j>'] = require('telescope.actions').cycle_history_next,
            ['<C-k>'] = require('telescope.actions').cycle_history_prev,
          },
        },
      },
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
    })

    -- Enable Telescope extensions (if they are installed)
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')

    -- Telesocpe keymaps
    local builtin = require('telescope.builtin')

    vim.keymap.set('n', '<LEADER>sh', builtin.help_tags, { desc = 'Search help tags' })
    vim.keymap.set('n', '<LEADER>sf', builtin.find_files, { desc = 'Search local files' })
    vim.keymap.set('n', '<LEADER>sb', builtin.buffers, { desc = 'Search open buffers' })
    vim.keymap.set('n', '<LEADER>sd', builtin.diagnostics, { desc = 'Search diagnostics' })
    vim.keymap.set('n', '<LEADER>sg', builtin.live_grep, { desc = 'Search by Grep' })
    vim.keymap.set('n', '<LEADER>sr', builtin.resume, { desc = 'Search resume' })
    vim.keymap.set('n', '<LEADER>ss', builtin.builtin, { desc = 'Search Telescope builtin' })
    vim.keymap.set('n', '<LEADER>s.', builtin.oldfiles, { desc = 'Search recent files' })
    vim.keymap.set('n', '<LEADER>sk', builtin.keymaps, { desc = 'Search keymaps' })

    vim.keymap.set('n', '<LEADER>/', function()
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown())
    end, { desc = 'Fuzzly search in the current buffer' })

    vim.keymap.set('n', '<LEADER>s/', function()
      builtin.live_grep({
        grep_open_files = true,
        prompt_title = 'Live Grep in open buffers',
      })
    end, { desc = 'Search by Grep in open buffers' })

    vim.keymap.set('n', '<LEADER>sn', function()
      builtin.find_files({
        cwd = vim.fn.stdpath('config'),
      })
    end, { desc = 'Search Neovim files' })
  end,
}
