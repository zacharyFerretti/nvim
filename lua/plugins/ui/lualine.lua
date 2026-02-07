return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "echasnovski/mini.icons" },
  event = "VeryLazy",
  opts = {
    options = {
      theme = "iceberg",
      section_separators = { left = "\u{e0bc}", right = "\u{e0ba}" },
      component_separators = "",
      disabled_filetypes = {
        statusline = { "neo-tree", "Trouble", "qf", "help", "dashboard" },
      },
      show_filename_only = false,
    },
    sections = {
      lualine_c = {
        { "filename", path = 1 },
      },
      lualine_x = {},
    },
  },
}
