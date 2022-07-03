"           Config
let g:fzf_preview_window = 'right:50%'

"           Maps
nnoremap <C-p> :Files<CR>
nnoremap <C-t> :GFiles<CR>
nnoremap <C-g> :GFiles?<CR>
nnoremap <C-b> :Buffers<CR>
nnoremap <Leader>li :Lines<CR>
nnoremap <Leader>bl :BLines<CR>
nnoremap <Leader>rg :Rg<CR>
nnoremap <Leader>vp :VimPLug<CR>

"           Commands
command! -bang -nargs=? -complete=dir VimPlug
    \ call fzf#vim#files('~/.vim/plugin', fzf#vim#with_preview(), <bang>0)
