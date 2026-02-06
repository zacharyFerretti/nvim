return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  event = "VeryLazy",
  opts = {
    enabled = false,
    scope = { enabled = true },
    exclude = {
      filetypes = { "dashboard" },
    },
  },
  keys = {
    { "<leader>ui", "<cmd>IBLToggle<CR>", desc = "Indent Guides" },
  },
}
