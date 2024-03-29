local path_to_buf = "/tmp/buf_nr_cpp"

local fo = require("file_operation")

local function Append_program_in(buf)
    vim.fn.jobstart({"clang++", "main.cpp"}, {
        stdout_buffered = true,
        stderr_buffered = true,
        on_stderr = function (_, data)
            fo.WriteToBuf(path_to_buf, buf, data)
        end,
        on_stdout = function (_, data)
            fo.WriteToBuf(path_to_buf, buf, data)
        end,
        on_exit = function()
            vim.fn.jobstart({'./a.out'}, {
                on_stdout = function(_, data)
                    fo.WriteToBuf(path_to_buf, buf, data)
                end
            })
        end
    })
end

vim.api.nvim_create_autocmd("BufWritePost", {
    group = vim.api.nvim_create_augroup("Cpp_single_file", {clear = true}),
    pattern = "main.cpp",
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

local nnoremap = require("keymap").nnoremap

nnoremap('<leader>cpp', function ()
    vim.fn.inputsave()
    local args = vim.fn.input('args?: ')
    vim.fn.inputrestore()
    vim.cmd('silent !tmux-run gocpp ' .. args) -- 'gocpp' is an alias for 'clang++ main.cpp && ./a.out' or build and run
end)

nnoremap('<leader>cs', function () -- clear solution
    vim.fn.inputsave()
    local name = vim.fn.input('solution name: ')
    vim.fn.inputrestore()
    vim.cmd("silent !mkdir " .. name)
    vim.cmd("w " .. name .. "/main.cpp")
    vim.cmd("1,%d")
    -- Call snippet
    local luasnip = require('luasnip')
    local snip = luasnip.get_snippets("cpp")[1]
    luasnip.snip_expand(snip)
end)
