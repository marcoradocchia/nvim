return {
  'folke/trouble.nvim',
  cmd = 'Trouble',
  config = true,
  keys = {
    {
      '<LEADER>td',
      ':Trouble diagnostics toggle<CR>',
      desc = 'Trouble toggle diagnostics',
    },
    {
      '<LEADER>ts',
      ':Trouble symbols toggle focus=false<CR>',
      desc = 'Trouble toggle symbols',
    },
    {
      '<LEADER>tl',
      ':Trouble loclist toggle<CR>',
      desc = 'Trouble toggle location list',
    },
  },
}
