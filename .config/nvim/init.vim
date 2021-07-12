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
vnoremap <C-k> :m '<-2<CR>gv=gv
vnoremap <C-j> :m '>+1<CR>gv=gv
nnoremap Q <nop>
command! W write

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
Plug 'nvim-lua/completion-nvim'
" Tree-sitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
" Telescope to see files better
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim', { 'do': 'make' }
" Preview some markdown files 
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

call plug#end()

colorscheme gruvbox
