" Remaps
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>
" Improvements
inoremap kj <esc>
inoremap <C-c> <esc>
vnoremap <C-k> :m '<-2<CR>gv=gv
vnoremap <C-j> :m '>+1<CR>gv=gv
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
" Pairs
Plug 'jiangmiao/auto-pairs'

call plug#end()

" Colorscheme
colorscheme gruvbox
