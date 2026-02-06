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

## Dependencies

### LSP Servers
LSP servers are managed by **Mason** and will be installed automatically on first launch:
- `cssls` - CSS
- `html` - HTML
- `jdtls` - Java
- `jsonls` - JSON
- `lua_ls` - Lua
- `marksman` - Markdown
- `pyright` - Python
- `rust_analyzer` - Rust
- `ts_ls` - TypeScript/JavaScript

### Formatters
Formatters must be installed on your system (conform.nvim does not auto-install them):

| Language   | Formatter            | Install Command                          |
|------------|----------------------|------------------------------------------|
| CSS        | `prettier`           | `npm install -g prettier`                |
| HTML       | `prettier`           | `npm install -g prettier`                |
| JSON       | `prettier`           | `npm install -g prettier`                |
| Markdown   | `prettier`           | `npm install -g prettier`                |
| Java       | `google-java-format` | [GitHub Releases](https://github.com/google/google-java-format/releases) |
| Lua        | `stylua`             | `cargo install stylua` or `brew install stylua` |
| Python     | `black`              | `pip install black`                      |
| Rust       | `rustfmt`            | `rustup component add rustfmt`           |

### Tree-sitter
The `nvim-treesitter` plugin (main branch) requires the **Tree-sitter CLI** to compile parsers:

| Package          | Install Command           |
|------------------|---------------------------|
| `tree-sitter`    | `brew install tree-sitter` |
| `tree-sitter-cli`| `brew install tree-sitter-cli` |

Parsers are compiled on first launch and cached for subsequent sessions.

### System Requirements
- **Tree-sitter CLI** - Required for compiling treesitter parsers
- **Node.js/npm** - Required for `prettier` and several LSP servers
- **Python/pip** - Required for `black` and `pyright`
- **Rust/Cargo** - Required for `stylua`, `rustfmt`, and `rust_analyzer`
- **Java JDK** - Required for `jdtls` and `google-java-format`

----

## References
- [Keymaps.md](keymaps.md) - See the keymaps in use here.
