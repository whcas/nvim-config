# Neovim configuration

A small, hand-maintained Neovim configuration using Lua and Neovim's built-in
plugin manager. The goal is to keep the setup understandable, easy to change
and comfortable for daily development without relying on a distribution.

## Requirements

- **Neovim 0.12.x**, using the built-in `vim.pack` API (tested with 0.12.5).
- **Git** for fetching plugins and managing this repository.
- **Rust toolchain**, `rust-analyzer`, and `rustfmt` for Rust language support.
- **ripgrep** (`rg`) is recommended for searching with `fzf-lua`.
- **bacon** is optional; only the `:RustLayout` command uses it.

Make sure the required tools are discoverable on your `PATH`.

## Install

Clone the repository to Neovim's standard configuration directory:

```sh
git clone https://github.com/whcas/nvim-config.git "${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
nvim
```

On first startup, `vim.pack.add` installs the configured plugins. Some
language-related components (including Treesitter parsers and completion
components) may be downloaded or built. Check `:messages` if startup fails.

## Layout

| Location | Responsibility |
| --- | --- |
| `init.lua` | Loads the configuration modules in a deliberate order |
| `lua/config/options.lua` | Core editor options and leader key |
| `lua/config/keymaps.lua` | Shared keyboard shortcuts |
| `lua/config/plugins.lua` | Plugin declarations and setup |
| `lua/config/lsp.lua` | Rust language server, diagnostics and formatting |
| `lua/config/commands.lua` | User-defined editor commands |
| `nvim-pack-lock.json` | Tracked plugin revisions used by `vim.pack` |
| `docs/decisions/` | Short records explaining configuration choices |

## What is configured

- Space as the leader key, relative line numbers, splits opening below/right,
  and smart-case search.
- `nvim-tree` for file browsing, `fzf-lua` for fuzzy finding and live grep,
  and `gitsigns.nvim` in the plugin list.
- `catppuccin-mocha` colours, `which-key` descriptions and `mini.pairs`.
- `blink.cmp` for completion.
- Rust Treesitter highlighting and `rust_analyzer` through the built-in LSP
  client. Rust buffers are formatted on save with a one-second LSP timeout.
- Markdown Treesitter highlighting and `render-markdown.nvim` (LaTeX rendering
  is currently disabled).

## Keybindings

The following are defined in `lua/config/keymaps.lua`. `<leader>` means Space.

| Mode | Binding | Action |
| --- | --- | --- |
| Insert | `jk` | Exit Insert mode |
| Terminal | `<Esc><Esc>` | Exit Terminal mode |
| Normal / Terminal | `<C-h/j/k/l>` | Move between windows |
| Normal | `<leader>e` | Toggle file explorer |
| Normal | `<leader>ff` | Find files |
| Normal | `<leader>fg` | Live grep |
| Normal | `<leader>fb` | Find open buffers |
| Normal | `<leader>cf` | Format current buffer via LSP |
| Normal | `<leader>uw` | Toggle line wrapping |
| Normal / Insert | `<C-s>` | Save current file |

Run `:RustLayout` to open a split layout with `bacon test` and another
terminal. This command requires the external `bacon` executable.

## Making changes

1. Start with the relevant Lua module rather than placing everything in
   `init.lua`.
2. Keep plugin declarations in `lua/config/plugins.lua` and give mappings
   descriptive `desc` values so they are discoverable.
3. Prefer a narrowly scoped change and review its effect on startup,
   diagnostics and editor mappings.
4. Review changes to `nvim-pack-lock.json` before committing. Installed
   packages persist on disk across sessions; deleting a plugin declaration
   alone does not necessarily remove the installed package.
5. Record meaningful non-obvious decisions in `docs/decisions/`.

See [configuration decisions](docs/decisions/README.md) for existing
rationale and trade-offs.

## Troubleshooting

- `:checkhealth` provides checks for Neovim and installed plugins.
- `:messages` shows errors and notices from startup.
- `:echo stdpath('config')` and `:echo stdpath('data')` confirm which
  configuration and package directory an instance is using.
- Verify `rust-analyzer`, `rustfmt`, and (if using `:RustLayout`) `bacon` are
  on `PATH` when Rust integration does not work.

For isolated experiments, Git worktrees can hold separate configuration
branches, and `NVIM_APPNAME` can select a matching independent Neovim
configuration/data/cache/state namespace for each launch.

## Personal `ai` configuration

The `ai` branch builds on the shared Neovim configuration above and adds
**CodeCompanion** connected to a **local-only Ollama** model. These features are
not included on `main`, which remains suitable for environments where local
AI integration should not be installed.

### Additional requirements

- Ollama running locally.
- The `qwen3.6:35b` model (or update `lua/config/ai.lua`).

With Homebrew:

```sh
brew services start ollama
ollama pull qwen3.6:35b
```

### Chat and editor integration

Check setup with `:checkhealth codecompanion`.

- `<leader>ca` toggles CodeCompanion chat (Space, c, a).
- Submit a chat message with `<C-s>` in Insert mode or `<CR>` in Normal mode.
- Use `#{buffer}` to include the current buffer explicitly.
- Use `ga` within the chat to select another locally installed Ollama model.

Responses are rendered as Markdown in a Neovim buffer. All configured
CodeCompanion interactions use the local Ollama adapter; no cloud API key
is required.

### Keeping configurations separate

Shared configuration changes are developed against `main` and brought into
`ai` via a dedicated `main` → `ai` pull request. CodeCompanion-specific
features remain on `ai`; they must not be merged into `main`.

To use an isolated checkout of another branch without switching your default
configuration, see the `NVIM_APPNAME` / Git worktree approach above or the
[branch launcher](scripts/README.md). If the launcher is installed and `ai`
is your default branch, `nv main` opens an isolated instance of `main`.
