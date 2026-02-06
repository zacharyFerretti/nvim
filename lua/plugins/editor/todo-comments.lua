return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  event = "VeryLazy",
  opts = {},
  keys = {
    { "<leader>ft", "<cmd>TodoTelescope<CR>", desc = "TODOs" },
  },
}
