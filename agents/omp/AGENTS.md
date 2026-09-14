# Global OMP Agent Rules

@docs/shared-conventions.md

## OMP-Specific

### Library / API answers

Training data may be stale. Don't fabricate file paths, function names, or flags — grep the codebase first. If uncertain about a library API, say so rather than guessing.

### Tool & Skill Usage

- Before starting a task, check whether an enabled skill or tool can help, and prefer using it over doing the work manually.
- Read existing files before writing; don't re-read unless changed.
- Skip files over 100KB unless required.
- Run tests before marking a task complete. Prefer editing existing files over creating new ones.
