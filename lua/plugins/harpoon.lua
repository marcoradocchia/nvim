return { -- ThePrimeagen's harpoon
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
  },
  config = function()
    local harpoon = require('harpoon')

    -- REQUIRED
    harpoon:setup({})
    -- REQUIRED

    -- basic telescope configuration
    local conf = require('telescope.config').values
    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require('telescope.pickers')
        .new({}, {
          prompt_title = 'Harpoon',
          finder = require('telescope.finders').new_table({
            results = file_paths,
          }),
          previewer = conf.file_previewer({}),
          sorter = conf.generic_sorter({}),
        })
        :find()
    end

    vim.keymap.set('n', '<LEADER>ha', function()
      harpoon:list():add()
      vim.notify('Buffer added to the Harpoon list', vim.log.levels.INFO)
    end, { desc = 'Add to Harpoon list' })
    vim.keymap.set('n', '<LEADER>hq', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = 'Toggle Harpoon quickmenu' })

    vim.keymap.set('n', 'à', function()
      harpoon:list():select(1)
    end)
    vim.keymap.set('n', 'è', function()
      harpoon:list():select(2)
    end)
    vim.keymap.set('n', 'ì', function()
      harpoon:list():select(3)
    end)
    vim.keymap.set('n', 'ò', function()
      harpoon:list():select(4)
    end)

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set('n', '<LEADER>hp', function()
      harpoon:list():prev()
    end)
    vim.keymap.set('n', '<LEADER>hn', function()
      harpoon:list():next()
    end)

    -- Toggle Harpoon-Telescope
    vim.keymap.set('n', '<LEADER>ht', function()
      toggle_telescope(harpoon:list())
    end, { desc = 'Open harpoon window' })
  end,
}
