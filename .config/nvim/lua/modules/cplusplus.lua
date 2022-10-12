local opts = { noremap = true }

vim.keymap.set('n', '<leader>cpp', function ()
    vim.fn.inputsave()
    local args = vim.fn.input('args?: ')
    vim.fn.inputrestore()
    vim.cmd('silent !tmux-run gocpp ' .. args) -- 'gocpp' is an alias for 'clang++ main.cpp && ./a.out' or build and run
end , opts)

local path_to_buf = "/tmp/buf_nr_cpp"

local function Read_buf_from_file(path)
    local file = io.open(path, "r")
    if not file then return nil end
    local content = file:read "*a"
    file:close()
    return tonumber(content)
end


local function Write_buf_to_file(path, buf)
    local file = io.open(path, "w+")
    if not file then return nil end
    file:write(buf)
    file:close()
end

function WriteToBuf(buf, data)
    if data then
        vim.api.nvim_buf_set_lines(buf, 0, 0, false, data)
        Write_buf_to_file(path_to_buf, buf)
    end
end

vim.keymap.set('n', '<leader>cs', function () -- clear solution
    vim.fn.inputsave()
    local name = vim.fn.input('solution name: ')
    vim.fn.inputrestore()
    vim.cmd("silent !mkdir " .. name)
    vim.cmd("w " .. name .. "/main.cpp")
    vim.cmd("1,%d")
    vim.api.nvim_feedkeys("imain", 'i', true)
end)

local function Append_program_in(buf)
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
                    WriteToBuf(buf, data)
                end
            })
        end
    })
end

vim.api.nvim_create_autocmd("BufWritePost", {
    group = vim.api.nvim_create_augroup("Cpp_single_file", {clear = true}),
    pattern = "main.cpp",
    callback = function()
        local fbuf = Read_buf_from_file(path_to_buf)

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

