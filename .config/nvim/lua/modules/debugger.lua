-- Mappings
local map = function(lhs, rhs)
    vim.keymap.set("n", lhs, rhs, { silent = true })
end

map("<leader>bp", require("dap").toggle_breakpoint)
map("<F5>", require("dap").step_into)
map("<F6>", require("dap").step_over)
map("<F7>", require("dap").step_back)
map("<F8>", require("dap").continue)

-- DAP
local dap = require("dap")

dap.adapters.coreclr = {
  type = 'executable',
  command = 'netcoredbg',
  args = { '--interpreter=vscode' }
}

function GetDotnetExec()
    local cwd = vim.fn.getcwd()
    local relPath = vim.split(cwd, "/", true)
    local proj = relPath[#relPath] or "Changeme"
    return cwd .. '/bin/Debug/net6.0/' .. proj .. '.dll'
end

dap.configurations.cs = {
  {
    type = "coreclr",
    name = "launch - netcoredbg",
    request = "launch",
    program = GetDotnetExec
  },
  {
      type = "coreclr",
      name = "attach - coreclr",
      request = "attach",
      processId = function()
          local pid = require('dap.utils').pick_process()
          vim.fn.setenv('NETCOREDBG_ATTACH_PID', pid)
          return pid
      end,
  },
}

-- DAP-UI
require("dapui").setup()
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
