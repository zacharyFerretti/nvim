return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
  dependencies = { "nvim-mini/mini.icons" },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Local Keymaps",
    },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)

    wk.add({
      {
        "<leader>e",
        "<cmd>Neotree toggle reveal<CR>",
        desc = "File Explorer",
        icon = { icon = "", color = "blue" },
      },

      -- Buffer Sub Group (dynamic expansion shows all open buffers)
      {
        "<leader>b",
        group = "Buffer",
        icon = { icon = "", color = "cyan" },
        expand = function()
          return require("which-key.extras").expand.buf()
        end,
      },

      -- Window Sub Groups
      { "<leader>w", group = "Window", icon = { icon = "", color = "green" } },
      { "<leader>wh", "<C-w>h", desc = "Left", icon = { icon = "", color = "green" } },
      { "<leader>wl", "<C-w>l", desc = "Right", icon = { icon = "", color = "green" } },
      { "<leader>wj", "<C-w>j", desc = "Down", icon = { icon = "", color = "green" } },
      { "<leader>wk", "<C-w>k", desc = "Up", icon = { icon = "", color = "green" } },
      { "<leader>ws", "<cmd>split<CR>", desc = "Split horizontal", icon = { icon = "", color = "green" } },
      { "<leader>wv", "<cmd>vsplit<CR>", desc = "Split vertical", icon = { icon = "", color = "green" } },
      {
        "<leader>wx",
        function()
          local bufs = vim.tbl_filter(function(b)
            return vim.api.nvim_buf_is_loaded(b) and vim.bo[b].buflisted
          end, vim.api.nvim_list_bufs())
          if #bufs <= 1 then
            vim.cmd("Dashboard")
          else
            local buf = vim.api.nvim_get_current_buf()
            vim.cmd("BufferLineCyclePrev")
            vim.api.nvim_buf_delete(buf, {})
          end
        end,
        desc = "Close buffer",
        icon = { icon = "", color = "green" },
      },
      { "<leader>wd", "<cmd>close<CR>", desc = "Delete window", icon = { icon = "", color = "green" } },


      -- Telescope (Live Grep)
      { "<leader>/", "<cmd>Telescope live_grep<CR>", desc = "Live Grep", icon = { icon = "󰐰", color = "purple" } },

      -- Telescope (Other Options)
      { "<leader>f", group = "Find", icon = { icon = "", color = "purple" } },
      {
        "<leader>ff",
        "<cmd>Telescope find_files hidden=true<CR>",
        desc = "CWD Files",
        icon = { icon = "", color = "purple" },
      },
      {
        "<leader>fF",
        "<cmd>Telescope find_files cmd=~ hidden=true<CR>",
        desc = "All Files",
        icon = { icon = "", color = "purple" },
      },
      { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Buffers", icon = { icon = "", color = "purple" } },
      { "<leader>fr", "<cmd>Telescope oldfiles<CR>", desc = "Recent Files", icon = { icon = "", color = "purple" } },
      { "<leader>fg", "<cmd>Telescope git_files<CR>", desc = "Git Files", icon = { icon = "", color = "purple" } },
      {
        "<leader>fw",
        "<cmd>Telescope grep_string<CR>",
        desc = "Word Under Cursor",
        icon = { icon = "", color = "purple" },
      },
      -- Super Commands
      { "<leader><Space>", group = "Super", icon = { icon = "", color = "red" } },
      {
        "<leader><Space>o",
        "<cmd>Telescope find_files hidden=true<CR>",
        desc = "Find Files",
        icon = { icon = "", color = "red" },
      },
      { "<leader><Space><Enter>", vim.lsp.buf.code_action, desc = "Code Action", icon = { icon = "", color = "red" } },
      {
        "<leader><Space>m",
        function()
          require("conform").format()
        end,
        desc = "Format File",
        icon = { icon = "", color = "red" },
      },
      {
        "<leader>uT",
        "<cmd>Themify<CR>",
        desc = "Color Scheme Selection",
        icon = { icon = "", color = "yellow" },
      },
      { "<leader>m", group = "Markdown" },
      { "<leader>u", group = "UI" },
      { "<leader>c", group = "Code" },
    })
  end,
}
