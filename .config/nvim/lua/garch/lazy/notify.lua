return {
  "rcarriga/nvim-notify",
  lazy = false,
  config = function()
    vim.notify = require("notify")
    require("notify").setup({
      stages = "fade",
      timeout = 2000,
      background_colour = "#000000",
    })
  end,
}

