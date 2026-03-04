return {
  "stevearc/conform.nvim",
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        css = { "prettier" },
        html = { "prettier" },
        java = { "google-java-format" },
        json = { "prettier" },
        kotlin = { "ktlint" },
        lua = { "stylua" },
        markdown = { "prettier" },
        python = { "black" },
        rust = { "rustfmt" },
        sql = { "sql_formatter" },
      },
      formatters = {
        ["google-java-format"] = {
          prepend_args = { "--aosp" },
        },
        ktlint = {
          timeout_ms = 10000,
        },
        sql_formatter = {
          command = "sql-formatter",
        },
      },
    })
  end,
}
