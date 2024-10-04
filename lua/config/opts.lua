vim.opt.autoindent = true
vim.opt.breakindent = true
vim.opt.cursorline = false
vim.opt.expandtab = true
vim.opt.ignorecase = true
vim.opt.inccommand = 'split'
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.mouse = 'a'
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 10
vim.opt.shiftwidth = 4
vim.opt.showmode = false
vim.opt.signcolumn = 'yes'
vim.opt.smartcase = true
vim.opt.softtabstop = 4
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.tabstop = 4
vim.opt.timeoutlen = 300
vim.opt.undofile = true
vim.opt.updatetime = 250
vim.opt.termguicolors = true
vim.opt.conceallevel = 2
vim.opt.smoothscroll = true
vim.opt.guicursor = {
  'n-v-c:block-blinkon500',
  'i-ci-ve:ver25-blinkon500',
  'r-cr:hor20-blinkon500',
  'o:hor50-blinkon500',
}

-- Schedule clipboard sync between OS and Neovim.
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)
