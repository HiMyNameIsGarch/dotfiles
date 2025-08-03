return {
  "tpope/vim-fugitive",
  cmd = { "Git", "G" },
  keys = {
    { "<leader>gs", "<cmd>Git<CR>", desc = "Fugitive: Git status" },
    { "<leader>gf", "<cmd>diffget //3<CR>", desc = "Fugitive: Accept theirs" },
    { "<leader>gj", "<cmd>diffget //2<CR>", desc = "Fugitive: Accept ours" },
  },
}
