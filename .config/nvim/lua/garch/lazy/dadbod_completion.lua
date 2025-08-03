return {
  "kristijanhusak/vim-dadbod-completion",
  ft = { "sql", "mysql", "plsql" },
  config = function()
    vim.g.db_completion_enable = 1
  end,
}

