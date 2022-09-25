-- Easy things
require("sets")
require("mappings")

require("plugins")
vim.keymap.set('n', '<leader>M', ':MaximizerToggle!<CR>', { noremap = true })

-- Colors
vim.cmd('colorscheme gruvbox')
vim.cmd('hi Normal guibg=NONE ctermbg=NONE')
vim.cmd('hi Winseparator guibg=None')

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
require("modules.debugger")
require("modules.cplusplus")

-- dadbod for databases
vim.g.db_ui_save_location = "~/.local/share/db_queries"
vim.keymap.set('n', '<leader>db', ":DBUIToggle<CR>",            { silent = true, noremap = true })
vim.keymap.set('n', '<leader>dl', ":DBUIHideNotifications<CR>", { silent = true, noremap = true })
vim.keymap.set('n', '<leader>di', ":DBUILastQueryInfo<CR>",     { noremap = true })

-- Formatting
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*.ts", "*.js", "*.vue" },
    command = "Neoformat"
})
vim.g.neoformat_try_node_exe = 1

vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
    pattern = { "*.ejs" },
    command = "set filetype=html"
})

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    command = ':%s/\\s\\+$//e'
})
