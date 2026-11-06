# Markdown Rendering Test

> [!IMPORTANT]
> **Temporary test fixture.** This README exists only to test Markdown rendering in Neovim.
> **Remove it from PR #2 before merging into `main`.**

Use this file to check how `render-markdown.nvim` behaves in **Normal**, **Insert**, and **Visual** modes.

## 1. Text formatting

Regular text alongside **bold**, *italic*, ***bold italic***, ~~strikethrough~~, and `inline code`.

Here is a [link to Neovim](https://neovim.io/) and a filename: `lua/config/plugins.lua`.

### Level-three heading

#### Level-four heading

##### Level-five heading

###### Level-six heading

## 2. Lists

- First bullet
- Second bullet with **emphasis**
  - Nested bullet
  - Another nested bullet
- Final bullet

1. First ordered item
2. Second ordered item
   1. Nested numbered item
   2. Another nested item
3. Third ordered item

### Task list

- [x] Install the Markdown plugin
- [ ] Check rendered headings and code fences
- [ ] Check editing remains comfortable
- [ ] Remove this test README before merging

## 3. Blockquote

> Neovim is an extensible text editor.
>
> It should be possible to read Markdown comfortably **without losing** normal Vim editing.

## 4. Code fences

```lua
vim.pack.add({
  { src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown" },
  callback = function()
    vim.treesitter.start()
  end,
})
```

```rust
fn main() {
    println!("Hello from Rust!");
}
```

```bash
git switch feat/markdown-support
nvim README.md
```

## 5. Table

| Feature | Expected behaviour | Checked? |
| :--- | :--- | ---: |
| Headings | Distinct heading markers | No |
| Lists | Readable bullets and indentation | No |
| Fenced code | Clear code block styling | No |
| Inline code | Visually distinct code text | No |

## 6. Horizontal rule

Text above the rule.

---

Text below the rule.

## 7. Final checks

Try `j` / `k`, search `/code`, use `v` to select text, enter Insert mode with `i`,
then leave with `jk` (your mapped escape). Verify the buffer remains easy to edit.

**Cleanup:** delete this README from `feat/markdown-support` before merging PR #2.
