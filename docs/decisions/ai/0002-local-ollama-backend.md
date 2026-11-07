# 0002 — Use local Ollama as the inference backend

**Status:** Accepted (2026-11-07; `ai` branch only)

## Context

The selected Neovim integration needs a model backend for chat, inline
editing and other editor interactions. The current objective is to
experiment with useful editor assistance using a model running on the
local machine, without configuring a hosted provider account.

## Decision

Use the built-in **Ollama adapter** in `lua/config/ai.lua` for CodeCompanion's
`chat`, `inline`, `cmd` and `background` interactions. The configured model
is `qwen3.6:35b`. Ollama runs locally, and the repository does not configure
API keys or adapters for cloud-based models.

Start the local server and install the model before using the integration:

```sh
brew services start ollama
ollama pull qwen3.6:35b
```

Run `:checkhealth codecompanion` if the integration fails to load, and
confirm Ollama is running with `ollama list` or other Ollama diagnostics.

## Consequences and trade-offs

- Keeps the model endpoint under local control, without introducing
  hosted-provider API credentials into the editor configuration.
- Requires an installed, running Ollama service and sufficient memory
  and compute for the chosen model. Longer generations and model reasoning
  may significantly affect responsiveness.
- Different models or inference settings can change answer quality and
  latency; the same plugin is not a guarantee of identical behaviour.
- Local inference does **not** automatically imply that all editor plugins
  are offline or that processing sensitive project content is permitted.
  Follow the relevant environment's data-handling requirements.
- Some lengthy visible reasoning and uncertain progress feedback were
  observed during the initial experiment. These are tracked in
  [#9](https://github.com/whcas/nvim-config/issues/9) and
  [#7](https://github.com/whcas/nvim-config/issues/7).

## Alternatives and reconsideration

CodeCompanion supports other adapters and hosted providers, but none are
configured by this decision. If a local model becomes a hard constraint
for an important workflow, compare alternatives in a separate AI-only PR
with an explicit assessment of data handling, cost and responsiveness.
