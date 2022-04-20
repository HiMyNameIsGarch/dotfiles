-- Enter some text to center
vim.keymap.set('n', '<leader>md', function ()
    vim.fn.inputsave()
    local text = vim.fn.input('Enter text to center: ')
    vim.fn.inputrestore()
    vim.cmd('read !center ' .. text)
end, { noremap = true })
