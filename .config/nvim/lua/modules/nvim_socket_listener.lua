-- neovim_socket_listener.lua
vim.notify = require("notify")
local notify = vim.notify

-- Log file path
local log_file = "/tmp/neovim_socket_listener.log"

-- Function to log messages
local function log_message(msg)
    local log_entry = os.date("%Y-%m-%d %H:%M:%S") .. ": " .. msg .. "\n"
    local file = io.open(log_file, "a")
    if file then
        file:write(log_entry)
        file:close()
    else
        notify("Failed to write to log file.", "error", { title = "LOG Notification" })
    end
end

-- Function to handle incoming messages
local function on_message(job_id, data, event)
    log_message("Event: " .. event)  -- Log the event type
    if data then
        for _, msg in ipairs(data) do
            if msg ~= "" then
                log_message("Received data: " .. msg)  -- Log the received data

                -- Broadcast the notification to all buffers with *.m files
                vim.api.nvim_exec_autocmds("User", { pattern = "SocatNotification", data = msg })
            else
                log_message("Received empty data.")
            end
        end
    end
    if event == "exit" then
        log_message("Socket listener stopped with exit code: " .. (data[1] or "unknown"))
        notify("Socket listener stopped.", "error", { title = "SOCKET Notification" })
    end
end

local socket_port = 12345

-- Function to check if socat is already running
local function is_socat_running()
    local lsof_cmd = "lsof -i :" .. socket_port
    local handle = io.popen(lsof_cmd)
    if not handle then
        return false
    end
    local result = handle:read("*a")
    handle:close()
    return result ~= ""
end

-- vars to store the job ID and autocmd ID
local socat_job_id = nil
local socat_autocmd_id = nil

-- Function to start the socat listener
local function start_socat_listener()
    if is_socat_running() then
        log_message("socat is already running on port " .. socket_port .. ". Attaching to existing listener.")
        notify("socat is already running on port " .. socket_port .. ". Attaching to existing listener.", "warn", { title = "SOCAT Notification" })
        return
    end

    local socket_cmd = "socat -u TCP-LISTEN:" .. socket_port .. ",fork STDOUT"
    socat_job_id = vim.fn.jobstart(socket_cmd, {
        stdout_buffered = false, -- TRIVIAL setting
        stderr_buffered = false, -- TRIVIAL setting
        on_stdout = on_message,
        on_stderr = on_message,
        on_exit = on_message,
    })

    if socat_job_id <= 0 then
        log_message("Failed to start socket listener. Job ID: " .. socat_job_id)
        notify("Failed to start socket listener.", "error", { title = "SOCAT Notification" })
    else
        log_message("Socket listener started on port " .. socket_port .. ". Job ID: " .. socat_job_id)
        notify("Socket listener started on port " .. socket_port, "info", { title = "SOCAT Notification" })
    end
end

-- Function to stop the socat listener
local function stop_socat_listener()
    if socat_job_id and vim.fn.jobstop(socat_job_id) == 1 then
        log_message("Socket listener stopped. Job ID: " .. socat_job_id)
        notify("Socket listener stopped.", "info", { title = "SOCAT Notification" })
        socat_job_id = nil
    else
        log_message("No active socket listener to stop.")
        notify("No active socket listener to stop.", "warn", { title = "SOCAT Notification" })
    end
end

-- Autocmd to handle notifications
vim.api.nvim_create_autocmd("User", {
    pattern = "SocatNotification",
    callback = function(args)
        local msg = args.data
        notify(msg, "info", { title = "MATLAB Notification" })
    end,
})

-- Command to start the listener and set up the autocmd
vim.api.nvim_create_user_command("StartSocatListener", function()
    -- Create the autocmd to start the listener when a *.m file is opened
    socat_autocmd_id = vim.api.nvim_create_autocmd("BufRead", {
        pattern = "*.m",
        callback = function()
            start_socat_listener()
        end,
    })

    -- Start the listener immediately if a *.m file is already open
    local bufs = vim.api.nvim_list_bufs()
    for _, buf in ipairs(bufs) do
        local buf_name = vim.api.nvim_buf_get_name(buf)
        if buf_name:match("%.m$") then
            start_socat_listener()
            break
        end
    end
end, {})

-- Command to stop the listener and remove the autocmd
vim.api.nvim_create_user_command("StopSocatListener", function()
    -- Stop the listener
    stop_socat_listener()

    -- Remove the autocmd if it exists
    if socat_autocmd_id then
        vim.api.nvim_del_autocmd(socat_autocmd_id)
        socat_autocmd_id = nil
        log_message("Autocmd removed.")
        notify("Autocmd removed.", "info", { title = "Neovim Notification" })
    else
        log_message("No autocmd to remove.")
        notify("No autocmd to remove.", "warn", { title = "Neovim Notification" })
    end
end, {})
