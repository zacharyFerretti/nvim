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
        sh = { "shfmt" },
        sql = { "sql_formatter" },
      },
      formatters = {
        shfmt = {
          prepend_args = { "-i", "4" },
        },
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
