-- Mappings
local nnoremap = require("keymap").nnoremap
local silent = { silent = true }

nnoremap("<leader>bp", require("dap").toggle_breakpoint, silent)
nnoremap("<leader><F5>", require("dap").step_into, silent)
nnoremap("<leader><F6>", require("dap").step_over, silent)
nnoremap("<leader><F7>", require("dap").step_back, silent)
nnoremap("<F8>", require("dap").continue, silent)

-- DAP
local dap = require("dap")

-----------------------------------< Csharp >-----------------------------------

dap.adapters.coreclr = {
  type = 'executable',
  command = 'netcoredbg',
  args = { '--interpreter=vscode' }
}

function GetProjName()
    local relPath = vim.split(vim.fn.getcwd(), "/", {plain=true})
    return relPath[#relPath] or "NotFound"
end

function GetPID()
    local cmd = { "pidof", GetProjName() }
    local pid = vim.fn.system(cmd)
    -- make sure to return the first one found
    return vim.split(pid, " ", {plain=true})[1]
end

dap.configurations.cs = {
  {
    type = "coreclr",
    name = "launch - netcoredbg",
    request = "launch",
    args = { "status" },
    program = function()
        return vim.fn.getcwd() .. '/bin/Debug/net8.0/' .. GetProjName() .. '.dll'
    end
  },
  {
      type = "coreclr",
      name = "attach - coreclr",
      request = "attach",
      processId = function()
          local pid = GetPID()
          vim.fn.setenv('NETCOREDBG_ATTACH_PID', pid)
          return pid
      end,
  },
}

----------------------------------< CPlusPlus >---------------------------------
-- dap.adapters.codelldb = {
--   type = 'server',
--   port = "${port}",
--   executable = {
--     -- CHANGE THIS to your path!
--     command = '/usr/bin/codelldb',
--     args = {"--port", "${port}"},
--   }
-- }

dap.adapters.gdb = {
  type = "executable",
  command = "gdb",
  args = { "-i", "dap" }
}

dap.configurations.c = {
    {
        name = "Launch",
        type = "gdb",
        request = "launch",
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = "${workspaceFolder}",
        stopAtBeginningOfMainSubprogram = false,
    },
}

dap.configurations.cpp = {
    {
        name = "Launch file",
        type = "gdb",
        request = "launch",
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
    },

}

-----------------------------------< Python >-----------------------------------
require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')


-----------------------------------< DAP-UI >-----------------------------------
require("dapui").setup({
    layouts = {
        {
            -- You can change the order of elements in the sidebar
            elements = {
                -- Provide as ID strings or tables with "id" and "size" keys
                { id = "scopes", size = 0.33 }, -- Can be float or integer > 1 },
                { id = "watches", size = 0.34 },
                { id = "breakpoints", size = 0.33 },
            },
            size = 40,
            position = "left", -- Can be "left", "right", "top", "bottom"
        },
        {
            elements = { "repl" },
            size = 10,
            position = "bottom", -- Can be "left", "right", "top", "bottom"
        },
    },
})
local dapui = require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end
