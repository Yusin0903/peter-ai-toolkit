# Global Codex Rules

@docs/shared-conventions.md

## Codex-Specific

### Environment Constraints

- Codex runs in a sandboxed environment with limited or no network access. Do not attempt to fetch external URLs, install packages, or call external APIs unless the user has confirmed network is available.
- No MCP servers available. Do not reference MCP tools or skills.
- If a task requires network access and it's unavailable, state the blocker clearly instead of failing silently.

### Library / API answers

Training data may be stale. Don't fabricate file paths, function names, or flags -- grep the codebase first. If uncertain about a library API, say so rather than guessing.
