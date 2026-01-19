return {
  "stevearc/conform.nvim",
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        lua = { "stylua" },
      },
    })
    vim.keymap.set("n", "<leader>o", function()
      require("conform").format()
    end)
  end,
}
