return { -- Buffer filemanager
  'stevearc/oil.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('oil').setup({
      default_file_explorer = true,
      columns = {
        'icon',
        'permissions',
        'size',
        'mtime',
      },
      watch_for_changes = true,
      view_options = {
        show_hidden = true,
      },
    })

    vim.keymap.set('n', '<LEADER>o', ':Oil<CR>', { desc = 'Open the Oil file manager' })
  end,
}
