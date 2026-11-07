# Configuration decision records

These short notes explain **why** particular configuration choices were made,
their alternatives and the trade-offs that future changes should consider.
They are meant to give maintainers and automated contributors useful context
without forcing them to reconstruct intent from commit history.

## Records

- [0001 — Built-in package management](0001-native-package-management.md)
- [0002 — Small, ordered Lua modules](0002-modular-lua-config.md)
- [0003 — Markdown support without additional rendering requirements](0003-markdown-rendering.md)
- [0004 — Rust development ergonomics](0004-rust-support.md)

## Writing or revising a record

Use a concise title, status, context, decision, consequences and alternatives.
Prefer documenting a practical trade-off over claiming a decision is the
only correct option. If a decision changes, update its status and link to a
replacement record rather than silently rewriting its history.
