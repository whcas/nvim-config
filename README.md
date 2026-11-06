# AI branch

Personal Neovim configuration with a **local-only** Ollama chat. The `main`
branch deliberately does not include this integration, for use at work.

## Requirements

- Neovim 0.12 or later
- Ollama, running locally
- The `qwen3.6:35b` model (or change the model in `lua/config/ai.lua`)

With Homebrew:

```sh
brew services start ollama
ollama pull qwen3.6:35b
```

## Neovim

Start Neovim on this branch and run `:checkhealth codecompanion`.
Use `<leader>ca` to toggle the chat (Space, c, a with the default leader).

Type a message and press `<C-s>` in insert mode or `<CR>` in normal mode.
Use `#{buffer}` to include the current buffer and `ga` to choose another
locally installed Ollama model.

Responses are rendered as Markdown inside an ordinary Neovim buffer.
All configured CodeCompanion interactions use the **local** Ollama adapter;
no cloud API key is required.

To return to the work-safe configuration, switch back to `main`.
