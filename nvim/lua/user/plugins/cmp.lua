-- Set up nvim-cmp.
local cmp = require 'cmp'
local luasnip = require 'luasnip'
local lspkind = require 'lspkind'

require('luasnip/loaders/from_snipmate').lazy_load()

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  formatting = {
    format = lspkind.cmp_format(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'nvim_lsp_signature_help' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' },
  })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
  }, {
    { name = 'buffer' },
  })
})

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
local lspconfig = require('lspconfig')

require('lspconfig').intelephense.setup({
  capabilities = capabilities,
  settings = {
    intelephense = {
       environment = {
        includePaths = {
          "/Users/briankopp/src/bb/app.bombbomb.com/include",
          "/Users/briankopp/src/bb/app.bombbomb.com/www",
          "/Users/briankopp/src/bb/app.bombbomb.com/api",
          "/Users/briankopp/src/bb/app.bombbomb.com/www/app/include/Classes",
        }
      }
    }
  }
})

lspconfig.tsserver.setup {
  filetypes = { "typescript", "typescriptreact", "typescript.tsx", "javascript", "javascriptreact", "javascript.jsx"},
  cmd = { "typescript-language-server", "--stdio" },
}

lspconfig.html.setup({
  capabilities = capabilities,
  filetypes = { "html", "handlebars" },
})

lspconfig.tailwindcss.setup({
  capabilities = capabilities,
})

lspconfig.rust_analyzer.setup({
})

lspconfig.terraformls.setup{}

lspconfig.gopls.setup{}

lspconfig.pyright.setup{}

lspconfig.jdtls.setup{}
