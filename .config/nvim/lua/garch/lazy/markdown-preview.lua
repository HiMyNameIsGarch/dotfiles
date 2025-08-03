return {
  "iamcco/markdown-preview.nvim",
  ft = "markdown",
  build = "cd app && npm install",
  config = function()
    vim.g.mkdp_auto_start = 0
    vim.g.mkdp_auto_close = 1
    vim.g.mkdp_filetypes = { "markdown" }
  end,
}

