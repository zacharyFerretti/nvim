return {
  "stevearc/conform.nvim",
  config = function()
    require("conform").setup({
      -- Only formatters for languages enabled on this machine (see config.languages)
      formatters_by_ft = require("config.languages").formatters_by_ft(),
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
