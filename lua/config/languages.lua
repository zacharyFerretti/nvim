-- Central registry of per-language tooling.
--
-- One place to enable/disable a language. When a language is enabled its LSP
-- server and formatters are wired up; when disabled they are skipped so the
-- config does not error on machines that lack that toolchain (no JDK, no Node,
-- no Go, etc.). Treesitter highlighting is always installed regardless -- parsers
-- compile locally and do not need the language runtime.
--
-- Per-machine overrides live in `languages_local.lua` (gitignored). Create that
-- file on a machine to turn off what it can't run, without touching this file.
-- See `languages_local.lua.example`.

local M = {}

-- Every language defaults to enabled here so a fully-equipped machine (no local
-- override file) behaves exactly as before. Disable per machine via the override.
M.registry = {
  lua        = { enabled = true, lsp = "lua_ls",        fmt = { lua = { "stylua" } },                 ts = { "lua" } },
  bash       = { enabled = true, lsp = nil,             fmt = { sh = { "shfmt" } },                    ts = { "bash" } },
  markdown   = { enabled = true, lsp = "marksman",      fmt = { markdown = { "prettier" } },           ts = { "markdown", "markdown_inline" } },
  json       = { enabled = true, lsp = "jsonls",        fmt = { json = { "prettier" } },               ts = { "json" } },
  css        = { enabled = true, lsp = "cssls",         fmt = { css = { "prettier" } },                ts = { "css" } },
  html       = { enabled = true, lsp = "html",          fmt = { html = { "prettier" } },               ts = { "html" } },
  go         = { enabled = true, lsp = "gopls",         fmt = { go = { "gofumpt" } },                  ts = { "go", "gomod", "gosum" } },
  python     = { enabled = true, lsp = "pyright",       fmt = { python = { "black" } },                ts = { "python" } },
  rust       = { enabled = true, lsp = "rust_analyzer", fmt = { rust = { "rustfmt" } },                ts = { "rust" } },
  typescript = { enabled = true, lsp = "ts_ls",         fmt = {},                                      ts = { "javascript", "typescript" } },
  java       = { enabled = true, lsp = "jdtls",         fmt = { java = { "google-java-format" } },      ts = { "java" } },
  kotlin     = { enabled = true, lsp = nil,             fmt = { kotlin = { "ktlint" } },               ts = {} },
  sql        = { enabled = true, lsp = nil,             fmt = { sql = { "sql_formatter" } },           ts = {} },
}

-- Merge in per-machine overrides: a table of { <language> = <bool> }.
local ok, overrides = pcall(require, "config.languages_local")
if ok and type(overrides) == "table" then
  for lang, on in pairs(overrides) do
    if M.registry[lang] ~= nil then
      M.registry[lang].enabled = on
    end
  end
end

-- Iterate only the enabled languages.
local function enabled_specs()
  local out = {}
  for lang, spec in pairs(M.registry) do
    if spec.enabled then
      out[lang] = spec
    end
  end
  return out
end

M.is_enabled = function(lang)
  local spec = M.registry[lang]
  return spec ~= nil and spec.enabled == true
end

-- LSP server names for every enabled language (for mason ensure_installed / vim.lsp.enable).
M.lsp_servers = function()
  local servers = {}
  for _, spec in pairs(enabled_specs()) do
    if spec.lsp then
      servers[#servers + 1] = spec.lsp
    end
  end
  return servers
end

-- conform's formatters_by_ft, assembled from enabled languages.
M.formatters_by_ft = function()
  local by_ft = {}
  for _, spec in pairs(enabled_specs()) do
    for ft, list in pairs(spec.fmt or {}) do
      by_ft[ft] = list
    end
  end
  return by_ft
end

-- Every treesitter parser (highlighting stays on even for disabled languages),
-- plus editor essentials.
M.treesitter_parsers = function()
  local seen, parsers = {}, { "vim", "vimdoc" }
  for _, p in ipairs(parsers) do
    seen[p] = true
  end
  for _, spec in pairs(M.registry) do
    for _, parser in ipairs(spec.ts or {}) do
      if not seen[parser] then
        seen[parser] = true
        parsers[#parsers + 1] = parser
      end
    end
  end
  return parsers
end

return M
