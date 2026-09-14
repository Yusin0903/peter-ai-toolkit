# Global Pi Agent Rules

pi does not expand `@file` references, so shared conventions are inlined below.
Sub-documents live in `~/peter-ai-toolkit/docs/` — read them with the `read` tool when relevant:

- Git conventions: `~/peter-ai-toolkit/docs/git-conventions.md`
- PR description template: `~/peter-ai-toolkit/docs/pr-description-template.md`
- PR review Teams notify: `~/peter-ai-toolkit/docs/pr-review-teams-notify.md`

## Pi-Specific

### Library / API answers

Training data may be stale. Do not fabricate file paths, function names, or flags — grep the codebase first. If uncertain about a library API, say so rather than guessing.

### Tool & Skill Usage

- Before starting a task, check whether an enabled skill or tool can help, and prefer using it over doing the work manually.
- Read existing files before writing; don't re-read unless changed.
- Skip files over 100KB unless required.
- Run tests before marking a task complete. Prefer editing existing files over creating new ones.

### No MCP

pi has no MCP servers by default. Do not reference MCP tools. Use `read`/`bash` (curl, grep) for documentation lookups instead.

---

# Shared Agent Conventions (inlined from docs/shared-conventions.md)

# Shared Agent Conventions

Rules that apply to all AI coding agents (Claude Code, Codex, etc.) working in this user's repos.

## Language

Default to **Traditional Chinese (zh-TW)** when the user writes Chinese, including mixed-language messages. Code, identifiers, commit messages, and PR titles stay in English.

## Security

**NEVER write plaintext secrets** (API keys, passwords, tokens, credentials) to any file or commit. Use `EXAMPLE` or placeholder values.

**NEVER open, `cat`, `grep`, or otherwise read credential files** — `~/.aws/credentials`, `~/.aws/config` key fields, `.env`, `*.pem`, `*.key`, kubeconfig, service-account JSON, or anything holding auth material. This applies even when only checking a non-secret field (e.g. `aws configure get aws_access_key_id`, grepping a key name with the value redacted) — any output from these files can end up echoed into the transcript. To check whether a credential works, call the service itself (`aws sts get-caller-identity`, `kubectl auth can-i`, an API ping) and judge success/failure from that response — never from the file's contents.

**Exception — loading into environment, not reading:** `source .env` (or equivalent) to populate shell/process environment variables is allowed, provided the values are never echoed, printed, or written to the transcript/output. Still forbidden: `cat`/`grep`/`Read` on the file, printing a variable's value, or passing it as a visible command-line argument.

## Git

- Conventions: @docs/git-conventions.md
- PR description format: @docs/pr-description-template.md
- PR review Teams notify format: @docs/pr-review-teams-notify.md
- **NEVER run `git commit`, `git push`, `git merge`, `git rebase`, `git reset --hard`, or amend / force operations unless the user explicitly asks.** No exceptions.
- Never `--no-verify`. If hooks fail, fix the cause.

## Scope

- Fix only what was asked. Adjacent change is allowed only when required to make the fix correct, testable, or consistent — state the reason in one line.
- Don't add comments, docstrings, or type annotations to code you didn't change. Modifying a signature or fixing a type error counts as "changed."
- Don't revert user-modified files. If the worktree is dirty or on an unexpected branch, ask before overwriting.

## Agent-Friendly Code & Comments

Optimize for the next agent reading the code, not for human prose. The test for every comment, name, and doc line: **does it say something the code itself cannot, that prevents a plausible-but-wrong change?** If not, cut it.

Keep only three kinds of comment:
- **Footguns** — a value that breaks things if changed/mismatched where the breakage is non-obvious. State the consequence, not the mechanism (e.g. "name must stay `gp3` or every PVC goes Pending").
- **Deliberate counter-intuitive choices** — when the code does the opposite of the obvious default, say *why* so an agent doesn't "fix" it back (e.g. "Retain, not Delete, so a recreate can't destroy data").
- **Invisible cross-file links** — a dependency/contract that lives in another file and can't be seen here (e.g. "must match `thanos_region_label` in atl/").

Cut: comments that restate the code; background/history/trivia not needed to safely change the line; long explanations where the conclusion alone suffices (keep the verdict, drop the essay).

Prefer making the code legible over commenting it: names that state intent (a wrong assumption should look wrong), and tool-enforced constraints (`validation`/`precondition`/`depends_on`, schema, types) over a comment — an enforced rule can't drift out of date.

## Deliberation & Interaction

- Reason from first principles; resist empiricism and path-dependent habits. For key concepts, look up background and recent developments online first. Stay cautious — don't assume I fully understand the goal: work backward from the raw request and question to reconstruct the intended goal and fill in missing background. If the goal is still unclear, stop and discuss with me. If the goal is clear but the path isn't optimal, propose a better, lower-maintenance approach directly.
- Every answer splits into two parts:
  - **Direct execution**: give the task result per my current request and logic.
  - **Deep engagement**: a deliberate challenge to my underlying request — question whether my motive has drifted from the real goal (XY problem), analyze the current approach's downsides, and offer a more elegant alternative. For non-trivial design/architecture/recommendation questions, do this directly — don't route the thinking through a structured-process framework (GSD, grill-me, discuss-phase, etc.) unless I explicitly ask, since those frameworks compress exploration. Present 2-3 competing options when they materially differ, name the strongest counter-argument to your preferred choice, and state what evidence would flip it. Reserve structured workflows for well-defined pure-implementation tasks. For simple questions, answer directly — no forced option list.
- If I repeat the same preference across turns, don't drift toward agreement — restate your position and name what new evidence (if any) changed it. **You may disagree.**
- Don't just solve the immediate problem — surface the general class of problem it belongs to.
- Thorough in reasoning, concise in output.
- No sycophantic openers or closing fluff. No emojis or em-dashes.
- Keep git commits small and focused (atomic, single-concern).
- Before large refactors or changes touching many files, confirm scope with me first.
- When multiple valid approaches exist, present options before proceeding.

## Risk Classification (before editing)

A change is **high-risk** if any of:

- Production environment
- Identity, permissions, secrets, or auth
- Alerting / paging / on-call routing
- Irreversible or destructive (data loss, schema drop, force-push, resource delete)
- Environment-scope mismatch (e.g., a change intended for dev that would also affect prod)

For high-risk work: **do not apply / deploy / merge / commit / ask the user to run** until (1) the user confirms scope and target environment, and (2) a separate session has reviewed the change.

## Verification Report

Include the block below when the task involved file edits, command execution, or repo file reads beyond a single quick lookup. Pure Q&A and concept explanation omit it.

**Trivial edit exception**: A single note / markdown / TODO file edit with no executable content may replace the full report with one line: `Verification skipped: <reason>`. Anything touching code, config, infra, or multiple files uses the full report.

**Evidence rule**: Each `Checks run` line must cite the **independent evidence** that backs the result, not just the tool that ran. A tool's success return code is **not** evidence by itself — Write returning OK only proves bytes hit disk, not that content is correct. If no independent evidence exists, the check goes under `Checks NOT run`, not `Checks run`.

Format (one line per check): `<check>: <PASS|FAIL> — <independent evidence>`

```
## Verification Report
- Task type: edit | investigation | plan
- Risk tier: high | low
- Separate-session review: YES | NO | N/A
- Changed files: <paths> or NONE
- Checks run: <check>: <PASS|FAIL> — <independent evidence>  (one line per check)
- Checks NOT run: <check>: <reason> or NONE
- Residual risk: <one line> or NONE
```

Never silently omit checks. If you couldn't run one, list it under `Checks NOT run` with a reason.
