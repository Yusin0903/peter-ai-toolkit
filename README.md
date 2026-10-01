# peter-ai-toolkit

My portable skill tree for AI coding agents — global instructions, owned skills, and an installer that deploys everything (plus third-party skills I use) to any new machine in one command.

## What's in here

```
peter-ai-toolkit/
├── agents/                     # Per-agent global rules, one folder each
│   ├── claude/AGENTS.md        # symlinked to ~/.claude/AGENTS.md
│   ├── codex/AGENTS.md         # symlinked to ~/.codex/AGENTS.md
│   ├── pi/AGENTS.md            # symlinked to ~/.pi/agent/AGENTS.md
│   ├── opencode/AGENTS.md      # symlinked to ~/.config/opencode/AGENTS.md
│   └── omp/
│       ├── AGENTS.md           # symlinked to ~/.omp/agent/AGENTS.md
│       └── notes.md            # non-instruction reference notes (e.g. compaction settings)
├── docs/                       # Imported by agents/*/*.md via @docs/...
│   ├── shared-conventions.md
│   ├── git-conventions.md
│   ├── pr-description-template.md
│   ├── pr-review-teams-notify.md
│   └── pause-sweeping-confluence-format.md
├── skills/                     # Owned skills (linked under ~/.claude/skills/, ~/.codex/skills/, and ~/.agents/skills/)
│   ├── handoff/
│   ├── load-handoff/
│   └── llm-wiki-{daily,export,ingest,lint,todo}/
├── .codex/skills -> ../skills     # OMP project-local skill discovery
├── scripts/
│   └── aws-key-to-profile.sh
├── install.sh                  # Symlink owned files + clone external skills
└── README.md
```

Third-party skills are **not** stored in this repo. They're cloned by `install.sh` into `~/.claude/.peter-claude-cache/` and symlinked into `~/.claude/skills/`.

## Install

```bash
git clone https://github.com/Yusin0903/peter-ai-toolkit.git ~/peter-ai-toolkit
cd ~/peter-ai-toolkit
./install.sh
```

Re-run any time to update third-party skills (it does `git pull` on each cached repo).

Dry-run first if you want to see what it'll do:

```bash
./install.sh --dry-run
```

## OMP & Other Agents

OMP loads this repo's skills globally via `~/.agents/skills/` (symlinked by `install.sh`). Its user-level model and provider settings live in `~/.omp/agent/config.yml` (see `agents/omp/notes.md` for the compaction settings reference) and use the `RDSEC_API_KEY` environment variable; the key itself is never stored here.

Pi has its own `agents/pi/AGENTS.md` — pi doesn't expand `@file` references, so shared conventions are inlined there rather than imported.

## Currently installed third-party skills

| Skill | Source | Subdir |
|---|---|---|
| `grill-me` | https://github.com/mattpocock/skills | `skills/productivity/grill-me` |
| `caveman`  | https://github.com/JuliusBrussee/caveman | `skills/caveman` |

## Adding a new skill

### Adding one you wrote yourself

1. Create `skills/<name>/SKILL.md` in this repo.
2. Commit + push.
3. Re-run `./install.sh` on each machine.

### LLM wiki skills

The `llm-wiki-*` skills work with any compatible markdown wiki. Set `LLM_WIKI_HOME` to the wiki root, or they default to `~/peter-llm-wiki`.

### Adding a third-party skill

Edit `install.sh`, find the marked section, and add a line:

```bash
install_external <name> <git-url> <subdir-inside-repo>
```

Then commit + push + re-run `./install.sh`.

## Cross-platform

Tested on macOS. Should work on WSL2 / Linux (uses symlinks, plain bash, git).

Windows native is **not** supported — use WSL2.

## Recovery

`install.sh` backs up any pre-existing real (non-symlink) files at the target with a `.bak.<timestamp>` suffix before linking. Symlinks are replaced silently.

To uninstall, delete the symlinks under `~/.claude/` and `~/.codex/` and restore from `.bak.*` if needed:

```bash
rm ~/.claude/AGENTS.md ~/.claude/docs
rm ~/.claude/skills/{handoff,load-handoff,llm-wiki-daily,llm-wiki-export,llm-wiki-ingest,llm-wiki-lint,llm-wiki-todo,grill-me,caveman}
rm ~/.codex/AGENTS.md ~/.codex/skills/{handoff,load-handoff,llm-wiki-daily,llm-wiki-export,llm-wiki-ingest,llm-wiki-lint,llm-wiki-todo}
rm ~/.pi/agent/AGENTS.md ~/.omp/agent/AGENTS.md ~/.config/opencode/AGENTS.md
rm ~/.agents/skills/{handoff,load-handoff,llm-wiki-daily,llm-wiki-export,llm-wiki-ingest,llm-wiki-lint,llm-wiki-todo}
ls ~/.claude/*.bak.* ~/.codex/*.bak.*  # find backups
```

## Renaming an existing clone

If you already have this cloned under an old name (`peter-claude` or `peter-toolkit`), GitHub's redirect keeps the old remote URL working, but you'll want to rename locally to avoid confusion:

```bash
cd ~
mv <old-dir-name> peter-ai-toolkit
cd peter-ai-toolkit
git remote set-url origin https://github.com/Yusin0903/peter-ai-toolkit.git
./install.sh  # symlinks still point at the repo dir, so re-run to be safe
```
