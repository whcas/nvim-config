# 0002 — Keep configuration in small, ordered Lua modules

**Status:** Accepted (current configuration)

## Context

Configuration is easier to understand and review when changes to options,
keymaps, plugins, LSP and commands are not interleaved in a single file.

## Decision

`init.lua` loads `config.options`, `config.keymaps`, `config.plugins`,
`config.lsp`, then `config.commands`. Each module has one clear purpose.

## Consequences

- Individual features have a predictable home and can be reviewed in small
  commits.
- Ordering matters: for example, the leader key must be configured before
  mappings are defined, and some plugin-specific mappings may rely on the
  plugin modules being available at runtime.
- There is some cross-module coupling, so keep shared conventions documented
  and avoid adding new files without a clear reason.

## Alternatives

A single-file config can be simpler at the very beginning; a larger plugin
framework can automate discovery and ordering. Neither is currently needed
for this configuration's scale.
