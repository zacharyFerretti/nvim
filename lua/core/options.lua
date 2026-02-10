-- Leader key (must be set before lazy.nvim loads)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Clear search highlight with Escape
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- System
vim.opt.clipboard = "unnamedplus"

-- UI
vim.opt.fillchars = { eob = " " }
vim.opt.number = true
vim.opt.relativenumber = true

-- Conceal level for Obsidian advanced syntax highlighting
vim.opt.conceallevel = 1

-- Session options for auto-session
vim.opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- Lua indent (match stylua 2-space default)
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'lua',
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.expandtab = true
  end,
})

-- Markdown folding via Treesitter
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  callback = function()
    vim.opt_local.foldmethod = 'expr'
    vim.opt_local.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    vim.opt_local.foldlevel = 99
  end,
})

-- Toggle transparent background (<leader>uo), off by default
vim.g.transparent_bg = false

local function set_transparent(enabled)
  if enabled then
    vim.api.nvim_set_hl(0, "Normal", { bg = "NONE", ctermbg = "NONE" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE", ctermbg = "NONE" })
    vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "NONE", ctermbg = "NONE" })
    vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "NONE", ctermbg = "NONE" })
  else
    -- Re-apply the colorscheme to restore original backgrounds
    vim.cmd.colorscheme(vim.g.colors_name)
  end
end

vim.keymap.set("n", "<leader>uo", function()
  vim.g.transparent_bg = not vim.g.transparent_bg
  set_transparent(vim.g.transparent_bg)
  vim.notify("Transparent background: " .. (vim.g.transparent_bg and "ON" or "OFF"))
end, { desc = "Toggle transparent background" })

-- Re-apply transparency after colorscheme changes (if enabled)
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    if vim.g.transparent_bg then
      set_transparent(true)
    end
  end,
})
