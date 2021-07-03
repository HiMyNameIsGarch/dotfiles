syntax on

"       Maps
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
inoremap kj <esc>
vnoremap K :m '<-2<CR>gv=gv
vnoremap J :m '>+1<CR>gv=gv
command! W write
nnoremap Q <nop>

"       Setters
let mapleader = " "
set splitright
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smartindent
set relativenumber
set nohlsearch
set nu
set nowrap
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set viminfo=%,<800,'10,/50,:100,h,f0,n~/.vim/cache/.viminfo
set undofile
set incsearch
set scrolloff=8
set signcolumn=yes
set laststatus=2
set noshowmode
set colorcolumn=80
set showcmd
set cmdheight=2
set updatetime=50

"       Plugins
call plug#begin('~/.vim/plugged')

" Manage git files
Plug 'tpope/vim-fugitive'
" Better line 
Plug 'itchyny/lightline.vim'
" Some kind of file tree
Plug 'preservim/nerdtree'
" Fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" Completion and a lot of stuff
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Gruvbox
Plug 'gruvbox-community/gruvbox'

call plug#end()

"       Gruvbox
colorscheme gruvbox
