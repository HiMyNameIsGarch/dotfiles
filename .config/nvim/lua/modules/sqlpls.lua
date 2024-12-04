local fo = require("file_operation")

local path_to_buf = "/tmp/sqlisfun"

local function start_sql_process(sql_file, buffer)

    vim.api.nvim_buf_set_lines(buffer, 0, -1, false, {})

    vim.fn.jobstart({ "sqlcmd", "-S", "localhost", "-U", "sa", "-P", "Muielarga69!", "-d", "passman", "-h-1", "-W", "-i", sql_file, "-C" }, {
        stdout_buffered = true,
        stderr_buffered = true,
        on_stderr = function (_, data)
            fo.WriteToBuf(path_to_buf,buffer, data)
        end,
        on_stdout = function (_, data)
            fo.WriteToBuf(path_to_buf,buffer, data)
        end
        })
end

local function funsql(buf)
    local current_sql_file = vim.fn.expand('%:p')

    start_sql_process(current_sql_file, buf)

end

-- Function to write selected lines to a file
function _G.write_selection_to_file()
    -- Get the start and end of the visual selection
    local start_line = vim.fn.line("'<")
    local end_line = vim.fn.line("'>")

    -- Get the lines in the selection
    local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)

    -- Specify the file to save the selection
    local file_path = '/tmp/sqlpls_output.sql'

    -- Write the lines to the file
    local file = io.open(file_path, "w")
    if file then
        for _, line in ipairs(lines) do
            file:write(line .. "\n")
        end
        file:close()
        local fbuf = fo.Read_buf_from_file(path_to_buf)

        if fbuf and vim.fn.bufexists(fbuf) == 1 then
            start_sql_process(file_path, fbuf)
        end

    else
        print("Failed to open file for writing. File path: " .. file_path)
    end
end

vim.api.nvim_create_autocmd("FileType", {
    pattern = "sql", -- Apply only to SQL files
    callback = function()
        -- Map the function to a keybinding in visual mode for SQL files
        vim.api.nvim_buf_set_keymap(0, 'v', '<leader>wf', ':lua write_selection_to_file()<CR>', { noremap = true, silent = true })
    end
})

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

-- dadbod for databases
vim.g.db_ui_save_location = "~/.local/share/db_queries"
vim.keymap.set('n', '<leader>db', ":DBUIToggle<CR>",            { silent = true, noremap = true })
vim.keymap.set('n', '<leader>dl', ":DBUIHideNotifications<CR>", { silent = true, noremap = true })
vim.keymap.set('n', '<leader>di', ":DBUILastQueryInfo<CR>",     { noremap = true })
