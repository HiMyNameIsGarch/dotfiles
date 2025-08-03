local M = {}

local spinner_frames = { "🌕", "🌖", "🌗", "🌘", "🌑", "🌒", "🌓", "🌔" }
local frame_index = 1
local lsp_loading_clients = {}

-- Setup timer for animation
local timer = vim.uv.new_timer()
timer:start(0, 120, vim.schedule_wrap(function()
  frame_index = (frame_index % #spinner_frames) + 1
end))

-- Called by LspAttach
function M.start(client_id)
  lsp_loading_clients[client_id] = true
end

-- Called by DiagnosticChanged
function M.stop(client_id)
  lsp_loading_clients[client_id] = nil
end

-- Lualine component
function M.status()
  local active = false
  for _, _ in pairs(lsp_loading_clients) do
    active = true
    break
  end
  if active then
    return "LSP " .. spinner_frames[frame_index]
  else
    return ""
  end
end

return M
