return { -- The Gruvbox colorscheme
  'ellisonleao/gruvbox.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    require('gruvbox').setup({
      overrides = {
        SignColumn = { bg = '#1d2021' },
      },
      contrast = 'hard',
    })

    vim.opt.background = 'dark'
    vim.cmd.colorscheme('gruvbox')
  end,
}
