" Config for cmp plugin
lua << EOF

local cmp = require('cmp')
local lspkind = require('lspkind')
lspkind.init()

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)

    end,

  },
  mapping = {
      ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-e>'] = cmp.mapping.close(),
      ['<C-y>'] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Insert,
          select = true,
      }
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'buffer', keyword_length = 4 },
    { name = 'path' },
    { name = 'tags' },
  },
  formatting = {
      format = lspkind.cmp_format {
          with_text = true,
          menu = {
             buffer = "[buf]",
             nvim_lsp = "[LSP]",
             path = "[path]",
             tags = "[tags]",
             vsnip = "[Snippet]"
          }
      }
  }
})

EOF
