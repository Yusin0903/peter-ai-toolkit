---
name: llm-wiki-daily
description: Create or update daily notes in a configurable markdown wiki, including focus, contribution, and evidence-based recap. Use for daily notes, daily focus, recap, or contribution requests.
---

# Manage the daily note

Resolve `LLM_WIKI_HOME` or default to `~/peter-llm-wiki`, then work from that directory. Read local instructions and preserve existing user-written content.

Use the current local date and this path unless the wiki's own instructions override it:

`wiki/internal/DailyNote/YYYY/MM - MonthName/YYYYMMDD.md`

Keep these sections:

```md
# Daily YYYYMMDD

## today focus:

## today important contribution:
```

Put planned or unfinished work under `today focus`; put completed, evidence-backed outcomes under `today important contribution`. Do not invent work. Use the wiki's `scripts/daily` when available. For a recap, use only the current conversation, TODO source, git status/diff, changed files, and existing notes.
