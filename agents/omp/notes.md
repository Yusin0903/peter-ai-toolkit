# OMP Config Sync Notes

Not agent instructions — reference notes for `~/.omp/agent/config.yml` settings, so they can be reproduced quickly on a new device via `omp config set`.

## `compaction.thresholdTokens: 250000`

Token count at which auto-compaction triggers (default is lower, e.g. ~150000 or a fraction of the model's context window). Higher = compaction kicks in later, more raw context available, but each compaction pass near the limit is larger and slower.

```
omp config set compaction.thresholdTokens 250000
```

## `compaction.methodOrder: ["shake", "soft"]`

Order of compaction strategies attempted:

- `shake` — lightweight trim first: strips redundant/stale content (duplicate tool output, outdated file snapshots) while preserving raw message structure as much as possible.
- `soft` — falls back to standard summarization (older messages get summarized) if `shake` isn't enough.

```
omp config set compaction.methodOrder '["shake", "soft"]'
```

Prefers the lower-loss `shake` first; only falls back to summarization when needed. No more aggressive method (e.g. `hard`) is in the list — that's deliberate, don't add one without deciding you want auto-compaction to go that aggressive.
