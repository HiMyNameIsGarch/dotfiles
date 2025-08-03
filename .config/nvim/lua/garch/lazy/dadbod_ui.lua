return {
  "kristijanhusak/vim-dadbod-ui",
  dependencies = {
    "tpope/vim-dadbod"
  },
  cmd = { "DBUI", "DBUIToggle" },
  keys = {
      { "<leader>db", "<cmd>DBUIToggle<CR>",            desc = "DB: Toggle UI" },
      { "<leader>dl", "<cmd>DBUIHideNotifications<CR>", desc = "DB: Hide notifications" },
      { "<leader>di", "<cmd>DBUILastQueryInfo<CR>",     desc = "DB: Last query info" },
  },
  config = function()
    vim.g.db_ui_use_nerd_fonts = 1
    vim.g.db_ui_save_location = "~/.config/nvim/db_ui_queries"
  end,
}

