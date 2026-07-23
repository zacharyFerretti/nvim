# Per-machine language toggles

This config supports enabling/disabling languages **per machine** so it doesn't
error on machines that lack a given toolchain (no JDK, no Node, no Go, etc.).

Everything is driven by one registry: [`lua/config/languages.lua`](lua/config/languages.lua).
Each language there defines its LSP server, formatter(s), and treesitter parsers,
and defaults to **enabled**. A fully-equipped machine needs no extra setup.

To change what a machine runs, create a local override file. It is **gitignored**,
so it stays on that machine and never conflicts across machines or dirties the repo.

## Setup on a new machine

```sh
cd ~/.config/nvim
cp lua/config/languages_local.lua.example lua/config/languages_local.lua
# then edit lua/config/languages_local.lua
```

## What the override does

`languages_local.lua` returns a table of `{ <language> = <bool> }`. List **only**
the languages you want to change from the default. Setting one to `false`:

- skips its **LSP server** (not installed by Mason, not enabled), and
- skips its **formatters** in conform.

**Treesitter highlighting stays on regardless** — parsers compile locally and
don't need the language runtime, so you keep syntax highlighting everywhere.

Flip a language back to `true` (or delete its line) once you install its toolchain.

## Example

A machine with no dev toolchains installed:

```lua
-- lua/config/languages_local.lua
return {
  go = false,
  java = false,
  rust = false,
  python = false,
  typescript = false,
  kotlin = false,
  sql = false,
  -- css/html/json LSPs and the `prettier` formatter also need Node --
  -- uncomment these if Node isn't installed either:
  -- css = false,
  -- html = false,
  -- json = false,
  -- markdown = false,
}
```

## Available languages

`lua`, `bash`, `markdown`, `json`, `css`, `html`, `go`, `python`, `rust`,
`typescript`, `java`, `kotlin`, `sql`.

To add a new language, add an entry to `lua/config/languages.lua` (with its
`lsp`, `fmt`, and `ts` fields) — every consumer picks it up automatically.
