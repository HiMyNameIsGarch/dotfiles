-- Easy things
require("sets")
require("mappings")

require("plugins")
vim.keymap.set('n', '<leader>M', ':MaximizerToggle!<CR>', { noremap = true })

-- Colors
require('modules.colors')
vim.cmd('hi Normal guibg=NONE ctermbg=NONE')
vim.cmd('hi Winseparator guibg=None')

-- Modules
require("modules.lsp")
require('nvim-autopairs').setup{}
require("modules.comment")
require("modules.completion")
require("modules.telescope")
require("modules.lualine")
require('neoscroll').setup()
require('modules.sshfs')
require('modules.matlab')
require('modules.nvim_socket_listener')


require'nvim-treesitter.configs'.setup {
    indent = {
        enable = true
    },
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
require("modules.typescript")
require("modules.python")
-- Our lord thePrimeagen created this tool for us
require("modules.harpoon")
-- sql please ig
require("modules.sqlpls")

-- Define the NotifyBackground highlight group
vim.cmd([[highlight NotifyBackground guibg=#000000]])
-- Setup nvim-notify
require("notify").setup({
  background_colour = "#000000",
})

-- Formatting
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*.ts", "*.js", "*.vue", "*.tsx" },
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

vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "*.tex",
    command = "silent !latex_prev ./%"
})

local nnoremap = require("keymap").nnoremap

nnoremap('<leader>st', function ()
    local fname = vim.fn.expand('%:p')

    vim.cmd('vsplit')
    local win = vim.api.nvim_get_current_win()
    local buf = vim.api.nvim_create_buf(true, true)
    vim.api.nvim_buf_set_name(buf, "practice_pg")
    vim.api.nvim_win_set_buf(win, buf)

    vim.fn.jobstart({"grep", "-oP", "^\\d.*", fname}, {
        stdout_buffered = true,
        on_stdout = function (_, data)
            if data then
                vim.api.nvim_buf_set_lines(buf, 0, 0, false, data)
            end
        end,
    })
end)
require('remote-sshfs').setup({})
require('telescope').load_extension 'remote-sshfs'
