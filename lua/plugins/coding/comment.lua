return {
  "numToStr/Comment.nvim",
  event = "VeryLazy",
  opts = {
    toggler = {
      line = "<leader>c/",
      block = "<leader>c?",
    },
    opleader = {
      line = "<leader>c/",
      block = "<leader>c?",
    },
  },
  config = function(_, opts)
    require("Comment").setup(opts)

    local function add_doc_comment(start_line, end_line)
      local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
      local new_lines = {}
      for _, line in ipairs(lines) do
        local indent = line:match("^(%s*)") or ""
        table.insert(new_lines, indent .. "/// " .. line:sub(#indent + 1))
      end
      vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, new_lines)
    end

    vim.keymap.set("n", "<leader>c'", function()
      local line = vim.fn.line(".")
      add_doc_comment(line, line)
    end, { desc = "Add doc comment (///)" })

    vim.keymap.set("v", "<leader>c'", function()
      local start_line = vim.fn.line("v")
      local end_line = vim.fn.line(".")
      if start_line > end_line then
        start_line, end_line = end_line, start_line
      end
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
      add_doc_comment(start_line, end_line)
    end, { desc = "Add doc comment (///)" })
  end,
}
