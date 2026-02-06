return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = { "rcarriga/nvim-notify" },
  opts = {
    cmdline = {
      view = "cmdline_popup",
    },
    presets = {
      command_palette = true,
    },
  },
}
