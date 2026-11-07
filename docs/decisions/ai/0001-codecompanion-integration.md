# 0001 — Choose CodeCompanion for local Neovim assistance

**Status:** Accepted (2026-11-07; `ai` branch only)

## Context

We evaluated two Neovim integrations for the same local Ollama model
(`qwen3.6:35b`): CodeCompanion.nvim ([PR #1](https://github.com/whcas/nvim-config/pull/1))
and Parrot.nvim ([PR #3](https://github.com/whcas/nvim-config/pull/3)).
The goal was an editable, editor-native Markdown conversation that could
reason about selected source code and support reviewable edits.

Comparison was done in isolated Neovim environments using Git worktrees and
`NVIM_APPNAME`. The exercises covered conversational relevance, awareness of
editor metadata, supplying source code, reviewing a faulty Rust median
function, writing tests before changing the code, applying a fix and
reviewing the proposed change.

## Evidence

- **Both integrations produced valid Rust changes.** With the original
  implementation, CodeCompanion's 16 generated tests had 10 passes and 6
  expected failures; Parrot's 7 tests had 3 passes and 4 expected failures.
  Once the implementations were corrected, all 16 and all 7 tests
  respectively passed.
- **CodeCompanion supplied more editor metadata by default** (including
  Neovim version, OS and working directory) and made source context
  visible/editable. This does not mean it automatically read project files;
  source buffers still needed to be attached.
- **CodeCompanion's in-buffer inline diff was preferred.** Parrot had
  clearer, more discoverable review controls. Both workflows felt somewhat
  clunky to launch and lacked obvious processing feedback.
- An initial Parrot test failed to include the selected source because of
  our Visual-mode mapping/invocation, **not because Parrot could not accept
  selected code**. After supplying context correctly, its code review
  performed well.
- Default system prompts affected conversational behaviour: Parrot tended
  toward lengthy Socratic explanations; CodeCompanion sometimes emitted
  excessive visible reasoning. These observations are configuration/model
  concerns, not proof that one plugin's LLM is intrinsically better.

See the [CodeCompanion decision comment](https://github.com/whcas/nvim-config/pull/1#issuecomment-6709668197)
and the [Parrot experiment conclusion](https://github.com/whcas/nvim-config/pull/3#issuecomment-6709668597)
for the contemporaneous summary.

## Decision

Use **CodeCompanion.nvim** for the `ai` branch, with the local Ollama
adapter. Keep CodeCompanion and its Plenary dependency in the AI-only
plugin configuration. The Parrot PR was closed without merging.

## Consequences

- The general-purpose `main` configuration stays free of AI integrations.
- CodeCompanion is the default integration for experiments and subsequent
  AI-specific improvements. We do **not** need to install both plugins.
- Known usability follow-ups are tracked as
  [#5](https://github.com/whcas/nvim-config/issues/5),
  [#6](https://github.com/whcas/nvim-config/issues/6),
  [#7](https://github.com/whcas/nvim-config/issues/7),
  [#8](https://github.com/whcas/nvim-config/issues/8), and
  [#9](https://github.com/whcas/nvim-config/issues/9).
- Treat AI-generated code and tests as proposed changes requiring review.

## Alternatives and reconsideration

Parrot was viable, with a pleasant native Markdown buffer and especially
discoverable rewrite-review actions. Its experiment remains documented in
PR #3. Reconsider it if CodeCompanion encounters a **material workflow
limitation** that reasonable configuration or follow-up development cannot
address; do not switch based on a single weak model response.
