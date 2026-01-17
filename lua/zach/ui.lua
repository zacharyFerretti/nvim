vim.opt.fillchars = { eob = " " }

-- Setting some session options for auto-session
vim.opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- Sets line numbers by default on.
vim.opt.number = true
vim.opt.relativenumber = true

--- DUMPING GROUND ---
--- Old configs I don't want to get rid of in case I want them some day (such as clear backgrounds).

-- Background Clear
-- Set background clear.
-- vim.api.nvim_set_hl(0, "Normal", { bg = "NONE", ctermbg = "NONE" })
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE", ctermbg = "NONE" })
-- vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "NONE", ctermbg = "NONE" })
-- vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "NONE", ctermbg = "NONE" })

-- Setting Non-Clear Background Options
-- For Lazy.
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#1b2023" })
-- vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#1b2023" })
-- For Telescope.
-- vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "#1b2023" })
-- vim.api.nvim_set_hl(0, "TelescopePromptNormal", { bg = "#1b2023" })
-- vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { bg = "#1b2023" })
-- vim.api.nvim_set_hl(0, "TelescopePreviewNormal", { bg = "#1b2023" })
