#!/bin/sh
# Create a disposable Git repository for comparing interactive Git UIs.
set -eu

root="$(mktemp -d "${TMPDIR:-/tmp}/nvim-git-ui.XXXXXX")"
work="$root/work"
git init --bare "$root/remote.git" >/dev/null
git init -b main "$work" >/dev/null
git -C "$work" config user.name "Git UI Experiment"
git -C "$work" config user.email "git-ui-experiment@example.invalid"

cat > "$work/example.txt" <<'EOF'
Shared heading
status = original
Shared footer
EOF

cat > "$work/notes.txt" <<'EOF'
one
two
three
four
five
six
seven
eight
nine
ten
eleven
twelve
EOF

git -C "$work" add .
git -C "$work" commit -m "Initial state" >/dev/null
git -C "$work" remote add origin "$root/remote.git"
git -C "$work" push -u origin main >/dev/null

git -C "$work" switch -c feature/conflict >/dev/null
sed 's/status = original/status = feature/' "$work/example.txt" > "$work/example.tmp"
mv "$work/example.tmp" "$work/example.txt"
git -C "$work" commit -am "Change status on feature" >/dev/null
git -C "$work" switch main >/dev/null
sed 's/status = original/status = main/' "$work/example.txt" > "$work/example.tmp"
mv "$work/example.tmp" "$work/example.txt"
git -C "$work" commit -am "Change status on main" >/dev/null

cat <<EOF

Disposable Git test repository: $work
Temporary bare remote:        $root/remote.git

Run 'cd "$work"' and launch the chosen Neovim config there.
The branch 'feature/conflict' is ready for a deliberately conflicting merge.
These tests change ONLY files in this disposable directory.
Remove the whole directory when finished, after checking the path:
    rm -rf "$root"
EOF
