return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  lazy = false,
  config = function()
    local ts_runtime = require("nvim-treesitter.install").get_package_path("runtime")
    vim.opt.rtp:prepend(ts_runtime)

    require("nvim-treesitter.install").install({
      "bash",
      "css",
      "html",
      "java",
      "javascript",
      "json",
      "lua",
      "markdown",
      "markdown_inline",
      "python",
      "rust",
      "typescript",
      "vim",
      "vimdoc",
    })

    -- Start treesitter highlighting on every buffer with a parser
    vim.api.nvim_create_autocmd("FileType", {
      callback = function(args)
        local lang = vim.treesitter.language.get_lang(args.match)
        if lang and pcall(vim.treesitter.language.inspect, lang) then
          vim.treesitter.start(args.buf, lang)
        end
      end,
    })
  end,
}
