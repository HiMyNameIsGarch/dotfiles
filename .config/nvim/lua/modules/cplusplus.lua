local opts = { noremap = true }

vim.keymap.set('n', '<leader>cpp', function ()
    vim.fn.inputsave()
    local args = vim.fn.input('args?: ')
    vim.fn.inputrestore()
    vim.cmd('silent !tmux-run gocpp ' .. args) -- 'gocpp' is an alias for 'clang++ main.cpp && ./a.out' or build and run
end , opts)

function WriteToBuf(buf, data)
    if data or string.len(data) >= 1 then
        vim.api.nvim_buf_set_lines(buf, -1, -1, false, data)
    end
end

vim.api.nvim_create_autocmd("BufWritePost", {
    group = vim.api.nvim_create_augroup("Cpp_single_file", {clear = true}),
    pattern = "main.cpp",
    callback = function()

        -- create the split
        vim.cmd('vsplit')
        local win = vim.api.nvim_get_current_win()
        local buf = vim.api.nvim_create_buf(true, true)
        vim.api.nvim_win_set_buf(win, buf)

        -- start compiling
        vim.fn.jobstart({"clang++", "main.cpp"}, {
            stdout_buffered = true,
            stderr_buffered = true,
            on_stderr = function (_, data)
                WriteToBuf(buf, data)
            end,
            on_stdout = function (_, data)
                WriteToBuf(buf, data)
            end,
            on_exit = function()
                vim.fn.jobstart({'./a.out'}, {
                    on_stdout = function(_, data)
                        if data then
                            WriteToBuf(buf, data)
                        end
                    end
                })
            end
        })
    end
})
