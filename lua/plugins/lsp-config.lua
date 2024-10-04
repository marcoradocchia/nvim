return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',

    { 'williamboman/mason.nvim', config = true },
    { 'j-hui/fidget.nvim', config = true },
  },
  config = function()
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
      callback = function(event)
        local builtin = require('telescope.builtin')

        vim.keymap.set('n', 'gd', builtin.lsp_definitions, { desc = 'Go to definition' })
        vim.keymap.set('n', 'gr', builtin.lsp_references, { desc = 'Go to references' })
        vim.keymap.set('n', 'gi', builtin.lsp_implementations, { desc = 'Go to implementation' })
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'Go to declaration' })

        vim.keymap.set('n', 'gt', builtin.lsp_type_definitions, { desc = 'Type definition' })
        vim.keymap.set('n', '<leader>ds', builtin.lsp_document_symbols, { desc = 'Document symbols' })
        vim.keymap.set('n', '<leader>ws', builtin.lsp_dynamic_workspace_symbols, { desc = 'Workspace symbols' })
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Rename variable' })
        vim.keymap.set({ 'n', 'x' }, '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code action' })

        -- The following code creates a keymap to toggle inlay hints
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
          vim.keymap.set('n', '<leader>th', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
          end, { desc = 'Toggle inlay hints' })
        end
      end,
    })

    -- LSP servers and clients are able to communicate to each other what features they support.
    --  By default, Neovim doesn't support everything that is in the LSP specification.
    --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
    --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
    local default_capabilities = require('cmp_nvim_lsp').default_capabilities()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend('force', capabilities, default_capabilities)

    -- Enable the following language servers
    --
    -- Add any additional override configuration in the following tables. Available keys are:
    --   - cmd (table): Override the default command used to start the server
    --   - filetypes (table): Override the default list of associated filetypes for the server
    --   - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
    --   - settings (table): Override the default settings passed when initializing the server.
    local servers = {
      -- clangd = {},
      -- gopls = {},
      -- pyright = {},
      -- rust_analyzer = {},
      -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
      --
      -- Some languages (like typescript) have entire language plugins that can be useful:
      --    https://github.com/pmizio/typescript-tools.nvim
      --
      -- But for many setups, the LSP (`tsserver`) will work just fine
      -- tsserver = {},

      lua_ls = {
        settings = {
          Lua = {
            diagnostics = {
              disable = { 'missing-parameters', 'missing-fields' },
            },
            completion = {
              callSnippet = 'Replace',
            },
            -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
            -- diagnostics = { disable = { 'missing-fields' } },
          },
        },
      },
    }

    require('mason').setup()

    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
      'stylua', -- Used to format Lua code
    })
    require('mason-tool-installer').setup({
      ensure_installed = ensure_installed,
    })

    require('mason-lspconfig').setup({
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
          require('lspconfig')[server_name].setup(server)
        end,
      },
    })
  end,
}
