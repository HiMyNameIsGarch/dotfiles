return {
  "rose-pine/neovim",
  name = "rose-pine",
  priority = 1000,
  lazy = false,
  config = function()
    require("rose-pine").setup({
      variant = "main",
      dark_variant = "main",
      bold_vert_split = false,
      dim_nc_background = false,
      disable_background = true,
      disable_float_background = true,
      disable_italics = false,

      groups = {
        background = "base",
        background_nc = "_experimental_nc",
        panel = "surface",
        panel_nc = "base",
        border = "highlight_med",
        comment = "muted",
        link = "iris",
        punctuation = "subtle",

        error = "love",
        hint = "iris",
        info = "foam",
        warn = "gold",

        headings = {
          h1 = "iris",
          h2 = "foam",
          h3 = "rose",
          h4 = "gold",
          h5 = "pine",
          h6 = "foam",
        },
      },

      highlight_groups = {
        ColorColumn = { bg = "pine" },
        CursorLine = { bg = "foam", blend = 20 },
        StatusLine = { fg = "love", bg = "love", blend = 10 },
        Search = { bg = "gold", inherit = false },
      },
    })

    -- Set colorscheme after setup
    vim.cmd("colorscheme rose-pine")
    vim.cmd([[highlight NotifyBackground guibg=#000000]])
    vim.cmd('hi Normal guibg=NONE ctermbg=NONE')
    vim.cmd('hi Winseparator guibg=None')
  end,
}
