return {
  "stevearc/conform.nvim",
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        css = { "prettier" },
        html = { "prettier" },
        java = { "google-java-format" },
        json = { "prettier" },
        lua = { "stylua" },
        markdown = { "prettier" },
        python = { "black" },
        rust = { "rustfmt" },
        sql = { "sql_formatter" },
      },
      formatters = {
        sql_formatter = {
          command = "sql-formatter",
        },
      },
    })
  end,
}
