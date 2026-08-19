---
name: load-handoff
description: Load the latest handoff for a repository branch/worktree or Trend Micro PCT case and resume work from where the last session left off.
argument-hint: "[target|default] Optional focus hint"
---

Read the latest handoff for a target and resume work. This is the **read** counterpart to the `handoff` skill. Do not write, overwrite, migrate, or update any handoff or `INDEX.md` file here.

## Storage layout

Read from the structured layout below:

```
~/context_record/
├── INDEX.md
├── repos/<repo>/branches/<branch>/current.md
├── repos/<repo>/worktrees/<worktree>/current.md
└── cases/<PCT-case>/current.md
```

The repository target is scoped to the canonical shared repository plus either its branch or its linked worktree. Do not use the current worktree directory basename as the repository name.

## Resolving the target

Target selection has this precedence:

1. An explicit target wins:
   - `load-handoff PCT-123456` or `load-handoff cases/PCT-123456`.
   - `load-handoff repos/<repo>/branches/<branch>`.
   - `load-handoff repos/<repo>/worktrees/<worktree>`.
   - `load-handoff repo=<repo> branch=<branch>` or `repo=<repo> worktree=<worktree>`.
2. No target or the literal `default` means the current repository and checkout. It resolves exactly as `handoff` does:
   - main checkout → `repos/<repo>/branches/<branch>/current.md`;
   - linked worktree → `repos/<repo>/worktrees/<directory-name>-<path-fingerprint>/current.md`.
3. Remaining arguments are an optional focus hint; they do not change the target.

`default` means “current repo and branch/worktree”; it does not mean `~/context_record/default/current.md`. An explicit missing target must not silently fall back to another target.

For an explicit linked-worktree target, use the full fingerprinted key shown in `Target` or `INDEX.md`, not only the directory basename.

For automatic repository detection, use `git rev-parse --show-toplevel`, `git branch --show-current`, and the first `worktree` path from `git worktree list --porcelain` to distinguish the canonical main worktree from a linked worktree. For a linked worktree, derive the same deterministic short fingerprint from its absolute path as `handoff` (for example, the first eight characters of `printf '%s' "$worktree_root" | git hash-object --stdin`). For a detached main checkout, use the same `detached-<short-sha>` selector used by `handoff`.

Validate explicit selectors before reading them: they must be relative target components under `~/context_record/`, contain no absolute prefix or `..` component, and resolve only to the documented `repos/` or `cases/` layout. Reject an unsafe or ambiguous selector instead of reading it.

## What to do

1. Resolve and report the target path and whether it is a repo branch, repo worktree, or PCT case.
2. Read `~/context_record/<target>/current.md`.
   - If it does not exist, list the relevant entries under `~/context_record/` so the user can see available targets, and stop.
3. If the structured target is absent, a matching legacy flat record may be read once as compatibility input:
   - PCT case: `~/context_record/PCT-123456/current.md`.
   - Repository: `~/context_record/<repo>/current.md` only when its recorded branch/worktree metadata matches the current context and the repository has no ambiguous worktree match.
   State clearly that a legacy fallback was used. Do not copy or migrate it automatically.
4. Reconcile the recorded state against reality before trusting it. For a repo handoff, compare:
   - recorded `Repository` / `Target` against the resolved repository target;
   - recorded `Branch` against `git branch --show-current`;
   - recorded `Worktree path` against `git rev-parse --show-toplevel`;
   - recorded `Latest commit` against `git log -1 --oneline`;
   - recorded state against `git status --short` for drift.
   For a PCT case with no related repo, there is no Git reconciliation; say that explicitly.
5. Summarise concisely:
   - one-line title and focus;
   - current state: done / mid-flight / blocked;
   - LOCKED decisions;
   - ordered next steps;
   - any target, branch, worktree, commit, or dirty-tree drift.
6. Confirm the resolved target and whether the recorded state matches reality.
7. Do not auto-start high-risk next steps such as deploy, apply, commit, or any action marked high-risk by project instructions. Surface the next step and let the user choose it. Low-risk reading or planning may continue only when the request clearly asks to continue.

If the requested target is missing, list `~/context_record/` (and the matching `repos/<repo>/` or `cases/` subtree when useful) and stop. Never invent state from an archive or another branch/worktree.

## Important

- This skill is read-only. Saving new state requires `handoff`.
- Returning to a previous state means loading context, not checking out, resetting, or otherwise changing Git state.
- Respect LOCKED decisions in the handoff and other saved project memory; do not re-grill settled decisions.

## Finishing

End with the resolved target and one line stating the next action you or the user will take.
