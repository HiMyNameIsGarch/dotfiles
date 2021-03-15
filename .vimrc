syntax on

noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
nmap <silent> <C-k> :wincmd k<CR>
nmap <silent> <C-j> :wincmd j<CR>
nmap <silent> <C-h> :wincmd h<CR>
nmap <silent> <C-l> :wincmd l<CR>

let mapleader = " "
set splitright
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set relativenumber
set nohlsearch
set nu
set nowrap
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set scrolloff=8
set signcolumn=yes
set laststatus=2
set noshowmode

set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }

call plug#begin('~/.vim/plugged')

Plug 'itchyny/lightline.vim'
Plug 'vifm/vifm.vim'
Plug 'OmniSharp/omnisharp-vim'
Plug 'preservim/nerdtree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ervandew/supertab'
Plug 'dense-analysis/ale'
Plug 'puremourning/vimspector'
Plug 'tpope/vim-dadbod'
Plug 'kristijanhusak/vim-dadbod-ui'

call plug#end()

"       vimspector
let g:vimspector_enable_mappings = 'HUMAN'
nnoremap <leader>dd :call vimspector#Launch()<CR>
nnoremap <leader>de :call vimspector#Reset()<CR>
"let g:vimspector_enable_mappings = 'VISUAL_STUDIO'

"       omnisharp

let g:OmniSharp_selector_ui = 'fzf'
let g:OmniSharp_selector_findusages = 'fzf'
let g:OmniSharp_highlighting = 3
autocmd FileType cs nmap <silent> gd :OmniSharpGotoDefinition<CR>
autocmd FileType cs nnoremap <buffer> <Leader>fu :OmniSharpFindUsages<CR>
autocmd FileType cs nnoremap <buffer> <Leader>fi :OmniSharpFindImplementations<CR>
autocmd FileType cs nnoremap <Leader><Space> :OmniSharpGetCodeActions<CR>


"          coc

highlight CocFloating ctermbg=0
hi Pmenu ctermfg=7 ctermbg=0 guibg=Black
hi PmenuSel ctermfg=4 ctermbg=0 guibg=Black

"          ale

let g:ale_linters = {
\ 'cs': ['OmniSharp']
\}
highlight clear ALEErrorSign
highlight clear ALEWarningSign
let g:ale_linters = { 'cs' : ['OmniSharp'] }

"        nerdtree

nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <C-f> :Files<CR>
nnoremap <C-p> :GFiles<CR>
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let g:NERDTreeIgnore = ['bin', 'obj']


"        supertab        

let g:SuperTabDefaultCompletionType = "<c-n>"


"          fzf
let g:fzf_preview_window = 'right:60%'

