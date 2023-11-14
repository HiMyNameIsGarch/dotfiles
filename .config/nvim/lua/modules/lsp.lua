local nnoremap = require("keymap").nnoremap

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

local nproc = string.gsub(vim.fn.system('nproc'), "\n", "")
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
lspconfig.tsserver.setup(config())
lspconfig.vimls.setup(config())
lspconfig.bashls.setup(config())
lspconfig.pyright.setup(config())
lspconfig.dartls.setup(config())
lspconfig.cssls.setup(config())
lspconfig.tailwindcss.setup(config())
lspconfig.html.setup(config())

-- Vuejs
local util = require 'lspconfig.util'
local function get_typescript_server_path(root_dir)

  local global_ts = '/home/garch/.local/share/npm/lib/node_modules/typescript/lib'
  -- Alternative location if installed as root:
  -- local global_ts = '/usr/local/lib/node_modules/typescript/lib'
  local found_ts = ''
  local function check_dir(path)
    found_ts =  util.path.join(path, 'node_modules', 'typescript', 'lib')
    if util.path.exists(found_ts) then
      return path
    end
  end
  if util.search_ancestors(root_dir, check_dir) then
    return found_ts
  else
    return global_ts
  end
end

lspconfig.volar.setup(config({
    filetypes = {'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json'},
  on_new_config = function(new_config, new_root_dir)
    new_config.init_options.typescript.tsdk = get_typescript_server_path(new_root_dir)
  end,
}))

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

-- OmniSharp
-- local omnisharp_bin = "/home/himynameisgarch/.local/share/nvim/omnisharp/run"
-- lspconfig.omnisharp.setup(config({
--     root_dir = function()
--         return vim.loop.cwd()
--     end,
--     cmd = { omnisharp_bin, "--languageserver", "hostPID", tostring(vim.fn.getpid()) },
--     handlers = {
--         ["textDocument/definition"] = require('omnisharp_extended').handler,
--     },
-- }))
local omnisharp_path = "/usr/lib/omnisharp-roslyn/OmniSharp.dll"
lspconfig.omnisharp.setup(config({
    handlers = {
        ["textDocument/definition"] = require('omnisharp_extended').handler,
    },
    cmd = { "dotnet", omnisharp_path},
    -- Enables support for reading code style, naming convention and analyzer
    -- settings from .editorconfig.
    enable_editorconfig_support = true,

    -- If true, MSBuild project system will only load projects for files that
    -- were opened in the editor. This setting is useful for big C# codebases
    -- and allows for faster initialization of code navigation features only
    -- for projects that are relevant to code that is being edited. With this
    -- setting enabled OmniSharp may load fewer projects and may thus display
    -- incomplete reference lists for symbols.
    enable_ms_build_load_projects_on_demand = false,

    -- Enables support for roslyn analyzers, code fixes and rulesets.
    enable_roslyn_analyzers = false,

    -- Specifies whether 'using' directives should be grouped and sorted during
    -- document formatting.
    organize_imports_on_format = false,

    -- Enables support for showing unimported types and unimported extension
    -- methods in completion lists. When committed, the appropriate using
    -- directive will be added at the top of the current file. This option can
    -- have a negative impact on initial completion responsiveness,
    -- particularly for the first few completion sessions after opening a
    -- solution.
    enable_import_completion = false,

    -- Specifies whether to include preview versions of the .NET SDK when
    -- determining which version to use for project loading.
    sdk_include_prereleases = true,

    -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
    -- true
    analyze_open_documents_only = false,
}))
