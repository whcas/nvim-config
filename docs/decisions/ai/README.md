# AI-specific configuration decisions

These records document choices that apply **only** to the `ai` branch.
They are kept separate from the general-purpose decision records in the
parent directory to avoid numbering conflicts when `main` gains new ADRs.

- [0001 — Choose CodeCompanion over Parrot](0001-codecompanion-integration.md)
- [0002 — Use local Ollama for CodeCompanion](0002-local-ollama-backend.md)

Do not copy these documents or their integration-specific guidance into
`main`. General editor decisions should be made on `main` and then synced
downstream to `ai`.
