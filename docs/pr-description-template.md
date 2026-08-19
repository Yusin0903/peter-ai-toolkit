# PR Description Template

Fill in each section. Skip a section entirely if it doesn't apply — don't leave placeholder text.

## Summary and Motivation
What changed, and **why** — the problem this solves or the trust/cost/risk it removes. Not what the diff does line-by-line (the diff shows that); state the reasoning a reviewer can't get from the code alone.

## Jira Ticket
Link.

## Type of Change
- [ ] Feature
- [ ] Bug fix
- [ ] Refactor
- [ ] Documentation
- [ ] CI/CD
- [ ] Dependencies

## Changes
Bullet list, one change per bullet. For each: what changed + why this approach (if non-obvious). Skip changes a reviewer would consider mechanical/self-evident from the diff.

## Breaking Changes
State "None" or describe the contract that shifted and who is affected. If a legacy behavior/ID/name is replaced, name the old and new value.

## Testing
- **Automated**: which suites ran and passed (unit / lint / type-check / etc).
- **Manual**: what you did by hand, in which environment, and what you were checking for.
- **Evidence**: prefer things a reviewer can independently check over "I tested it and it works" — a build-log line, a commit SHA, a snapshot file, a before/after screenshot. Evidence should let the reviewer verify without re-doing the work or trusting your word.

## Checklist
- [ ] Commit messages and PR title follow repo convention and include the ticket ID
- [ ] Docs updated if this changes user-facing or developer-facing behavior
- [ ] No secrets/credentials in the diff
- [ ] No unreviewed access-control or permission changes
