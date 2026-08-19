---
name: llm-wiki-ingest
description: Ingest notes, links, and raw material into a configurable markdown wiki while preserving private/public boundaries. Use for ingest, capture, distill, or save-to-wiki requests.
---

# Ingest into a markdown wiki

Resolve the wiki root from `LLM_WIKI_HOME`; default to `~/peter-llm-wiki`. Work from that directory, and read its local `AGENTS.md`, `CLAUDE.md`, schema, and relevant scripts when present. Do not assume the current working directory is the wiki.

Classify before writing:

- Raw, unprocessed input -> `raw/inbox/`.
- Private or work-specific material -> `wiki/internal/`.
- Public-ready, distilled technical knowledge -> `wiki/public/` with `visibility: public` and the repository's required `export_path`.

Never export company context, credentials, customer data, or private material. If public versus private is ambiguous, keep it internal or ask one focused question. Preserve source URLs or source paths in frontmatter. Reuse the wiki's existing templates, naming, frontmatter, and scripts; do not invent a parallel structure. Show changed files and run the narrowest available validation.
