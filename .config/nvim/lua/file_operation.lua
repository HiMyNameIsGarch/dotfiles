local M = {}

local function Read_buf_from_file(path)
    local file = io.open(path, "r")
    if not file then return nil end
    local content = file:read "*a"
    file:close()
    return tonumber(content)
end

local function Write_buf_to_file(path, buf)
    local file = io.open(path, "w+")
    if not file then return nil end
    file:write(buf)
    file:close()
end

local function WriteToBuf(path_to_buf, buf, data)
    if data then
        vim.api.nvim_buf_set_lines(buf, 0, 0, false, data)
        Write_buf_to_file(path_to_buf, buf)
    end
end

M.WriteToBuf = WriteToBuf
M.Read_buf_from_file = Read_buf_from_file

return M
