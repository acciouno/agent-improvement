# Skill Registry

Every skill lives here with its validation state. The outer-loop review
starts from this table: anything past its review date gets revalidated,
revised, or retired.

| Skill | Status | Last validated | Next review | Notes |
|---|---|---|---|---|
| [date-verification](date-verification.skill.md) | active | 2026-09-14 | 2026-11-14 | Worked example; real lesson, keep current |

**Status values:** `active` (trusted, in use) · `candidate` (new, not yet
validated by a regression run) · `flagged` (past review date or failed a
check — revalidate, revise, or delete) · `retired` (moved to git history only)
