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

The `ai` branch adds local AI assistance to the shared Neovim setup. `main`
remains the general-purpose configuration, without AI integrations. Only
AI-specific changes should be developed against `ai`; ordinary editor changes
belong on `main` first and then flow into `ai` through a sync pull request.

See the [AI-specific decision records](docs/decisions/ai/README.md) for the
reasons behind the integration and backend choices.

### Requirements and first launch

- Ollama running locally, with the model selected in `lua/config/ai.lua`.
- The current model is `qwen3.6:35b`; change that string in `ai.lua` if
  using a different locally installed model.

For example, with Homebrew:

```sh
brew services start ollama
ollama pull qwen3.6:35b
ollama list
```

Launch Neovim using this configuration and run `:checkhealth codecompanion`.
CodeCompanion is declared in `lua/config/plugins.lua`, and all four configured
interactions (`chat`, `inline`, `cmd`, `background`) use the Ollama adapter in
`lua/config/ai.lua`. No hosted-provider API keys are configured.

### Chat workflow

- `<leader>ca` (Space, c, a) toggles the CodeCompanion chat.
- Write your question directly in the chat's Markdown buffer. Submit with
  `<C-s>` in Insert mode or `<CR>` in Normal mode.
- `#{buffer}` explicitly attaches the current source buffer as context.
  Review attached context rather than assuming the model can see every file
  in the project. The chat may also include editor metadata (such as current
  working directory, system and Neovim version) in its system prompt.
- Use `ga` in chat to choose an available Ollama model, where supported by
  the installed CodeCompanion version.

The shared `render-markdown.nvim` setup renders both normal Markdown and
CodeCompanion chat buffers, with an additional Treesitter filetype registration
for `codecompanion`. This extension is `ai`-specific; generic Markdown support
was developed on `main`.

### Inline code editing

To edit only a function or range of code:

1. Visual-select the intended source lines.
2. Press `:`; Neovim supplies the Visual range `:'<,'>`.
3. Run `CodeCompanion` on that range, for example:

   ```vim
   :'<,'>CodeCompanion
   ```

4. Enter the edit instruction in CodeCompanion's prompt input. Review the
   proposed inline replacement before accepting or rejecting it.

**There is not yet a dedicated inline-edit keybinding in this repository.**
Use the built-in diff help/action hints to discover the current accept/reject
bindings; do not assume a keymap from a different plugin version.
Adding a shortcut and improving prompt composition are tracked separately
in [#5](https://github.com/whcas/nvim-config/issues/5) and
[#6](https://github.com/whcas/nvim-config/issues/6).

### Current limitations and follow-ups

Both chat and inline editing were exercised against a local Rust function
during the comparison with Parrot. The generated corrections passed the
corresponding Rust tests, but output quality and context must still be
reviewed before applying changes to real projects.

- [#7](https://github.com/whcas/nvim-config/issues/7): Show clear progress
  feedback while requests are processing.
- [#8](https://github.com/whcas/nvim-config/issues/8): Make inline diff
  accept/reject actions more discoverable.
- [#9](https://github.com/whcas/nvim-config/issues/9): Investigate excessive
  reasoning output and its effect on latency.

These usability changes are follow-up work, not prerequisites to using
CodeCompanion. Local inference can be slow depending on the model and hardware.

### Branch isolation and maintenance

The [version-controlled `nv` launcher](scripts/README.md) uses Git worktrees
and `NVIM_APPNAME` to keep experimental Neovim configurations and their
installed plugins separate. With `ai` as the default branch, `nv` launches
the ordinary AI configuration and `nv main` launches the general-purpose
configuration in its own worktree (assuming a local `main` branch exists).

AI-specific plugins, documentation and decisions are **not** merged back to
`main`. Bring general editor changes from `main` into `ai` using a dedicated
merge/sync PR, and retain AI-only sections when reconciling shared README
changes.
