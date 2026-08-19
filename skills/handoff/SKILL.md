---
name: handoff
description: Compact the current conversation into a handoff document, organised by repository/worktree or Trend Micro PCT case under ~/context_record/.
argument-hint: "[target|default] Optional focus description"
---

Write a handoff document summarising the current conversation so a fresh agent can continue the work.

## Storage layout

All handoffs live under `~/context_record/`. A target is either a code repository context or a Trend Micro PCT case:

```
~/context_record/
├── INDEX.md
├── repos/
│   └── <repo>/
│       ├── branches/
│       │   └── <branch>/
│       │       ├── current.md
│       │       └── archive/
│       └── worktrees/
│           └── <worktree>/
│               ├── current.md
│               └── archive/
└── cases/
    └── <PCT-case>/
        ├── current.md
        └── archive/
```

A linked worktree gets its own `worktrees/<worktree>/` target even when it has the same repository or branch as another checkout. The main checkout uses `branches/<branch>/`. This is the boundary that prevents handoffs from different worktrees being merged into one `current.md`.

## Resolving the target

Resolve and state the target before writing. Use one of these forms:

- `PCT-123456` or `cases/PCT-123456` → `cases/PCT-123456/`.
- `repos/<repo>/branches/<branch>` → an explicitly selected repository branch.
- `repos/<repo>/worktrees/<worktree>` → an explicitly selected worktree.
- `repo=<repo> branch=<branch>` or `repo=<repo> worktree=<worktree>` → the equivalent explicit selectors.
- No target or `default` → the current repository and checkout.

For automatic repository detection:

1. Run `git rev-parse --show-toplevel` for the current worktree. Use the first `worktree` path from `git worktree list --porcelain`; its basename is the canonical `<repo>`, not the current linked-worktree directory name.
2. Read the current branch with `git branch --show-current`.
3. Use `branches/<branch>/` for the main checkout. Use `worktrees/<worktree>/` for a linked worktree, where `<worktree>` is `<directory-name>-<path-fingerprint>`; derive the short fingerprint deterministically from the absolute worktree path (for example, the first eight characters of `printf '%s' "$worktree_root" | git hash-object --stdin`).
4. If the branch is detached, use `detached-<short-sha>` for a main checkout and record the commit; a linked worktree still uses its fingerprinted worktree key.

Branch names containing `/` may create matching nested directories below `branches/`; keep the branch name exact. Keep the absolute worktree path in the document so a later load can verify the fingerprint and detect a moved worktree.

Validate explicit selectors before using them as paths: they must be relative target components under `~/context_record/`, contain no absolute prefix or `..` component, and resolve only to the documented `repos/` or `cases/` layout. Reject an unsafe or ambiguous selector instead of writing it.

`default` is a selector sentinel, not a literal `default/` directory. A PCT case is a case target even when the current directory is a repository; record a related repository in the metadata only when it is relevant.

For an explicit linked-worktree target, use the full fingerprinted key shown in `Target` or `INDEX.md`, not only the directory basename.

If there is no Git repository and no explicit PCT case/target, stop and ask for an explicit target. Do not invent a project from an arbitrary parent directory.

## What to write

Save two copies for the resolved target:

1. `~/context_record/<target>/current.md` — replace the entire file every time; never append or concatenate the previous handoff.
2. `~/context_record/<target>/archive/<YYYY-MM-DD-HHMMSS>-<slug>.md` — immutable timestamped snapshot. If that exact path already exists, add a numeric suffix instead of overwriting it.

Read the existing `current.md` before replacing it when it exists. Read `INDEX.md` before updating it. Check the archive destination before writing so an existing snapshot is not overwritten.

For a repository target, use this metadata:

````markdown
# Handoff: <one-line title>

**Target:** `repos/<repo>/branches/<branch>` or `repos/<repo>/worktrees/<worktree>`
**Target type:** repo
**Repository:** <canonical repo name>
**Branch:** <branch or detached>
**Worktree:** <main or worktree name>
**Worktree path:** <absolute path>
**Latest commit:** <short SHA + subject>
**Updated:** <YYYY-MM-DD HH:MM>
**Focus for next session:** <derived from arguments or conversation>

## Current state at handoff
- What was just done, what's mid-flight, what's blocked.

## Decisions that are LOCKED (do not re-grill)
- Bullet list. Each item: decision + one-line rationale.

## Next steps (in order)
1. ...
2. ...

## Open risks / TODO
- ...

## Suggested skills for next session
- ...

## How to resume cleanly
```text
Read ~/context_record/<target>/current.md
Continue <focus>.
```
````

For a PCT case, use `**Target type:** PCT case`, `**Case:** PCT-123456`, and `**Repository:** <related repo or N/A>`. Use `Branch`, `Worktree`, and `Latest commit` only when a related repository context was actually used.

Do not duplicate content already captured in PRDs, plans, ADRs, issues, or commits; reference them by path or URL.

## Maintain INDEX.md

After writing the handoff files, update `~/context_record/INDEX.md` so the user can see all tracked targets at a glance.

- Read `INDEX.md` first if it exists.
- Ensure one line per target, keyed by the target path, in this format:
  `- **repos/<repo>/branches/<branch>** — <updated YYYY-MM-DD HH:MM> — <focus headline>`
- Use the equivalent `repos/.../worktrees/...` or `cases/<PCT-case>` path for other targets.
- Replace the existing line for the same target instead of appending a duplicate.
- Sort by most-recently-updated first.

Existing flat entries such as `<project>/current.md` are legacy records. Do not rewrite or delete them as part of an unrelated handoff; new handoffs must use the structured target path. `load-handoff` may read a matching legacy record as a compatibility fallback.

## Finishing

Report:

- The resolved target path and target type.
- Path to `current.md`.
- Path to the archive snapshot.
- The exact one-liner the user can paste to resume: `Read ~/context_record/<target>/current.md`.
