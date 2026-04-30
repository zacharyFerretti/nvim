-- Leader key (must be set before lazy.nvim loads)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Lower timeout so which-key popup triggers reliably
vim.opt.timeoutlen = 300

-- Clear search highlight with Escape
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- System
vim.opt.clipboard = "unnamedplus"

-- UI
vim.opt.fillchars = { eob = " " }
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true

-- Conceal level for Obsidian advanced syntax highlighting
vim.opt.conceallevel = 1

-- Folding (nvim-ufo takes over foldmethod/foldexpr)
vim.opt.foldcolumn = '1'
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true

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

-- Shell indent (disable Treesitter indentexpr — bash parser over-indents)
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'sh', 'bash', 'zsh' },
  callback = function()
    vim.opt_local.indentexpr = ''
  end,
})

-- Java indent (match AOSP 4-space style)
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'java',
  callback = function()
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
    vim.opt_local.expandtab = true
  end,
})

-- Toggle transparent background (<leader>uo), persisted via ShaDa

local function set_transparent(enabled)
  if enabled then
    local none = { bg = "NONE", ctermbg = "NONE" }
    vim.api.nvim_set_hl(0, "Normal", none)
    vim.api.nvim_set_hl(0, "NormalNC", none)
    vim.api.nvim_set_hl(0, "NormalFloat", none)
    vim.api.nvim_set_hl(0, "SignColumn", none)
    vim.api.nvim_set_hl(0, "EndOfBuffer", none)
    vim.api.nvim_set_hl(0, "NeoTreeNormal", none)
    vim.api.nvim_set_hl(0, "NeoTreeNormalNC", none)
    vim.api.nvim_set_hl(0, "NeoTreeEndOfBuffer", none)
    vim.api.nvim_set_hl(0, "NeoTreeWinSeparator", none)
  else
    vim.cmd.colorscheme(vim.g.colors_name)
  end
end

-- Restore persisted transparency after ShaDa is loaded
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.g.TRANSPARENT_BG then
      set_transparent(true)
    end
  end,
})

vim.keymap.set("n", "<leader>uo", function()
  vim.g.TRANSPARENT_BG = not vim.g.TRANSPARENT_BG
  set_transparent(vim.g.TRANSPARENT_BG)
  vim.notify("Transparent background: " .. (vim.g.TRANSPARENT_BG and "ON" or "OFF"))
end, { desc = "Toggle transparent background" })

-- Re-apply transparency after colorscheme changes (if enabled)
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    if vim.g.TRANSPARENT_BG then
      set_transparent(true)
    end
  end,
})
