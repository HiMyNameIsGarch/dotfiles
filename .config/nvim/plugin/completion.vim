" Config for cmp plugin
lua << EOF

local cmp = require('cmp')

cmp.setup({
  sources = {
    { name = 'buffer' },
    { name = 'nvim_lsp' },
    { name = 'treesitter' },
    { name = 'tags' },
  },
})

EOF
