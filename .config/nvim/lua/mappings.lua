-- Mapper
local Remap = require("keymap")
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap
local inoremap = Remap.inoremap
local xnoremap = Remap.xnoremap
local nmap = Remap.nmap

-- Baby steps into vim
function RemoveArrows(mode)
        local arrows = { 'Up', 'Down', 'Left', 'Right' }
        for _, arrow in ipairs(arrows) do
            vim.keymap.set(mode, '<' .. arrow .. '>', '<Nop>', {noremap = true})
        end
end
RemoveArrows('')
RemoveArrows('i')

-- improvements
nnoremap('Y', 'y$')
inoremap('kj', '<esc>')
inoremap('<C-c>', '<esc>')

-- Move lines with skill
vnoremap('K', ':m \'<-2<CR>gv=gv')
vnoremap('J', ':m \'<+1<CR>gv=gv')
inoremap('<C-j>', '<esc>:m .+1<CR>==')
inoremap('<C-k>', '<esc>:m .-2<CR>==')
nnoremap('<leader>j', ':m .+1<CR>==')
nnoremap('<leader>k', ':m .-2<CR>==')

-- Keep it centered
nnoremap('n', 'nzzzv')
nnoremap('N', 'Nzzzv')
nnoremap('J', 'mzJ`z')

-- Undo better
inoremap(',', ',<c-g>u')
inoremap('.', '.<c-g>u')
inoremap('!', '!<c-g>u')
inoremap('?', '?<c-g>u')

-- Quick search and replace
nnoremap('cn', '*``cgn')
nnoremap('cN', '*``cgN')

-- Surround
vnoremap('\'', '<esc>`>a\'<esc>`<i\'<esc>')
vnoremap('"', '<esc>`>a"<esc>`<i"<esc>')
vnoremap('(', '<esc>`>a)<esc>`<i(<esc>')
vnoremap('[', '<esc>`>a]<esc>`<i[<esc>')
vnoremap('{', '<esc>`>a}<esc>`<i{<esc>')

-- Copy-Pasta master
vnoremap('<leader>y', '"+y')
nnoremap('<leader>y', '"+y')
nmap('<leader>Y', 'gg"+yG')

-- P is for Paste
vnoremap('<leader>p', '"+P')
nnoremap('<leader>p', '"+P')
xnoremap('<leader>p', '"_dP')

-- Black hole
vnoremap('<leader>d', '"_d')
nnoremap('<leader>d', '"_d')

-- Please no
nnoremap('Q', '<nop>')
vim.cmd [[ command! W write ]]

-- Source better
nnoremap('<Leader><CR>', ':so ~/.config/nvim/init.lua<CR>')

-- Netrw
nnoremap('<leader>le', ":Lex<CR>")

-- Quickfix list
nnoremap('<leader>clr', function() -- Clear
    vim.fn.setqflist({})
    vim.notify_once("Quickfix cleared!")
end)
nnoremap('<leader>cj', ':cprev<CR>')
nnoremap('<leader>ck', ':cnext<CR>')
nnoremap('<leader>cl', function () -- Spawn telescope quickfix list window
    require('telescope.builtin').quickfix()
end)
