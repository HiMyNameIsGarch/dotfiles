" Sets
let mapleader=" "
set guicursor=
set relativenumber
set nohlsearch
set noerrorbells
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nowrap
set nu
set smartcase
set noswapfile
set nobackup
set undodir=~/.config/nvim/undodir
set undofile
set incsearch
set scrolloff=8
set noshowmode
set completeopt=menuone,noinsert,noselect
set colorcolumn=80
set signcolumn=yes
set cmdheight=2
set updatetime=50
set showcmd
set splitright

" Remaps
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
inoremap kj <esc>
vnoremap K :m '<-2<CR>gv=gv
vnoremap J :m '>+1<CR>gv=gv
nnoremap Q <nop>

call plug#begin('~/.config/nvim/plugged')

Plug 'itchyny/lightline.vim'
Plug 'ThePrimeagen/vim-be-good'
Plug 'gruvbox-community/gruvbox'

call plug#end()

colorscheme gruvbox
