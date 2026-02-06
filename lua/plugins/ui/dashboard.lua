return {
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  dependencies = { "echasnovski/mini.icons" },
  opts = {
    theme = "hyper",
    config = {
      week_header = { enable = true },
      shortcut = {
        { desc = " Files", group = "Label", action = "Telescope find_files", key = "f" },
        { desc = " Recent", group = "Number", action = "Telescope oldfiles", key = "r" },
        { desc = " Grep", group = "String", action = "Telescope live_grep", key = "g" },
        { desc = "󰒲 Lazy", group = "Special", action = "Lazy", key = "l" },
      },
    },
  },
}
