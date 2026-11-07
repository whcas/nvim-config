# Isolated Neovim configuration launcher

`nv` is a small Zsh function for launching an existing configuration branch
without switching the branch in your default Neovim working tree.
It uses Git worktrees for separate configuration files and `NVIM_APPNAME`
for separate Neovim data, state, cache, and installed plugins.

## Installation

Your default configuration must be a Git checkout at
`${XDG_CONFIG_HOME:-$HOME/.config}/nvim`. Add this line to `~/.zshrc`:

```zsh
source "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/scripts/nv.zsh"
```

Open a new shell or run `source ~/.zshrc`.

Requires Zsh, Git with worktree support, and Neovim with `NVIM_APPNAME` support.
The launcher uses Git's `--path-format=absolute` option to validate worktrees.

## Commands

```zsh
nv                           # Default configuration; no worktree changes
nv main                      # Use the main branch (if different from default)
nv feat/my-experiment        # Create or reopen this branch's isolated config
nv missing-branch            # Error unless branch exists locally or at origin
nv one two                   # Usage error (exactly zero or one argument)
```

Branch names are passed verbatim. For example, `feat/my-experiment` uses the
configuration directory `~/.config/nvim-feat-my-experiment` (under the XDG
config directory, if set) and the app name `nvim-feat-my-experiment`.

First-time launch creates a Git worktree only if the named branch already
exists locally or as `origin/<branch>`. It never creates a *new* experiment
branch; create one first with Git, for example:

```zsh
git -C "${XDG_CONFIG_HOME:-$HOME/.config}/nvim" branch feat/my-experiment main
nv feat/my-experiment
```

To discover new remote branches, first run:

```zsh
git -C "${XDG_CONFIG_HOME:-$HOME/.config}/nvim" fetch origin
```

Each experiment gets its own configuration, package installations, cache and
state. `nv` does **not** change the current directory, shell environment, or
the branch of your default configuration. The next ordinary `nvim` invocation
still launches the default setup.

## Limitations and cleanup

- The only optional argument is a **branch name**, not a file path. Use
  `nvim <file>` for normal file launches.
- Branch names with slashes have their slashes replaced by hyphens for the
  configuration directory. If two names collide, the launcher refuses to
  reuse a worktree checked out on a different branch.
- A branch already checked out in a different worktree cannot be added
  again; Git reports this rather than changing the existing worktree.
- This does not update, pull, prune or delete worktrees automatically.

To remove a finished experiment:

```zsh
git -C "${XDG_CONFIG_HOME:-$HOME/.config}/nvim" worktree remove "${XDG_CONFIG_HOME:-$HOME/.config}/nvim-feat-my-experiment"
```

Removing the worktree does not delete the branch or the corresponding
Neovim data/state/cache directories. Clean those separately only if wanted.
