syntax on

"       Maps
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
nmap <silent> <C-k> :wincmd k<CR>
nmap <silent> <C-j> :wincmd j<CR>
nmap <silent> <C-h> :wincmd h<CR>
nmap <silent> <C-l> :wincmd l<CR>
nnoremap H gT
nnoremap L gt
inoremap jh <Esc>

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

"       Plugins
call plug#begin('~/.vim/plugged')
Plug 'itchyny/lightline.vim'
Plug 'OmniSharp/omnisharp-vim'
Plug 'preservim/nerdtree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ervandew/supertab'
Plug 'dense-analysis/ale'
Plug 'puremourning/vimspector'
Plug 'leafgarland/typescript-vim'
Plug 'posva/vim-vue'
Plug 'pangloss/vim-javascript'
Plug 'honza/vim-snippets'
Plug 'jiangmiao/auto-pairs'
Plug 'gruvbox-community/gruvbox'
Plug 'tpope/vim-fugitive'
"Plug 'ThePrimeagen/vim-be-good'
call plug#end()

"       Gruvbox
colorscheme gruvbox

"       fugitive
nmap <Leader>gs :G<CR>
nmap <Leader>gf :diffget //3<CR>
nmap <Leader>gj :diffget //2<CR>

"       vim-vue
let g:vue_pre_processors = 'detect_on_enter'

"       Column
highlight ColorColumn ctermbg=0 guibg=lightgrey

"       Lightline
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }

"       Vimspector
let g:vimspector_enable_mappings = 'HUMAN'
nnoremap <leader>dd :call vimspector#Launch()<CR>
nnoremap <leader>de :call vimspector#Reset()<CR>

"       Omnisharp
let g:OmniSharp_selector_ui = 'fzf'
let g:OmniSharp_selector_findusages = 'fzf'
let g:OmniSharp_highlighting = 3
autocmd FileType cs nmap <silent> gd :OmniSharpGotoDefinition<CR>
autocmd FileType cs nnoremap <buffer> <Leader>fu :OmniSharpFindUsages<CR>
autocmd FileType cs nnoremap <buffer> <Leader>fi :OmniSharpFindImplementations<CR>
autocmd FileType cs nnoremap <Leader><Space> :OmniSharpGetCodeActions<CR>

"        Coc
highlight CocFloating ctermbg=0
hi Pmenu ctermfg=7 ctermbg=0 guibg=Black
hi PmenuSel ctermfg=4 ctermbg=0 guibg=Black
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
let g:coc_snippet_next = '<tab>'

"         Ale
nnoremap <Leader>ep :ALEPrevious -wrap -error<CR>
nnoremap <Leader>en :ALENext -wrap -error<CR>
nnoremap <Leader>gd :ALEGoToDefinition<CR>
nnoremap <Leader>ho :ALEHover<CR>
let g:ale_sign_error = '&&'
let g:ale_sign_warning = '--'
highlight clear ALEErrorSign
highlight clear ALEWarningSign
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_info_str = 'I'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_linter_aliases = {'vue': ['vue', 'javascript']}
let b:ale_linters = ['eslint', 'tslint', 'tsserver', 'typecheck', 'vls', {'vue': ['eslint', 'vls']} ]
let g:ale_set_highlights = 1

"        Nerdtree
nnoremap <C-n> :NERDTreeToggle<CR>
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let g:NERDTreeIgnore = ['bin', 'obj', 'node_modules']
" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif

"        Supertab        
let g:SuperTabDefaultCompletionType = "<c-n>"
let g:SuperTabCrMapping=1

"           Fzf
nnoremap <C-p> :Files<CR>
nnoremap <C-t> :GFiles<CR>
nnoremap <C-g> :GFiles?<CR>
let g:fzf_preview_window = 'right:50%'

