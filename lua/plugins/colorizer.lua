return {
  "NvChad/nvim-colorizer.lua",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    user_default_options = {
      rgb_fn = true,  -- enables rgb(r, g, b) parsing
      hsl_fn = true,  -- enables hsl() if you want it
      css = true,     -- enables all CSS features
      mode = "background",  -- or "foreground" or "virtualtext"
    },
  },
}
