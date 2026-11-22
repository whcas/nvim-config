# Git UI experiment

Compare two **alternatives** for Git operations inside Neovim:
[Neogit + Diffview](https://github.com/NeogitOrg/neogit) and
[Lazygit](https://github.com/jesseduffield/lazygit).

Both experiments are branched from `main`. They are **not** meant to be
merged together. After choosing a winner, make a focused integration PR
targeting `main` and synchronise the result downstream as usual.

## Prepare a disposable repository

From one of the configuration worktrees, run:

```sh
sh scripts/git-ui-fixture.sh
```

The script prints a temporary test repository path containing a bare local
remote, a `main` branch and a `feature/conflict` branch. It changes no
global Git settings and never touches an existing work repository.

```sh
cd /path/printed/by/script/work
nv feat/git-neogit-diffview   # Test A
# or, from a separate fresh fixture:
nv feat/git-lazygit          # Test B
```

Use a **fresh fixture for each contender** so prior commits, merges or
working-tree edits cannot influence the second test. The `nv` launcher
is documented in `scripts/README.md`; it isolates the config and plugins
but **does not** isolate the project repository you have open.

### Launching the Git UI

| Test A: Neogit + Diffview | Test B: Lazygit |
| --- | --- |
| `<leader>gg` → `:Neogit` | `<leader>gg` → `:LazyGit` |
| `<leader>gd` → `:DiffviewOpen` | Diffs inside Lazygit |
| `:DiffviewFileHistory %` | File history inside Lazygit |
| Neogit handles Git actions, Diffview handles multiway conflict editing | Lazygit provides Git UI; external `lazygit` binary required |

If you're using the Lazygit candidate on macOS, install the command-line
application first with `brew install lazygit`; verify `lazygit --version`.

## Test tasks (in priority order)

1. **Conflict resolution (highest weight).** Merge `feature/conflict` into
   `main`. Inspect the incoming/current/base versions, resolve
   `example.txt` to your own final content, stage it and finish the merge.
   Check `git status` afterward. For Neogit, open `:DiffviewOpen` while
   the conflict is active, then stage and complete the merge in Neogit.
2. **Stage/unstage and commit.** Modify two separated regions of `notes.txt`.
   Try staging a single hunk, checking the staged diff, editing a commit
   message, and undoing an accidental stage. Avoid committing unreviewed
   changes; inspect the final commit.
3. **Branches.** Create a new branch, switch to another branch, inspect the
   branch list, and return to `main`. Check whether edited buffers are
   refreshed or flagged as stale.
4. **Remote operations.** Fetch and push a new local branch to the fixture's
   local bare `origin`. Check whether upstream tracking and errors are
   explained clearly. The fixture uses **no network remote**.
5. **Diff/navigation ergonomics.** Explore changed-file navigation, file
   history, copy/paste of revisions and returning to code without losing
   window layout or cursor position.

For conflict resolution, do not use `git reset --hard` or force push on a
real repository for the sake of the test. The fixture is disposable.

## What to record

| Criterion | Neogit + Diffview | Lazygit |
| --- | --- | --- |
| Resolve merge conflict confidently (most important) | | |
| Understand staged vs unstaged changes | | |
| Commit/push workflow | | |
| Create/switch/sync branches | | |
| Navigation from source buffer and back | | |
| Responsiveness/visual clarity | | |
| Surprises or accidental operations | | |

Note any setup pain separately from intrinsic interaction problems. Try
each plugin's built-in help before adding custom mappings. After testing,
close the losing experiment PR and keep its branch if a future comparison
would be useful.

## Why keep the experiments separate?

The `nv` launcher uses Git worktrees and `NVIM_APPNAME`, so candidate
plugins and lockfiles don't leak into your default configuration. **Git
operations still act on the repository in your current working directory**,
hence the separate temporary fixtures.
