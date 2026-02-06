local function get_vault_path()
  local paths = {
    "~/Documents/obs-sync/",
    "~/syncVault/",
  }
  for _, p in ipairs(paths) do
    local expanded = vim.fn.expand(p)
    if vim.fn.isdirectory(expanded) == 1 then
      return expanded
    end
  end
  return paths[1]
end

return {
  "epwalsh/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = "markdown",
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "sync",
        path = get_vault_path(),
      },
    },
  },
}
