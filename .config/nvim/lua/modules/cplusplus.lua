local path_to_buf = "/tmp/buf_nr_cpp"

local fo = require("file_operation")

local nnoremap = require("keymap").nnoremap
local ts = require 'nvim-treesitter'

nnoremap('<leader>nq', function ()
    print("hello world")
    -- get current buffer ( the header file )
    local bufnr = vim.api.nvim_get_current_buf()
    -- get the path of the header file
    -- local header_path = vim.api.nvim_buf_get_name(bufnr)
    -- get the text of the header file
    -- local text = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    -- init the parser
    local parser = ts.get_parser(bufnr, 'cpp')
    -- query the class node
    local class_node = parser:query_ast("(class_declaration name: (identifier))")[1]
    -- get the class name
    -- local class_name = class_node:child(0):text()
    local fields = {}
    for _, node in ipairs(parser:query_ast("(class_declaration name: (identifier) > (access_specifier public) > (field_declaration)")) do
        local field_declarator = node.child_by_field_name("declarator")
        print(field_declarator)
        if field_declarator then
            local declarator = field_declarator:text()
            table.insert(fields, {declaration = declarator})
        end
    end
end)

nnoremap('<leader><leader>c', "<cmd>source ~/.config/nvim/lua/modules/snippets.lua<CR>")

local function crazy_header_tocpp()
    -- take class_specifier from header file
    -- then in body search for access_specifier and ignore private and protected
    -- then take all the field declaration and put them in the cpp file
    -- with the following format:
    -- <type> <class_name>::<field_name> = <value>;
end

local function Append_program_in(buf)
    vim.fn.jobstart({"clang++","-Wall", "-Wextra", "-Werror",  "-Wpedantic", "-g", "-o", "a.out", "main.cpp"}, {
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

nnoremap('<leader>cpp', function ()
    vim.fn.inputsave()
    local args = vim.fn.input('args?: ')
    vim.fn.inputrestore()
    vim.cmd('silent !tmux-run gocpp ' .. args) -- 'gocpp' is an alias for 'clang++ main.cpp && ./a.out' or build and run
end)

local function createfile(fpath, ext, txt)
    local cbuf = vim.api.nvim_create_buf(true, false)
    local filepath = vim.fn.expand('%:p:h') .. '/' .. fpath .. '.' .. ext
    local ft = ext
    if ext == 'h' then
        ft = 'c'
    end
    vim.api.nvim_buf_set_option(cbuf, 'filetype', ft)
    vim.api.nvim_buf_set_option(cbuf, 'modifiable', true)
    vim.api.nvim_buf_set_name(cbuf, filepath);
    -- set class template
    vim.api.nvim_buf_set_lines(cbuf, 0, -1, false, txt)

    return cbuf, filepath

    -- return cbuf, filepath
end

local function create_class(cname)
    local cppbuf, cppf = createfile('src/' .. cname, 'cpp', {
        '#include "../include/' .. cname .. '.' .. 'h"',
        ''
    })
    vim.api.nvim_buf_call(cppbuf, function ()
        vim.api.nvim_command("write " .. cppf)
    end)

    local hbuf, hf = createfile('include/' .. cname, 'h', {
        '#pragma once',
        '#ifndef ' .. string.upper(cname) .. '_H',
        '#define ' .. string.upper(cname) .. '_H',
        '',
        'class ' .. cname:gsub("^%l", string.upper) .. ' {',
        'protected:',
        '',
        'private:',
        '',
        'public:',
        '',
        '};',
        '',
        '#endif'
    })

    vim.api.nvim_buf_call(hbuf, function ()
        vim.api.nvim_command("write " .. hf)
    end)

end

nnoremap('<leader>gpp', function ()
    -- Get input from user
    vim.fn.inputsave()
    local flname = vim.fn.input('Class name: ')
    vim.fn.inputrestore()

    -- strip whitespace
    flname = flname:match( "^%s*(.-)%s*$" )
    if flname == '' then
        return
    end

    -- iterate over every word separated by space
    for class in flname:gmatch("%S+") do
        if class == '' then
            break
        end
        create_class(class)
    end
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
