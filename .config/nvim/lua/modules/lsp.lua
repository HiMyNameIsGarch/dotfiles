local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local function config(_config)
    return vim.tbl_deep_extend("force", {
        capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities),
        on_attach = function()
            local map = function(lhs, rhs)
                vim.keymap.set("n", lhs, rhs, { noremap = true })
            end

            map('<leader>rf', require('telescope.builtin').lsp_references)
            map('<leader>ca', vim.lsp.buf.code_action)
            map('<leader>rn', vim.lsp.buf.rename)
            map('<leader>gd', vim.lsp.buf.definition)
            map('<leader>gr', vim.lsp.buf.references)
            map('<leader>gi', vim.lsp.buf.implementation)
            map('<C-K>', vim.lsp.buf.signature_help)
            map('<C-p>', vim.diagnostic.goto_prev)
            map('<C-n>', vim.diagnostic.goto_next)
            map('gD', vim.lsp.buf.declaration)
            map('K', vim.lsp.buf.hover)
        end,
    }, _config or {})
end

local lspconfig = require("lspconfig")
lspconfig.tsserver.setup(config())
lspconfig.vuels.setup(config())
lspconfig.vimls.setup(config())
lspconfig.bashls.setup(config())
lspconfig.pyright.setup(config())
lspconfig.dartls.setup(config())
lspconfig.cssls.setup(config())
lspconfig.html.setup(config())

-- Lua
lspconfig.sumneko_lua.setup(config({
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
}))

-- OmniSharp
local omnisharp_bin = "/home/himynameisgarch/.local/share/nvim/omnisharp/run"
lspconfig.omnisharp.setup(config({
    root_dir = function()
        return vim.loop.cwd()
    end,
    cmd = { omnisharp_bin, "--languageserver", "hostPID", tostring(vim.fn.getpid()) },
    handlers = {
        ["textDocument/definition"] = require('omnisharp_extended').handler,
    },
}))
