# PR Review — Teams Notify Template

Posted to Teams after creating a PR to ask teammates for review.

## Format

```
Hi team 👋,

🔍 PRs ready for review: <PR title / one-line summary>
• <repo-name>: <PR URL>
• <repo-name>: <PR URL>          ← repeat per repo; omit bullets if single repo

📦 Changes:
• <change 1>
• <change 2>

✅ Verified: <what you checked and why it's safe — breaking-change risk, dependency conflicts, scope of usage>

Thanks!
```

## Rules

- **Title line** — reuse the PR title (or the shared subject when several PRs share one fix).
- **PR bullets** — one per repo, `repo-name: URL`. Single repo → still use one bullet.
- **Changes** — what changed, terse. Note when the same diff repeats across repos ("same one-line change in both").
- **Verified** — the reviewer-facing safety argument: what you confirmed, breaking-change assessment, dependency/constraint checks. This is what lets someone approve fast. Skip only if genuinely nothing to verify.
- Emojis 🔍 📦 ✅ are load-bearing section markers — keep them.
- Keep it scannable. No line-by-line diff narration; the PR shows that.

## Example

```
Hi team 👋,

🔍 PRs ready for review: fix: upgrade jwcrypto to 1.5.7 to fix CVE-2026-39373
• misp-app-backend: https://adc.github.trendmicro.com/CoreTech-SG/misp-app-backend/pull/65
• misp-app-servicegateway: https://adc.github.trendmicro.com/CoreTech-SG/misp-app-servicegateway/pull/50

📦 Changes:
• Bump jwcrypto 1.5.6 → 1.5.7 (same one-line requirements.txt change in both repos)
• Fixes CVE-2026-39373 / GHSA-fjrm-76x2-c4q4 (JWE ZIP decompression bomb DoS)

✅ Verified: both repos only use jwcrypto for RS256 JWT verification (no JWE/HMAC usage) — no breaking change expected, and python-jwt 3.3.5's jwcrypto>=1.0.0 constraint has no upper bound so there's no dependency conflict

Thanks!
```
