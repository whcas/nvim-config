# Source this file from Zsh; see scripts/README.md.
# A single branch argument selects an isolated Neovim configuration.
nv() {
  local config_home="${XDG_CONFIG_HOME:-$HOME/.config}"
  local default_dir="$config_home/nvim"
  local branch app_name worktree_dir current_branch actual_branch
  local default_git worktree_git

  case $# in
    0)
      NVIM_APPNAME=nvim command nvim
      return $?
      ;;
    1)
      branch="$1"
      ;;
    *)
      print -u2 "Usage: nv [branch]"
      return 2
      ;;
  esac

  if [[ "$(git -C "$default_dir" rev-parse --is-inside-work-tree 2>/dev/null)" != true ]]; then
    print -u2 "nv: expected a Git checkout at $default_dir"
    return 1
  fi

  current_branch="$(git -C "$default_dir" symbolic-ref --quiet --short HEAD)" || {
    print -u2 "nv: default configuration must be on a branch"
    return 1
  }
  if [[ "$branch" == "$current_branch" ]]; then
    NVIM_APPNAME=nvim command nvim
    return $?
  fi

  if ! git check-ref-format --branch "$branch" >/dev/null 2>&1; then
    print -u2 "nv: invalid branch name: $branch"
    return 2
  fi

  # This readable name also becomes the isolated NVIM_APPNAME.
  # If two branch names normalize identically, the checks below refuse reuse.
  app_name="nvim-${branch//\//-}"
  worktree_dir="$config_home/$app_name"

  if [[ ! -e "$worktree_dir" && ! -L "$worktree_dir" ]]; then
    if git -C "$default_dir" show-ref --verify --quiet "refs/heads/$branch"; then
      print "nv: creating worktree for $branch"
      git -C "$default_dir" worktree add "$worktree_dir" "$branch" || return 1
    elif git -C "$default_dir" show-ref --verify --quiet "refs/remotes/origin/$branch"; then
      print "nv: creating tracking worktree for origin/$branch"
      git -C "$default_dir" worktree add --track -b "$branch" "$worktree_dir" "origin/$branch" || return 1
    else
      print -u2 "nv: branch not found locally or at origin: $branch"
      print -u2 "nv: if it exists remotely, run: git -C \"$default_dir\" fetch origin"
      return 1
    fi
  fi

  if [[ ! -d "$worktree_dir" || ! -f "$worktree_dir/.git" ]]; then
    print -u2 "nv: path exists but is not a Git worktree: $worktree_dir"
    return 1
  fi

  actual_branch="$(git -C "$worktree_dir" symbolic-ref --quiet --short HEAD 2>/dev/null)"
  if [[ "$actual_branch" != "$branch" ]]; then
    print -u2 "nv: $worktree_dir is not checked out on $branch"
    return 1
  fi

  default_git="$(git -C "$default_dir" rev-parse --path-format=absolute --git-common-dir)" || return 1
  worktree_git="$(git -C "$worktree_dir" rev-parse --path-format=absolute --git-common-dir)" || return 1
  if [[ "$default_git" != "$worktree_git" ]]; then
    print -u2 "nv: $worktree_dir belongs to a different Git repository"
    return 1
  fi

  NVIM_APPNAME="$app_name" command nvim
}
