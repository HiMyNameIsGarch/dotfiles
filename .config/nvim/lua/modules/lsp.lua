local lspconfig = require("lspconfig")

lspconfig.tsserver.setup{}
lspconfig.vuels.setup{}
lspconfig.vimls.setup{}
lspconfig.bashls.setup{}
lspconfig.pyright.setup{}
lspconfig.dartls.setup{}

-- Lua
lspconfig.sumneko_lua.setup {
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                -- Setup lua path
                path = (function()
                    local runtime_path = vim.split(package.path, ';')
                    table.insert(runtime_path, "lua/?.lua")
                    table.insert(runtime_path, "lua/?/init.lua")
                    return runtime_path
                end)(),
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {'vim'}
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true)
            }
        }
    }
}
-- OmniSharp
local omnisharp_bin = "/home/himynameisgarch/.local/share/nvim/omnisharp/run"
lspconfig.omnisharp.setup{
    -- on_attach = on_attach,
    root_dir = function()
        return vim.loop.cwd()
    end,
    cmd = { omnisharp_bin, "--languageserver", "hostPID", tostring(vim.fn.getpid()) },
    handlers = {
        ["textDocument/definition"] = require('omnisharp_extended').handler,
    },
}

local opts = { noremap = true }
local vimbuf = vim.lsp.buf
local keymap = vim.keymap

-- Maps
keymap.set('n', '<leader>rf', function ()
    require('telescope.builtin').lsp_references() end , opts)
keymap.set('n', '<leader>ca', function ()
    vimbuf.code_action() end , opts)
keymap.set('n', '<leader>rn', function ()
    vimbuf.rename() end , opts)
keymap.set('n', '<leader>gd', function ()
    vimbuf.definition() end , opts)
keymap.set('n', 'gD', function ()
    vimbuf.declaration() end , opts)
keymap.set('n', '<leader>gr', function ()
    vimbuf.references() end , opts)
keymap.set('n', '<leader>gi', function ()
    vimbuf.implementation() end , opts)
keymap.set('n', 'K', function ()
    vimbuf.hover() end , opts)
keymap.set('n', '<C-K>', function ()
    vimbuf.signature_help() end , opts)
keymap.set('n', '<C-p>', function ()
    vim.diagnostic.goto_prev() end , opts)
keymap.set('n', '<C-n>', function ()
    vim.diagnostic.goto_next() end , opts)
