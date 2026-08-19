---
name: llm-wiki-lint
description: Run quality and privacy-boundary checks against a configurable markdown wiki. Use for wiki lint, validate notes, check export metadata, or audit public/private separation requests.
---

# Lint a markdown wiki

Resolve `LLM_WIKI_HOME` or default to `~/peter-llm-wiki`, then run the repository's existing lint command when available (commonly `scripts/lint-wiki`). Also check public notes for missing required `export_path` metadata and private/public boundary violations according to local schema and instructions.

Do not rewrite content during a lint-only request. Report exact files, rule violations, and the smallest corrective action. Avoid printing credentials, tokens, customer data, or raw sensitive logs.
