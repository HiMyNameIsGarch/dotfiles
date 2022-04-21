-- Easy things
require("sets")
require("mappings")

require("plugins")
vim.keymap.set('n', '<leader>M', ':MaximizerToggle!<CR>', { noremap = true })

-- Colors
vim.cmd('colorscheme gruvbox')
vim.cmd('hi Normal guibg=NONE ctermbg=NONE')
vim.cmd('hi Winseparator guibg=None')

require("functions")

-- Modules
require("modules.lsp")
require('nvim-autopairs').setup{}
require("modules.comment")
require("modules.completion")
require("modules.telescope")
require("modules.lightline")
require'nvim-treesitter.configs'.setup {
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = true
    }
}

-- Fugitive
vim.keymap.set('n', '<leader>gs', ':Git<CR>')
vim.keymap.set('n', '<leader>gc', ':Git commit<CR>')
vim.keymap.set('n', '<leader>gf', ':diffget //3')
vim.keymap.set('n', '<leader>gj', ':diffget //2')

require("modules.dotnet")
require("modules.snippets")
