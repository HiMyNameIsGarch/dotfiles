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

return {
  "mfussenegger/nvim-dap",
  dependencies = { "nvim-neotest/nvim-nio" },
  event = "VeryLazy",
  config = function()
    local dap = require("dap")
        dap.adapters.coreclr = {
            type = 'executable',
            command = 'netcoredbg',
            args = { '--interpreter=vscode' }
        }
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

    vim.keymap.set('n', '<F8>', dap.continue, { desc = "DAP: Continue" })
    vim.keymap.set('n', '<F10>', dap.step_over, { desc = "DAP: Step over" })
    vim.keymap.set('n', '<F11>', dap.step_into, { desc = "DAP: Step into" })
    vim.keymap.set('n', '<Leader>bp', dap.toggle_breakpoint, { desc = "DAP: Toggle breakpoint" })
    vim.keymap.set('n', '<Leader>B', function()
      dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
    end, { desc = "DAP: Conditional breakpoint" })
  end,
}

