" Maximizer
nnoremap <silent> M <cmd>MaximizerToggle!<CR>

" Vimspector
fun MaxWin(id)
    call win_gotoid(a:id)
    MaximizerToggle
endfun

" Actions
nnoremap <leader>dtcb :call vimspector#CleanLineBreakpoint()<CR>
nnoremap <leader>d<space> :call vimspector#Continue()<CR>
nnoremap <leader>dd :call vimspector#Launch()<CR>
nnoremap <leader>de :call vimspector#Reset()<CR>

" Go to windows
nnoremap <leader>dv :call MaxWin(g:vimspector_session_windows.variables)<CR>
nnoremap <leader>dc :call MaxWin(g:vimspector_session_windows.code)<CR>
nnoremap <leader>dw :call MaxWin(g:vimspector_session_windows.watches)<CR>
nnoremap <leader>ds :call MaxWin(g:vimspector_session_windows.stack_trace)<CR>
nnoremap <leader>do :call MaxWin(g:vimspector_session_windows.output)<CR>
nnoremap <leader>dt :call MaxWin(g:vimspector_session_windows.tagpage)<CR>

" Steps
nmap <leader>dl <Plug>VimspectorStepInto
nmap <leader>dh <Plug>VimspectorStepOver
nmap <leader>dk <Plug>VimspectorStepOut
nmap <leader>d_ <Plug>VimspectorRestart
nmap <leader>drc <Plug>VimspectorRunToCursor
nmap <leader>dbp <Plug>VimspectorToggleBreakpoint
"nmap <leader>dcbp <Plug>VimspectorToggleConditionalBreakpoint
