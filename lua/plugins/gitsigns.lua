return {
  'lewis6991/gitsigns.nvim', -- Add gutter for git diff integration
  opts = {
    on_attach = function(bufnr)
      local gitsigns = require('gitsigns')

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation
      map('n', ']c', function()
        if vim.wo.diff then
          vim.cmd.normal({ ']c', bang = true })
        else
          gitsigns.nav_hunk('next')
        end
      end)

      map('n', '[c', function()
        if vim.wo.diff then
          vim.cmd.normal({ '[c', bang = true })
        else
          gitsigns.nav_hunk('prev')
        end
      end)

      -- Actions
      map('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'Git stage hunk' })
      map('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'Git reset hunk' })
      map('v', '<leader>hs', function()
        gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
      end, { desc = 'Git stage hunk selection' })
      map('v', '<leader>hr', function()
        gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
      end, { desc = 'Git stage reset selection' })
      map('n', '<leader>hS', gitsigns.stage_buffer, { desc = 'Git stage buffer' })
      map('n', '<leader>hu', gitsigns.undo_stage_hunk, { desc = 'Git undo stage hunk' })
      map('n', '<leader>hR', gitsigns.reset_buffer, { desc = 'Git reset buffer' })
      map('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'Git preview hunk' })
      map('n', '<leader>hb', function()
        gitsigns.blame_line({ full = true })
      end, { desc = 'Git blame line' })
      map('n', '<leader>hd', gitsigns.diffthis, { desc = 'Git diff against index' })
      map('n', '<leader>hD', function()
        gitsigns.diffthis('~')
      end, { desc = 'Git diff against last commit' })

      -- Toggle actions
      map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = 'Git toggle current line blame' })
      map('n', '<leader>td', gitsigns.toggle_deleted, { desc = 'Git toggle deleted' })
    end,
  },
}
