-- mapper ???
local map = function(mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs, { noremap = true })
end

-- Baby steps into vim
function RemoveArrows(mode)
        local arrows = { 'Up', 'Down', 'Left', 'Right' }
        for _, arrow in ipairs(arrows) do
            map(mode, '<' .. arrow .. '>', '<Nop>')
        end
end
RemoveArrows('')
RemoveArrows('i')

-- improvements
map('n', 'Y', 'y$')
map('i', 'kj', '<esc>')
map('i', '<C-c>', '<esc>')

-- Move lines with skill
map('v', 'K', ':m \'<-2<CR>gv=gv')
map('v', 'J', ':m \'<+1<CR>gv=gv')
map('i', '<C-j>', '<esc>:m .+1<CR>==')
map('i', '<C-k>', '<esc>:m .-2<CR>==')
map('n', '<leader>j', ':m .+1<CR>==')
map('n', '<leader>k', ':m .-2<CR>==')

-- Keep it centered
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')
map('n', 'J', 'mzJ`z')

-- Undo better
map('i', ',', ',<c-g>u')
map('i', '.', '.<c-g>u')
map('i', '!', '!<c-g>u')
map('i', '?', '?<c-g>u')

-- Quick search and replace
map('n', 'cn', '*``cgn')
map('n', 'cN', '*``cgN')

-- Surround
map('v', '\'', '<esc>`>a\'<esc>`<i\'<esc>')
map('v', '"', '<esc>`>a"<esc>`<i"<esc>')
map('v', '(', '<esc>`>a)<esc>`<i(<esc>')
map('v', '[', '<esc>`>a]<esc>`<i[<esc>')
map('v', '{', '<esc>`>a}<esc>`<i{<esc>')

-- Copy-Pasta master
map('v', '<leader>y', '"+y')
map('n', '<leader>y', '"+y')
map('n', '<leader>Y', 'gg"+yG')

-- P is for Paste
map('v', '<leader>p', '"+P')
map('n', '<leader>p', '"+P')
map('x', '<leader>p', '"_dP')

-- Black hole
map('v', '<leader>d', '"_d')
map('n', '<leader>d', '"_d')

-- Please no
map('n', 'Q', '<nop>')
vim.cmd [[ command! W write ]]

-- Source better
map('n', '<Leader><CR>', ':so ~/.config/nvim/init.lua<CR>')

-- Netrw
map('n', '<leader>le', ":Lex<CR>")

-- Quickfix list
map('n', '<leader>clr', function() -- Clear
    vim.fn.setqflist({})
    vim.notify_once("Quickfix cleared!")
end)
map('n', '<leader>cj', ':cprev<CR>')
map('n', '<leader>ck', ':cnext<CR>')
map('n', '<leader>cl', function () -- Spawn telescope quickfix list window
    require('telescope.builtin').quickfix()
end)
