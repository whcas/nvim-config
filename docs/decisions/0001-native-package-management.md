# 0001 — Use Neovim's built-in package management

**Status:** Accepted (current configuration)

## Context

Neovim needs to install and load editor plugins, and their versions should
remain visible in the repository. An additional package-manager framework
would introduce another layer of bootstrap and configuration.

## Decision

Declare plugins with `vim.pack.add` in `lua/config/plugins.lua`, and track
their recorded revisions in `nvim-pack-lock.json`.

## Consequences

- Plugin declarations are ordinary Lua, and the package manager comes with
  Neovim rather than a separately bootstrapped framework.
- This requires a sufficiently recent Neovim version.
- Packages already installed on disk may remain after switching Git branches
  or removing declarations. A shared data directory can therefore cause
  unrelated lockfile changes across configurations.
- When comparing significantly different configurations, use separate
  `NVIM_APPNAME` environments (and optionally Git worktrees) to isolate data.
- Changes to the lockfile should be reviewed rather than committed blindly.

## Alternatives

A third-party package manager would offer a different lifecycle and more
manager-specific convenience features, at the cost of an additional layer
of setup. Revisit this decision only if concrete limitations arise.
