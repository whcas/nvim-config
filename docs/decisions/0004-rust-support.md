# 0004 — Keep Rust development close to Neovim's native LSP

**Status:** Accepted (current configuration)

## Context

Rust editing benefits from language-aware diagnostics, formatting and
incremental test feedback, but basic support need not introduce a complete
development-environment framework.

## Decision

Enable `rust_analyzer` through `vim.lsp.enable`, use LSP diagnostics,
and format Rust buffers on `BufWritePre` with a one-second timeout.
Keep the optional `:RustLayout` command as a simple way to open
`bacon test` alongside an editor terminal.

## Consequences

- Relies on `rust-analyzer`, Rust formatting support and, for the optional
  test layout, `bacon` being available on `PATH`.
- Formatting is automatic on Rust saves but may time out on a slow server.
- The layout command is intentionally small and assumes a terminal-based
  workflow rather than installing a large task runner.

## Alternatives

A dedicated Rust integration plugin or task-running framework might add
capabilities if needed later. Keep those changes motivated by specific
missing functionality.
