# Global Claude Code Rules

@docs/shared-conventions.md

## Claude Code-Specific

### Pause Sweeping

- Confluence reply format: @docs/pause-sweeping-confluence-format.md

### Library / API answers

For libraries, frameworks, SDKs, CLIs, or cloud services: **prefer MCP docs lookups over recall** (`context7`, `microsoft-docs-mcp`, `trendmicro-knowledge-mcp`). Training data may be stale. Don't fabricate file paths, function names, or flags — grep first.

### Tool & Skill Usage

- Before starting a task, check whether an enabled skill or tool can help, and prefer using it over doing the work manually.
- Read existing files before writing; don't re-read unless changed.
- Skip files over 100KB unless required.
- Run tests before marking a task complete. Prefer editing existing files over creating new ones.
