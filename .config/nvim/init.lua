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

local fo = require("file_operation")

local path_to_buf = "/tmp/sqlisfun"

local function funsql(buf)
    local current_sql_file = vim.fn.expand('%:p')

    vim.api.nvim_buf_set_lines(buf, 0, -1, false, {})

    vim.fn.jobstart({ "sqlcmd", "-S", "localhost", "-U", "sa", "-P", "Muielarga69!", "-d", "passman", "-h-1", "-W", "-i", current_sql_file, "-C" }, {
        stdout_buffered = true,
        stderr_buffered = true,
        on_stderr = function (_, data)
            fo.WriteToBuf(path_to_buf, buf, data)
        end,
        on_stdout = function (_, data)
            fo.WriteToBuf(path_to_buf, buf, data)
        end
        })
end

vim.api.nvim_create_autocmd("BufWritePost", {
    group = vim.api.nvim_create_augroup("mssql_dummy", {clear = true}),
    pattern = "*.sql",
    callback = function ()
        local fbuf = fo.Read_buf_from_file(path_to_buf)

        if fbuf and vim.fn.bufexists(fbuf) == 1 then
            funsql(fbuf)
        else
            vim.cmd('vsplit')
            local win = vim.api.nvim_get_current_win()
            local buf = vim.api.nvim_create_buf(true, true)
            vim.api.nvim_win_set_buf(win, buf)

            funsql(buf)
        end
    end
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
