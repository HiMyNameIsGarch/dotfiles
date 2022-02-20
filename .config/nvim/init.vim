let mapleader=" "
" Remaps
"
" Baby steps into vim
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>

" Improvements
nnoremap Y y$
inoremap kj <esc>
inoremap <C-c> <esc>

" Move lines with skill
vnoremap K :m '<-2<CR>gv=gv
vnoremap J :m '>+1<CR>gv=gv
inoremap <C-j> <esc>:m .+1<CR>==
inoremap <C-k> <esc>:m .-2<CR>==
nnoremap <leader>j :m .+1<CR>==
nnoremap <leader>k :m .-2<CR>==

" Keep it centered
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

" Undo better
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u

" Quick search and replace
nnoremap cn *``cgn
nnoremap cN *``cgN

" Surround
vnoremap ' <esc>`>a'<esc>`<i'<esc>
vnoremap " <esc>`>a"<esc>`<i"<esc>
vnoremap ( <esc>`>a)<esc>`<i(<esc>
vnoremap [ <esc>`>a]<esc>`<i[<esc>
vnoremap { <esc>`>a}<esc>`<i{<esc>

" Copy-Pasta master
vnoremap <leader>y "+y
nnoremap <leader>y "+y
nnoremap <leader>Y gg"+yG
" P is for Paste
nnoremap <leader>p "+P
vnoremap <leader>p "+P
xnoremap <leader>p "_dP
" Black hole
vnoremap <leader>d "_d
nnoremap <leader>d "_d

" Please no
nnoremap Q <nop>
command! W write

" Source better
nnoremap <Leader><CR> :so ~/.config/nvim/init.vim<CR>

call plug#begin('~/.config/nvim/plugged')

" Manage git better
Plug 'tpope/vim-fugitive'
" Get faster at vim 
Plug 'ThePrimeagen/vim-be-good'
" Minimal line
Plug 'itchyny/lightline.vim'
" Of course, the best color scheme
Plug 'gruvbox-community/gruvbox'
" Language server protocol
Plug 'neovim/nvim-lspconfig' 
" Completion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/cmp-vsnip'
" lsp king
Plug 'onsails/lspkind-nvim'
" Tree-sitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
" Telescope to see files better
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim', { 'do': 'make' }
" Preview some markdown files 
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
" Pair
Plug 'jiangmiao/auto-pairs'
" Debugger
Plug 'szw/vim-maximizer'
Plug 'puremourning/vimspector'
" This is a comment
Plug 'numToStr/Comment.nvim'

call plug#end()

" Colorscheme
colorscheme gruvbox
hi Normal guibg=NONE ctermbg=NONE
let g:vim_be_good_log_file = 1
