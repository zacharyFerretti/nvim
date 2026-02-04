return {
  {
    "zacharyFerretti/nvim-invert",
    opts = {
      keymap = "<leader>ut",
      persist = true,
    },
    config = function(_, opts)
      require("invert").setup(opts)
    end,
  },
}
