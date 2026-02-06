return {
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    event = "VeryLazy",
    keys = {
      { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
      { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
      { "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", desc = "Delete Other Buffers" },
      { "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete Buffers to the Right" },
      { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete Buffers to the Left" },
      { "<S-h>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev Buffer" },
      { "<S-l>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next Buffer" },
      { "[b", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev Buffer" },
      { "]b", "<Cmd>BufferLineCycleNext<CR>", desc = "Next Buffer" },
      { "[B", "<Cmd>BufferLineMovePrev<CR>", desc = "Move Buffer Left" },
      { "]B", "<Cmd>BufferLineMoveNext<CR>", desc = "Move Buffer Right" },
    },
    opts = {
      options = {
        themable = true,
        close_command = function(n) vim.api.nvim_buf_delete(n, {}) end,
        right_mouse_command = function(n) vim.api.nvim_buf_delete(n, {}) end,
        diagnostics = "nvim_lsp",
        always_show_bufferline = false,
        diagnostics_indicator = function(_, _, diag)
          local icons = { Error = " ", Warn = " ", Hint = " ", Info = " " }
          local ret = (diag.error and icons.Error .. diag.error .. " " or "")
            .. (diag.warning and icons.Warn .. diag.warning or "")
          return vim.trim(ret)
        end,
        offsets = {
          {
            filetype = "neo-tree",
            text = "Neo-tree",
            highlight = "Directory",
            text_align = "left",
          },
        },
      },
    },
  },
}
