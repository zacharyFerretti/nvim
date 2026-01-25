return {
  "rickhowe/wrapwidth",
  ft = "markdown",
  config = function()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "markdown",
      callback = function()
        vim.cmd("Wrapwidth 100")
      end,
    })
    -- Apply to current buffer if it's already markdown
    if vim.bo.filetype == "markdown" then
      vim.cmd("Wrapwidth 100")
    end
  end,
}
