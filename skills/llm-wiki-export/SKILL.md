---
name: llm-wiki-export
description: Lint and export public notes from a configurable markdown wiki into its configured publication target. Use for export-public-note, publish notes, or regenerate public documentation requests.
---

# Export public notes

Resolve `LLM_WIKI_HOME` or default to `~/peter-llm-wiki`. Read local instructions first, then run the wiki's own lint and export scripts when available (commonly `scripts/lint-wiki` followed by `scripts/export-public-note`). Review the destination git diff after export.

Do not manually edit generated destination files. If generated output is wrong, fix the source note or export logic in the wiki, then rerun the export. Never export private, company-specific, credential-bearing, or customer data. Report source and destination paths plus lint failures.
