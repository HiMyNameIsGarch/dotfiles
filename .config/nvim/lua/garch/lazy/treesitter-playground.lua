return {
  "nvim-treesitter/playground",
  cmd = { "TSPlaygroundToggle", "TSHighlightCapturesUnderCursor" },
  config = function()
    -- Optional: no config needed, but you can set up options here
    vim.keymap.set("n", "<leader>tp", "<cmd>TSPlaygroundToggle<CR>", { desc = "Toggle Treesitter Playground" })
  end,
}
