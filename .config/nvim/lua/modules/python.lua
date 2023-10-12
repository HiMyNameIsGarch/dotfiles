local path_to_buf = "/tmp/buf_nr_py"

local fo = require("file_operation")

local function Append_program_in(buf)
    vim.fn.jobstart({"python3", "main.py"}, {
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
    group = vim.api.nvim_create_augroup("python_no_input", {clear = true}),
    pattern = "main.py",
    callback = function()
        local fbuf = fo.Read_buf_from_file(path_to_buf)

        if fbuf and vim.fn.bufexists(fbuf) == 1 then
            Append_program_in(fbuf)
        else
            vim.cmd('vsplit')
            local win = vim.api.nvim_get_current_win()
            local buf = vim.api.nvim_create_buf(true, true)
            vim.api.nvim_win_set_buf(win, buf)

            Append_program_in(buf)
        end
    end
})
