" Maps for dotnet development

nnoremap <leader>dnb :!dotnet build<CR>

function! DotnetRun()
    call inputsave()
    let args = input('dotnet run ')
    call inputrestore()
    execute 'silent !tmux-dotnet ' . args
endfunction

nnoremap <leader>dnr :call DotnetRun()<CR>
