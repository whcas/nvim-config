# 0003 — Support Markdown in the shared editor configuration

**Status:** Accepted (current configuration)

## Context

README files and other Markdown documents benefit from syntax awareness
and readable in-editor rendering, independently of any specific workflow.

## Decision

Install `markdown` and `markdown_inline` Treesitter parsers, enable
Treesitter for Markdown buffers, and configure `render-markdown.nvim` for
Markdown presentation. Keep its LaTeX rendering disabled for now.

## Consequences

- Documentation is easier to read directly inside Neovim.
- This adds a renderer and additional Treesitter parsers to plugin setup.
- Advanced mathematical rendering is not covered by the current setup;
  enabling it should be a separate change with its dependency requirements
  understood and tested.

## Alternatives

Plain Markdown syntax highlighting has fewer moving parts, while heavier
rendering solutions can add more visual features. The existing approach is
a moderate compromise for ordinary documentation.
