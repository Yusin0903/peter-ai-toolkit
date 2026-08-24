#!/usr/bin/env bash
# Regenerate PI.md: pi-specific header + inlined shared-conventions.md
set -euo pipefail
cd "$(dirname "$0")/.."

HEADER='## Pi-Specific

### Library / API answers

Training data may be stale. Do not fabricate file paths, function names, or flags — grep the codebase first. If uncertain about a library API, say so rather than guessing.

### Tool & Skill Usage

- Before starting a task, check whether an enabled skill or tool can help, and prefer using it over doing the work manually.
- Read existing files before writing; don'"'"'t re-read unless changed.
- Skip files over 100KB unless required.
- Run tests before marking a task complete. Prefer editing existing files over creating new ones.

### No MCP

pi has no MCP servers by default. Do not reference MCP tools. Use `read`/`bash` (curl, grep) for documentation lookups instead.

---

'

{
  echo "# Global Pi Agent Rules"
  echo
  echo "pi does not expand \`@file\` references, so shared conventions are inlined below."
  echo "Sub-documents live in \`~/peter-ai-toolkit/docs/\` — read them with the \`read\` tool when relevant:"
  echo
  echo "- Git conventions: \`~/peter-ai-toolkit/docs/git-conventions.md\`"
  echo "- PR description template: \`~/peter-ai-toolkit/docs/pr-description-template.md\`"
  echo "- PR review Teams notify: \`~/peter-ai-toolkit/docs/pr-review-teams-notify.md\`"
  echo
  printf '%s' "$HEADER"
  echo "# Shared Agent Conventions (inlined from docs/shared-conventions.md)"
  echo
  cat docs/shared-conventions.md
} > PI.md

echo "PI.md regenerated ($(wc -l < PI.md) lines)"
