return {
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup()
    end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "mason.nvim" },
    config = function()
      -- Only install servers for languages enabled on this machine (see config.languages)
      require("mason-lspconfig").setup({
        ensure_installed = require("config.languages").lsp_servers(),
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = { "mason-lspconfig.nvim" },
    config = function()
      -- Enable servers for enabled languages only
      vim.lsp.enable(require("config.languages").lsp_servers())
      -- 2026-06-03: Disable lspconfig's jdtls to prevent duplicate instance (nvim-jdtls in ftplugin/java.lua manages it)
      vim.lsp.enable("jdtls", false)

      -- Keybindings on LSP attach
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local buf = args.buf
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = buf, desc = "Go to Definition" })
          vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = buf, desc = "Hover Documentation" })
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = buf, desc = "Code Action" })
          -- vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = buf, desc = "Rename Symbol" })
          vim.keymap.set("n", "<leader>cn", vim.lsp.buf.rename, { buffer = buf, desc = "Rename Symbol" })
          vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = buf, desc = "Find References" })
          -- vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { buffer = buf, desc = "Line Diagnostics" })
          vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float, { buffer = buf, desc = "Line Diagnostics" })
          vim.keymap.set("n", "<leader>cg", vim.lsp.buf.definition, { buffer = buf, desc = "Go to Definition" })
          vim.keymap.set("n", "<leader>cu", function()
            require("telescope.builtin").lsp_references({
              include_declaration = false,
            })
          end, { buffer = buf, desc = "Usages" })
        end,
      })

      -- Lua-specific config for Neovim globals
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = { library = vim.api.nvim_get_runtime_file("", true) },
          },
        },
      })
    end,
  },
}
