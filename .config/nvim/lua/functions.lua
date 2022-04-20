local M = {}

function M.middle()
    vim.fn.inputsave()
    local text = vim.fn.input('Enter text to center: ')
    vim.fn.inputrestore()
    vim.cmd('read !center ' .. text)
end

return M
