# AGENTS.md

This repo (`peter-ai-toolkit`) is the source of truth for global agent config. Files under
`~/.claude/`, `~/.codex/`, `~/.pi/agent/`, `~/.omp/agent/`, `~/.agents/skills/` that look like
plain files are usually **symlinks back into this repo**. Edit here, not at the symlink target.

## Rule of thumb

Before editing a config/skill file reached via `~/.claude/`, `~/.codex/`, `~/.agents/`, etc.,
run `readlink <path>` (or `ls -la` on its parent dir) first. If it resolves into
`~/peter-ai-toolkit/...`, edit the resolved path, then re-run `./install.sh` (idempotent) if the
link itself needs recreating — usually it doesn't, edits to the target are live immediately.

## Symlink map

| Live path | -> Real file (this repo) |
|---|---|
| `~/.claude/AGENTS.md` | `agents/claude/AGENTS.md` |
| `~/.claude/docs` | `docs/` |
| `~/.codex/AGENTS.md` | `agents/codex/AGENTS.md` |
| `~/.config/opencode/AGENTS.md` | `agents/opencode/AGENTS.md` |
| `~/.pi/agent/AGENTS.md` | `agents/pi/AGENTS.md` |
| `~/.omp/agent/AGENTS.md` | `agents/omp/AGENTS.md` |
| `~/.claude/skills/<name>` | `skills/<name>/` (owned) |
| `~/.codex/skills/<name>` | `skills/<name>/` (owned) |
| `~/.agents/skills/<name>` | `skills/<name>/` (owned) |
| `.codex/skills` (in this repo) | `skills/` (relative symlink, for local discovery) |

Third-party skills (`grill-me`, `caveman`, ...) are **not** in this repo — they're cloned into
`~/.claude/.peter-claude-cache/<name>/` by `install.sh` and symlinked from there. Don't edit
those in place; edit `install.sh`'s `install_external` line and re-run instead.

`@docs/...` references resolve under this repo. Claude Code expands them natively; every
other agent lazy-loads them with Read per the note at the top of `docs/shared-conventions.md`.
No agent file inlines shared content — if `docs/shared-conventions.md` changes, nothing else
needs hand-syncing.

## Full details

See `README.md` for the install/uninstall flow, adding new owned/third-party skills, and the
recovery procedure. This file only exists so an agent working in `~/.claude/` or similar doesn't
edit a symlink target without realizing it's tracked elsewhere.
