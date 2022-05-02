local mapkey = vim.keymap

local opts = { noremap = true }

-- Baby steps into vim
function RemoveArrows(mode)
        local arrows = { 'Up', 'Down', 'Left', 'Right' }
        for _, arrow in ipairs(arrows) do
            mapkey.set(mode, '<' .. arrow .. '>', '<Nop>', opts)
        end
end
RemoveArrows('')
RemoveArrows('i')

-- improvements
mapkey.set('n', 'Y', 'y$', opts)
mapkey.set('i', 'kj', '<esc>', opts)
mapkey.set('i', '<C-c>', '<esc>', opts)

-- Move lines with skill
mapkey.set('v', 'K', ':m \'<-2<CR>gv=gv', opts)
mapkey.set('v', 'J', ':m \'<+1<CR>gv=gv', opts)
mapkey.set('i', '<C-j>', '<esc>:m .+1<CR>==', opts)
mapkey.set('i', '<C-k>', '<esc>:m .-2<CR>==', opts)
mapkey.set('n', '<leader>j', ':m .+1<CR>==', opts)
mapkey.set('n', '<leader>k', ':m .-2<CR>==', opts)

-- Keep it centered
mapkey.set('n', 'n', 'nzzzv', opts)
mapkey.set('n', 'N', 'Nzzzv', opts)
mapkey.set('n', 'J', 'mzJ`z', opts)

-- Undo better
mapkey.set('i', ',', ',<c-g>u', opts)
mapkey.set('i', '.', '.<c-g>u', opts)
mapkey.set('i', '!', '!<c-g>u', opts)
mapkey.set('i', '?', '?<c-g>u', opts)

-- Quick search and replace
mapkey.set('n', 'cn', '*``cgn', opts)
mapkey.set('n', 'cN', '*``cgN', opts)

-- Surround
mapkey.set('v', '\'', '<esc>`>a\'<esc>`<i\'<esc>', opts)
mapkey.set('v', '"', '<esc>`>a"<esc>`<i"<esc>', opts)
mapkey.set('v', '(', '<esc>`>a)<esc>`<i(<esc>', opts)
mapkey.set('v', '[', '<esc>`>a]<esc>`<i[<esc>', opts)
mapkey.set('v', '{', '<esc>`>a}<esc>`<i{<esc>', opts)

-- Copy-Pasta master
mapkey.set('v', '<leader>y', '"+y', opts)
mapkey.set('n', '<leader>y', '"+y', opts)
mapkey.set('n', '<leader>Y', 'gg"+yG', opts)
-- P is for Paste
mapkey.set('v', '<leader>p', '"+P', opts)
mapkey.set('n', '<leader>p', '"+P', opts)
mapkey.set('x', '<leader>p', '"_dP', opts)
-- Black hole
mapkey.set('v', '<leader>d', '"_d', opts)
mapkey.set('n', '<leader>d', '"_d', opts)

-- Please no
mapkey.set('n', 'Q', '<nop>', opts)
vim.cmd [[ command! W write ]]

-- Source better
mapkey.set('n', '<Leader><CR>', ':so ~/.config/nvim/init.lua<CR>', opts)

-- Netrw
mapkey.set('n', '<leader>le', ":Lex<CR>", opts)
