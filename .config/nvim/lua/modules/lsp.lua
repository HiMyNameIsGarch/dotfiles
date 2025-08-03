local nnoremap = require("keymap").nnoremap

--------------------------------< notify setup >--------------------------------

-- local notify = require("notify")
-- local lsp_spinner = require("modules.lsp_spinner")
--
-- vim.api.nvim_create_autocmd("LspAttach", {
--   callback = function(args)
--     local client = vim.lsp.get_client_by_id(args.data.client_id)
--     if client then
--       notify(string.format("LSP '%s' attached!", client.name), "info", { title = "LSP" })
--       lsp_spinner.start(client.id)
--     end
--   end,
-- })
--
-- vim.api.nvim_create_autocmd("DiagnosticChanged", {
--   callback = function(args)
--     local bufnr = args.buf
--     local clients = vim.lsp.get_clients({ bufnr = bufnr })
--     for _, client in ipairs(clients) do
--       notify(string.format("LSP '%s' started and ready to use!", client.name), "info", { title = "LSP" })
--       lsp_spinner.stop(client.id)
--     end
--   end,
-- })
--
-- vim.api.nvim_create_autocmd("LspDetach", {
--   callback = function(args)
--     local client = vim.lsp.get_client_by_id(args.data.client_id)
--     if not client then return end
--
--     -- Check if client is still attached to any buffer
--     local still_attached = false
--     for _, buf in ipairs(vim.api.nvim_list_bufs()) do
--       if #vim.lsp.get_clients({ bufnr = buf }) > 0 then
--         still_attached = true
--         break
--       end
--     end
--
--     if not still_attached then
--       lsp_spinner.stop(client.id)
--       notify(string.format("LSP '%s' disconnected", client.name), "warn", { title = "LSP" })
--     end
--   end,
-- })

local function config(_config)
    return vim.tbl_deep_extend("force", {
        on_attach = function()

            nnoremap('<leader>rf', require('telescope.builtin').lsp_references)
            nnoremap('<leader>ca', vim.lsp.buf.code_action)
            nnoremap('<leader>rn', vim.lsp.buf.rename)
            nnoremap('<leader>gd', vim.lsp.buf.definition)
            nnoremap('<leader>gr', vim.lsp.buf.references)
            nnoremap('<leader>gi', vim.lsp.buf.implementation)
            nnoremap('<C-K>', vim.lsp.buf.signature_help)
            nnoremap('<C-p>', vim.diagnostic.goto_prev)
            nnoremap('<C-n>', vim.diagnostic.goto_next)
            nnoremap('gD', vim.lsp.buf.declaration)
            nnoremap('K', vim.lsp.buf.hover)
        end,
    }, _config or {})
end

local lspconfig = require("lspconfig")


-- matlab lsp ( a hell of a job to install this thing )
require'lspconfig'.matlab_ls.setup{}

-- SQL
require'lspconfig'.sqls.setup{
  on_attach = function(client, bufnr)
    require('sqls').on_attach(client, bufnr) -- require sqls.nvim
  end,
  settings = {
    sqls = {
      connections = {
        {
          driver = 'mssql',
          -- dataSourceName = 'sqlserver://sa:StrongPassword123%23@localhost:1433/EF_WebApiDB',
          dataSourceName = 'sqlserver://sa:StrongPassword123%23@localhost:1433?database=EF_WebApiDB&connection+timeout=30'
        },
      },
    },
  },
}

local nproc = string.gsub(vim.fn.system('nproc'), "\n", "")
-- local unamer = string.gsub(vim.fn.system("uname -r"), "\n", "")
lspconfig.clangd.setup(config({
    cmd = {
        "clangd",
        "--header-insertion=never",
        "-j", nproc,
        "--background-index",
        "--enable-config"
    },
    filetypes = {"c", "cpp", "objc", "objcpp"}, }))

-- lspconfig.ccls.setup(config( {
--     single_file_support= true
-- }))
lspconfig.java_language_server.setup{
    cmd = { '/home/garch/Dev/java-language-server/dist/lang_server_linux.sh'},
    root_dir = lspconfig.util.root_pattern('.git'),
}
lspconfig.ts_ls.setup(config())
lspconfig.vimls.setup(config())
lspconfig.bashls.setup(config())
lspconfig.pyright.setup(config({
    settings = {
        python = {
            analisys = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "workspace",
                strict = true,
                typeCheckingMode = "strict",
            },
        }
    }
}))
lspconfig.dartls.setup(config())
lspconfig.cssls.setup(config())
lspconfig.tailwindcss.setup(config())
lspconfig.html.setup(config())

-- Vuejs ( no more vue js for now ( conflicting with typescript ) )
-- local util = require 'lspconfig.util'
-- local function get_typescript_server_path(root_dir)
--
--   local global_ts = '/home/garch/.local/share/npm/lib/node_modules/typescript/lib'
--   -- Alternative location if installed as root:
--   -- local global_ts = '/usr/local/lib/node_modules/typescript/lib'
--   local found_ts = ''
--   local function check_dir(path)
--     found_ts =  util.path.join(path, 'node_modules', 'typescript', 'lib')
--     if util.path.exists(found_ts) then
--       return path
--     end
--   end
--   if util.search_ancestors(root_dir, check_dir) then
--     return found_ts
--   else
--     return global_ts
--   end
-- end

-- comment out the volar setup
-- lspconfig.volar.setup(config({
--     filetypes = {'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json'},
--   on_new_config = function(new_config, new_root_dir)
--     new_config.init_options.typescript.tsdk = get_typescript_server_path(new_root_dir)
--   end,
-- }))

-- Lua
lspconfig.lua_ls.setup(config({
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

require('lspconfig').csharp_ls.setup(config({
    cmd = { "csharp-ls" },
    filetypes = { "cs" },
    root_dir = require('lspconfig').util.root_pattern("*.sln", "*.csproj", ".git")
}))


