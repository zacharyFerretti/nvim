-- Prerequisites (run once per machine):
--   Arch:  sudo pacman -S imagemagick
--   macOS: brew install imagemagick

local _preview_img = nil
local _preview_path = nil
local _preview_win = nil
local _preview_buf = nil

local PREVIEW_CACHE = "/tmp/nvim_img_preview.png"
local MAX_COLS = 50
local MAX_ROWS = 40

local img_exts = { png = true, jpg = true, jpeg = true, gif = true, webp = true, bmp = true, tif = true, tiff = true, avif = true }

-- Returns the content of the quoted string the cursor is currently inside.
local function get_string_under_cursor()
  local line = vim.fn.getline(".")
  local col = vim.fn.col(".")

  local i = 1
  while i <= #line do
    local c = line:sub(i, i)
    if c == '"' or c == "'" then
      local j = i + 1
      while j <= #line do
        if line:sub(j, j) == c then
          if i <= col and col <= j then
            return line:sub(i + 1, j - 1)
          end
          i = j
          break
        end
        j = j + 1
      end
    end
    i = i + 1
  end
  return nil
end

local function close_preview()
  pcall(vim.api.nvim_del_augroup_by_name, "ImagePreviewClose")
  if _preview_img then
    _preview_img:clear()
    _preview_img = nil
  end
  _preview_path = nil
  if _preview_win and vim.api.nvim_win_is_valid(_preview_win) then
    vim.api.nvim_win_close(_preview_win, true)
  end
  _preview_win = nil
  _preview_buf = nil
end

local function preview_image_under_cursor()
  local path = get_string_under_cursor()
  if not path then
    vim.notify("Cursor is not inside a quoted string", vim.log.levels.WARN)
    return
  end

  local ext = (path:match("%.(%a+)$") or ""):lower()
  if not img_exts[ext] then
    vim.notify("Not an image path: " .. path, vim.log.levels.WARN)
    return
  end

  local buf_dir = vim.fn.expand("%:p:h")
  local full_path = vim.fn.resolve(buf_dir .. "/" .. path)

  if vim.fn.filereadable(full_path) == 0 then
    vim.notify("Image not found: " .. full_path, vim.log.levels.ERROR)
    return
  end

  if _preview_path == full_path then
    close_preview()
    return
  end

  close_preview()

  -- Show loading float immediately for visual feedback
  local float_buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(float_buf, 0, -1, false, { "", "  Loading…", "" })
  local float_win = vim.api.nvim_open_win(float_buf, false, {
    relative = "cursor",
    row = 1,
    col = 0,
    width = 20,
    height = 3,
    style = "minimal",
    border = "none",
    zindex = 50,
  })
  _preview_win = float_win
  _preview_buf = float_buf

  -- Register close autocmd immediately — cursor move dismisses even mid-load
  local augroup = vim.api.nvim_create_augroup("ImagePreviewClose", { clear = true })
  vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI", "BufLeave" }, {
    group = augroup,
    once = true,
    callback = close_preview,
  })

  -- Pre-convert to a bounded size async. -thumbnail uses fast sampling and
  -- maintains aspect ratio; giving image.nvim a small file speeds up its render.
  vim.system(
    { "magick", "convert", full_path, "-thumbnail", "500x500", PREVIEW_CACHE },
    {},
    function(conv_result)
      vim.schedule(function()
        if not (_preview_win and vim.api.nvim_win_is_valid(_preview_win)) then return end

        if conv_result.code ~= 0 then
          vim.notify("Image conversion failed", vim.log.levels.ERROR)
          close_preview()
          return
        end

        -- Expand float to max bounds so image.nvim has room to render
        vim.api.nvim_win_set_config(_preview_win, {
          relative = "cursor",
          row = 1,
          col = 0,
          width = MAX_COLS,
          height = MAX_ROWS,
        })
        vim.api.nvim_buf_set_lines(_preview_buf, 0, -1, false, {})

        local image = require("image")
        local img = image.from_file(PREVIEW_CACHE, {
          window = _preview_win,
          buffer = _preview_buf,
          row = 0,
          col = 0,
          with_virtual_padding = false,
        })
        img:render()

        -- image.nvim reports the actual cells it used in rendered_geometry —
        -- resize the float to match exactly, eliminating any bottom gap.
        local rg = img.rendered_geometry
        if rg and rg.width and rg.height and rg.width > 0 and rg.height > 0 then
          vim.api.nvim_win_set_config(_preview_win, {
            relative = "cursor",
            row = 1,
            col = 0,
            width = rg.width,
            height = math.max(1, rg.height - 1), -- -1 trims the partial bottom cell the protocol reserves
          })
        end

        _preview_img = img
        _preview_path = full_path
      end)
    end
  )
end

return {
  "3rd/image.nvim",
  build = false,
  opts = {
    backend = "kitty",        -- Kitty Graphics Protocol; works on both Kitty and Ghostty
    processor = "magick_cli", -- uses ImageMagick CLI instead of luarocks binding (avoids Lua 5.4 compat issues)
    integrations = {},        -- no automatic rendering; preview is manual via <leader>up
    max_width = MAX_COLS,
    max_height = MAX_ROWS,
    max_width_window_percentage = math.huge,
    max_height_window_percentage = math.huge,
    window_overlap_clear_enabled = true,
    editor_only_render_when_focused = true,
  },
  keys = {
    {
      "<leader>up",
      preview_image_under_cursor,
      desc = "Preview Image Under Cursor",
    },
  },
}
