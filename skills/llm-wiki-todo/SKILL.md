---
name: llm-wiki-todo
description: Inspect and update the single source-of-truth TODO list in a configurable markdown wiki. Use for TODO, task capture, add task, weekly task, or mark done requests.
---

# Manage wiki TODOs

Resolve `LLM_WIKI_HOME` or default to `~/peter-llm-wiki`. Treat `tasks/now.md` as the only TODO source unless local wiki instructions explicitly define another path. Read the file before editing and preserve unrelated user content.

Support these operations:

- No subcommand -> show `tasks/now.md`.
- `add <item>` -> add a short item under `## Today`.
- `week <item>` -> add a short item under `## This Week`.
- `done <partial text>` -> move the uniquely matching item to `## Done Recently` and mark it `[x]`.

Do not scan the whole wiki, recreate generated TODO files, or silently resolve ambiguous matches. If more than one item matches, list the candidates and ask which one.
