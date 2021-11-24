" Config for cmp plugin
lua << EOF

local cmp = require('cmp')

cmp.setup({
  sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer', keyword_length = 4 },
    { name = 'path' },
    { name = 'tags' },
  },
})

EOF
