return {
  "folke/trouble.nvim",
  dependencies = { "echasnovski/mini.icons" },
  event = "VeryLazy",
  opts = {},
  keys = {
    { "<leader>cx", "<cmd>Trouble diagnostics toggle<CR>", desc = "Diagnostics" },
  },
}
