# Global Claude Code Rules

@docs/shared-conventions.md

## Claude Code-Specific

### Pause Sweeping

- Confluence reply format: @docs/pause-sweeping-confluence-format.md

### Library / API answers

For libraries, frameworks, SDKs, CLIs, or cloud services: **prefer MCP docs lookups over recall** (`context7`, `microsoft-docs-mcp`, `trendmicro-knowledge-mcp`). Training data may be stale. Don't fabricate file paths, function names, or flags — grep first.
