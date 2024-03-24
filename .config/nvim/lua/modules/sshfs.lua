-- Init the plugin and do the config file
-- repair config, it does not work properly
require('remote-sshfs').setup({
  connections = {
    ssh_configs = { -- which ssh configs to parse for hosts list
      vim.fn.expand "$HOME" .. "/.ssh/config",
      "/etc/ssh/ssh_config",
      -- "/path/to/custom/ssh_config"
    },
    sshfs_args = { -- arguments to pass to the sshfs command
      "-o reconnect",
      "-o ConnectTimeout=5",
    },
  },
  mounts = {
    base_dir = vim.fn.expand "$HOME" .. "/.cache/sshfs", -- base directory for mount points
    unmount_on_exit = true, -- run sshfs as foreground, will unmount on vim exit
  },
  handlers = {
    on_connect = {
      change_dir = true, -- when connected change vim working directory to mount point
    },
    on_disconnect = {
      clean_mount_folders = false, -- remove mount point folder on disconnect/unmount
    },
    on_edit = {}, -- not yet implemented
  },
  ui = {
    select_prompts = false, -- not yet implemented
    confirm = {
      connect = false, -- prompt y/n when host is selected to connect to
      change_dir = false, -- prompt y/n to change working directory on connection (only applicable if handlers.on_connect.change_dir is enabled)
    },
  },
  log = {
    enable = false, -- enable logging
    truncate = false, -- truncate logs
    types = { -- enabled log types
      all = false,
      util = false,
      handler = false,
      sshfs = false,
    },
  },
})
require('telescope').load_extension 'remote-sshfs'

-- Keymaps using custom map function
local bind = require("keymap").bind
local map = bind('n', {noremap = true, silent = true})

local api = require('remote-sshfs.api')
map('<leader>rc', api.connect)
map('<leader>rd', api.disconnect)
map('<leader>re', api.edit)

-- (optional) Override telescope find_files and live_grep to make dynamic based on if connected to host
local builtin = require("telescope.builtin")
local connections = require("remote-sshfs.connections")

-- Should I move this into telescope config or not? tell me in the comment section below pls
-- map("<leader>ff", function()
--  if connections.is_connected then
--   api.find_files({})
--  else
--   builtin.find_files({})
--  end
-- end, {})

map("<leader>lg", function()
 if connections.is_connected then
  api.live_grep()
 else
  builtin.live_grep()
 end
end, {})
