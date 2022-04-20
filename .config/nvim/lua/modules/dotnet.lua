-- Maps for dotnet development
local opts = { noremap = true }

vim.keymap.set('n', '<leader>dnb', ':!dotnet build<CR>', opts)

vim.keymap.set('n', '<leader>dnr', function ()
    vim.fn.inputsave()
    local text = vim.fn.input('dotnet run ')
    vim.fn.inputrestore()
    vim.cmd('silent !tmux-dotnet ' .. text)
end , opts)
