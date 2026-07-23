# Goal 
Recreate a lot of what I like with LazyVim but from scratch, gain a deeper understanding of how it all works together.

## Plugins
1. **Searching**
    1. `telescope` - Quick searching with `fzf` and `rg`.
    2. `flash` - Sets it up for tag based searching. 
2. **Language Support**
    1. `conform` - Sets it up to enable a quick format based on a specified formatter (*such as `stylua` for lua files*.).
    2. `nvim-md` - Adds simple markdown syntax insertion support, see the keymaps for more information.
    3. `mason`, `mason-lspconfig`, `nvim-lspconfig` - Sets up all of the LSPs I generally use.
3. **General**
    1. `kanagawa` - Color Scheme of choice.
    2. `neo-tree` - UI for file explorer to replace `netrw`. 
    3. `which-key` - Major help figuring out and remembering key-binds!  

----

## Per-machine language toggles

Language support (LSP servers + formatters) is driven by a single registry,
[`lua/config/languages.lua`](lua/config/languages.lua), and can be enabled or
disabled **per machine** so the config doesn't error where a toolchain is
missing (no JDK, no Node, no Go, etc.). All languages default to enabled; create
a gitignored `lua/config/languages_local.lua` to turn off what a given machine
lacks. Treesitter highlighting always stays on.

See **[languages_local.md](languages_local.md)** for full setup instructions.

----

## Dependencies

### LSP Servers
LSP servers are managed by **Mason** and installed automatically on first launch,
for each language enabled in `lua/config/languages.lua`:

| Language              | Server          | Runtime needed |
|-----------------------|-----------------|----------------|
| CSS                   | `cssls`         | Node           |
| HTML                  | `html`          | Node           |
| JSON                  | `jsonls`        | Node           |
| Markdown              | `marksman`      | —              |
| Lua                   | `lua_ls`        | —              |
| Go                    | `gopls`         | Go             |
| Python                | `pyright`       | Node           |
| Rust                  | `rust_analyzer` | Rust           |
| TypeScript/JavaScript | `ts_ls`         | Node           |
| Java                  | `jdtls`         | Java JDK       |

### Formatters
Formatters must be installed on your system (conform.nvim does not auto-install
them). Each is only used when its language is enabled:

| Language   | Formatter            | Install Command                          |
|------------|----------------------|------------------------------------------|
| CSS        | `prettier`           | `npm install -g prettier`                |
| HTML       | `prettier`           | `npm install -g prettier`                |
| JSON       | `prettier`           | `npm install -g prettier`                |
| Markdown   | `prettier`           | `npm install -g prettier`                |
| Go         | `gofumpt`            | `go install mvdan.cc/gofumpt@latest`     |
| Java       | `google-java-format` | [GitHub Releases](https://github.com/google/google-java-format/releases) |
| Kotlin     | `ktlint`             | `brew install ktlint`                    |
| Lua        | `stylua`             | `cargo install stylua` or `brew install stylua` |
| Python     | `black`              | `pip install black`                      |
| Rust       | `rustfmt`            | `rustup component add rustfmt`           |
| Shell      | `shfmt`              | `brew install shfmt` or `go install mvdan.cc/sh/v3/cmd/shfmt@latest` |
| SQL        | `sql-formatter`      | `npm install -g sql-formatter`           |

### Tree-sitter
The `nvim-treesitter` plugin (main branch) requires the **Tree-sitter CLI** to compile parsers:

| Package          | Install Command           |
|------------------|---------------------------|
| `tree-sitter`    | `brew install tree-sitter` |
| `tree-sitter-cli`| `brew install tree-sitter-cli` |

Parsers are compiled on first launch and cached for subsequent sessions.

### System Requirements
Only needed for the languages you leave enabled (see [languages_local.md](languages_local.md)):

- **Tree-sitter CLI** - Required for compiling treesitter parsers (always needed)
- **Node.js/npm** - Required for `prettier` and the `cssls`/`html`/`jsonls`/`ts_ls`/`pyright` servers
- **Python/pip** - Required for `black`
- **Go** - Required for `gopls` and `gofumpt`
- **Rust/Cargo** - Required for `stylua`, `rustfmt`, and `rust_analyzer`
- **Java JDK** - Required for `jdtls` and `google-java-format`

----

## References
- [Keymaps.md](keymaps.md) - See the keymaps in use here.
