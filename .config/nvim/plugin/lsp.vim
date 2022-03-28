" Language servers
lua << EOF

    require'lspconfig'.tsserver.setup{}
    require'lspconfig'.vuels.setup{}
    require'lspconfig'.vimls.setup{}
    require'lspconfig'.bashls.setup{}
    require'lspconfig'.pyright.setup{}
    require'lspconfig'.sumneko_lua.setup{}

    -- OmniSharp
    local pid = vim.fn.getpid()
    local function on_cwd()
        return vim.loop.cwd()
    end

    local omnisharp_bin = "/home/himynameisgarch/.local/share/nvim/omnisharp/run"

    require'lspconfig'.omnisharp.setup{
       on_attach = on_attach,
       root_dir = on_cwd,
       cmd = { omnisharp_bin, "--languageserver", "hostPID", tostring(pid) },
         handlers = {
           ["textDocument/definition"] = require('omnisharp_extended').handler,
         },
    }

EOF

" Maps
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> <C-p> <cmd>lua vim.diagnostic.goto_prev()<CR>
nnoremap <silent> <C-n> <cmd>lua vim.diagnostic.goto_next()<CR>
nnoremap <leader>ca :lua vim.lsp.buf.code_action()<CR>
nnoremap <leader>rn :lua vim.lsp.buf.rename()<CR>
