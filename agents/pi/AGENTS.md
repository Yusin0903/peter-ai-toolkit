# Global Pi Agent Rules

@docs/shared-conventions.md

Sub-documents live in `~/Peter-ai-toolkit/docs/` — read them with the `read` tool when relevant:

- Git conventions: `~/Peter-ai-toolkit/docs/git-conventions.md`
- PR description template: `~/Peter-ai-toolkit/docs/pr-description-template.md`
- PR review Teams notify: `~/Peter-ai-toolkit/docs/pr-review-teams-notify.md`

## Pi-Specific

### Library / API answers

Training data may be stale. Do not fabricate file paths, function names, or flags — grep the codebase first. If uncertain about a library API, say so rather than guessing.

### No MCP

pi has no MCP servers by default. Do not reference MCP tools. Use `read`/`bash` (curl, grep) for documentation lookups instead.
