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

function GetProjName()
    local relPath = vim.split(vim.fn.getcwd(), "/", true)
    return relPath[#relPath] or "NotFound"
end

function GetPID()
    local cmd = { "pidof", GetProjName() }
    local pid = vim.fn.system(cmd)
    -- make sure to return the first one found
    return vim.split(pid, " ", true)[1]
end

dap.configurations.cs = {
  {
    type = "coreclr",
    name = "launch - netcoredbg",
    request = "launch",
    args = { "status" },
    program = function()
        return vim.fn.getcwd() .. '/bin/Debug/net6.0/' .. GetProjName() .. '.dll'
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

-- DAP-UI
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
