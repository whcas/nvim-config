# Parrot local LLM experiment

Parallel experiment to [the CodeCompanion PR](https://github.com/whcas/nvim-config/pull/1).
This branch uses **Parrot** with **local Ollama only**. Do not merge both
plugins without deciding which one to keep.

Markdown support is already shared by `main` and `ai` via
[PR #2](https://github.com/whcas/nvim-config/pull/2) and
[PR #4](https://github.com/whcas/nvim-config/pull/4).
This experiment only adds Parrot-specific configuration.

## Requirements

- Neovim 0.11 or later
- Ollama running at `127.0.0.1:11434`
- `qwen3.6:35b` installed (`ollama pull qwen3.6:35b`)

## Try it

- `<leader>ca` — toggle chat in a vertical split
- `<C-g><C-g>` — send a message inside a Parrot chat
- `<C-g>s` — stop generation
- `<C-g>c` — new conversation
- `<leader>cs` — paste a visual selection into a chat
- `:PrtModel` — inspect or select the model (inside a chat)
- `:PrtStatus` — show active provider/model
- `:PrtChatFinder` — find a previous persistent conversation
- `:'<,'>PrtRewrite` — ask Parrot to rewrite a selected range

**All requests are configured to use localhost.** The context setting is
`num_ctx = 16384` for this experiment; unlike the CodeCompanion branch,
this is explicitly fixed, so check context sizes when comparing performance.

## Fair comparison

Try the same questions and code snippets in both plugins. In particular:
1. Plain coding Q&A and follow-up questions
2. Asking about a selected Rust/Python function
3. Using an inline rewrite (review before accepting)
4. Markdown formatting and Vim-native navigation
5. Chat persistence, model switching, and interruption

No agent or autonomous editing workflow is enabled.
