# Global OpenCode Rules

@docs/shared-conventions.md

## OpenCode-Specific

### Plan / Build Mode

- `Tab` toggles plan mode. In plan mode: no file edits, no write-shaped shell
  commands, no config changes, no commits. If asked to edit while in plan
  mode, say so and ask to switch to build mode first.

### Library / API answers

Training data may be stale. Prefer MCP docs lookups when available in this
session; otherwise verify with grep/curl first. Don't fabricate file paths,
function names, or flags — grep first.
