return {
  "rickhowe/wrapwidth",
  ft = "markdown",
  config = function()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "markdown",
      callback = function()
	-- Ensures that we don't break words in half.
        vim.opt_local.linebreak = true
        vim.opt_local.breakindent = true
        vim.cmd("Wrapwidth 100")
      end,
    })
    -- Apply to current buffer if it's already markdown
    if vim.bo.filetype == "markdown" then
      vim.opt_local.linebreak = true
      vim.opt_local.breakindent = true
      vim.cmd("Wrapwidth 100")
    end
  end,
}
