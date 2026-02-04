-- Most of these will be managed by which-key for plugins.
vim.g.mapleader = " "

-- Clear search highlight with Escape
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })
