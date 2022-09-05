-- Maps for dotnet development
local opts = { noremap = true }

vim.keymap.set('n', '<leader>dnb', ':!dotnet build<CR>', opts)

vim.keymap.set('n', '<leader>dnr', function ()
    vim.fn.inputsave()
    local text = vim.fn.input('dotnet run ')
    vim.fn.inputrestore()
    vim.cmd('silent !tmux-dotnet ' .. text)
end , opts)

local function getEntryFromErr(line)
    if line == nil or line == '' then
        return nil
    end
    local nums = line:match("%d+,%d+")

    return {
        filename = line:match("^.-.cs"),
        lnum  = nums:match("^%d+"),
        col  = nums:match("%d+$"),
        text  = line:match("error.-%["):sub(1, -2),
    }
end

local function getErrors()
    print("Started compiling dotnet project")
    vim.fn.jobstart("dotnet build --no-restore --nologo | grep error | sort | uniq", {
        stdout_buffered = true,
        on_stdout = function (_, data)
            if not data then
                return
            end

            if #data == 1 then
                print ("No errors found!")
                return
            end

            for _, err in ipairs(data) do
                local entry = getEntryFromErr(err)
                if not entry then
                    return
                end
                vim.fn.setqflist({entry}, 'a');
                vim.cmd('copen')
            end
        end,
    })
end


vim.keymap.set('n', '<leader>drr', getErrors)
