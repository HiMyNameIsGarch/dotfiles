return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "<leader>ha", function() require("harpoon"):list():append() end, desc = "Harpoon Add" },
    { "<leader>hm", function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end, desc = "Harpoon Menu" },
    { "<leader>h1", function() require("harpoon"):list():select(1) end },
    { "<leader>h2", function() require("harpoon"):list():select(2) end },
    { "<leader>h3", function() require("harpoon"):list():select(3) end },
  },
  config = function()
    require("harpoon"):setup()
  end,
}

