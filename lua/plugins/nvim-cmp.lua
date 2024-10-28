return { -- Autocompletion
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    { -- Snippet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      build = (function()
        -- Build Step is needed for regex support in snippets.
        -- This step is not supported in many windows environments.
        -- Remove the below condition to re-enable on windows.
        if vim.fn.has('win32') == 1 or vim.fn.executable('make') == 0 then
          return
        end
        return 'make install_jsregexp'
      end)(),
      dependencies = {
        'rafamadriz/friendly-snippets',
        config = function()
          require('luasnip.loaders.from_vscode').lazy_load()
        end,
      },
    },
    'saadparwaiz1/cmp_luasnip',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'onsails/lspkind.nvim',
  },
  config = function()
    local cmp = require('cmp')
    local luasnip = require('luasnip')
    local lspkind = require('lspkind')

    luasnip.config.setup({})

    cmp.setup({
      formatting = {
        expandable_indicator = true,
        fields = { 'abbr', 'kind', 'menu' },
        format = lspkind.cmp_format({
          mode = 'symbol_text',
          maxwidth = 50,
          menu = {
            nvim_lsp = '[LSP]',
            luasnip = '[LuaSnip]',
            nvim_lua = '[Lua]',
            latex_symbols = '[Latex]',
          },
          symbol_map = {
            Text = '',
            Method = '󰆧',
            Function = '󰊕',
            Constructor = '',
            Field = '󰇽',
            Variable = '󰂡',
            Class = '󰠱',
            Interface = '',
            Module = '',
            Property = '󰜢',
            Unit = '',
            Value = '󰎠',
            Enum = '',
            Keyword = '󰌋',
            Snippet = '',
            Color = '󰏘',
            File = '󰈙',
            Reference = '',
            Folder = '󰉋',
            EnumMember = '',
            Constant = '󰏿',
            Struct = '',
            Event = '',
            Operator = '󰆕',
            TypeParameter = '󰅲',
          },
        }),
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      completion = {
        completeopt = 'menu,menuone,noinsert',
      },
      -- Please read `:help ins-completion`!
      mapping = cmp.mapping.preset.insert({
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-b>'] = cmp.mapping.scroll_docs(-1),
        ['<C-f>'] = cmp.mapping.scroll_docs(1),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<C-Space>'] = cmp.mapping.complete({}),
        ['<C-l>'] = cmp.mapping(function()
          if luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          end
        end, { 'i', 's' }),
        ['<C-h>'] = cmp.mapping(function()
          if luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          end
        end, { 'i', 's' }),
      }),
      sources = {
        { name = 'lazydev', group_index = 0 },
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'path' },
      },
    })
    -- -- Setup commandline completion
    -- cmp.setup.cmdline('/', {
    --   mapping = cmp.mapping.preset.cmdline(),
    --   sources = {
    --     { name = 'cmdline' },
    --     { name = 'buffer' },
    --   },
    -- })
    -- cmp.setup.cmdline(':', {
    --   mapping = cmp.mapping.preset.cmdline(),
    --   sources = {
    --     { name = 'path' },
    --     { name = 'cmdline', option = { ignore_cmds = { 'Man', '!' } } },
    --   },
    -- })
  end,
}
