# Pause Sweeping Confluence Reply Format

Used when replying with a Pause Sweeping analysis verdict on Confluence.

## Format

```
Action: <RESUME SWEEPING | KEEP PAUSED | PARTIAL RESUME | MANUAL REVIEW REQUIRED>

Source: <public feed name, e.g. abuse.ch ThreatFox | abuse.ch URLhaus | internal/N-A>

Confidence: <HIGH | MEDIUM-HIGH | MEDIUM | LOW>

Final Verdict Distribution (after reclassifying <ioc> as <Lean TP | Lean FP>):

True Positive: <pct>% (<count> IOCs)

False Positive: <pct>% (<count> IOCs)

Uncertain: <pct>% (<count> IOCs — <reclassification note, or omit if none>)
```

If Action is PARTIAL RESUME, add one line after Confidence stating what's excluded:

```
Excluded from resume: <count> IOCs added to sweeping exceptions (<list or reference>)
```

## Rules

- **Action** — state the analysis's actual final recommendation directly: RESUME SWEEPING, KEEP PAUSED, PARTIAL RESUME, or MANUAL REVIEW REQUIRED. Do not collapse PARTIAL RESUME or MANUAL REVIEW REQUIRED into RESUME SWEEPING / KEEP PAUSED — match the analysis's final recommendation as-is.
- **Source** — the public/external threat intel feed the report name maps to (e.g. report name "ThreatFox IOCs for ..." → `abuse.ch ThreatFox`; "URLhaus IOCs for ..." → `abuse.ch URLhaus`). If the report is internally curated with no external feed, state `Internal` instead.
- **Confidence** — reflects how much manual reclassification/judgment call went into the final distribution. Fewer reclassified/uncertain cases → higher confidence.
- **Final Verdict Distribution** — always state counts AND percentages. If any IOC was reclassified from Uncertain to TP/FP during deep analysis, note it in the parenthetical after "Final Verdict Distribution".
- **Uncertain line** — if 0%, still show the line with the reclassification note explaining why it dropped to 0. If nonzero, state the count and leave the parenthetical off (or note why they remain unresolved).
- Omit the parenthetical entirely if no reclassification happened — just `Final Verdict Distribution:` with no extra text.

## Example

```
Action: RESUME SWEEPING

Source: abuse.ch ThreatFox

Confidence: HIGH

Final Verdict Distribution (after reclassifying brezxcchec.com as Lean TP):

True Positive: 100% (9 IOCs)

False Positive: 0% (0 IOCs)

Uncertain: 0% (0 IOCs — brezxcchec.com reclassified to Lean TP)
```

### PARTIAL RESUME example

```
Action: PARTIAL RESUME

Source: abuse.ch URLhaus

Confidence: MEDIUM-HIGH

Excluded from resume: 14 IOCs added to sweeping exceptions (Kaspersky "unrated", zero Tier-1 corroboration)

Final Verdict Distribution (after reclassifying 41 Uncertain IOCs as Lean TP):

True Positive: 76.3% (45 IOCs)

False Positive: 23.7% (14 IOCs)

Uncertain: 0% (0 IOCs — all 41 reclassified to Lean TP)
```
