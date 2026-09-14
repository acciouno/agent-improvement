# Lessons

Distilled rules from corrections and failures. Raw outcomes live in
`experience-log/`; this file holds only the generalized rule that prevents
recurrence.

Format per entry:

```
## [YYYY-MM-DD] [short label]
Mistake: [what went wrong — the instance]
Rule: [generalized principle that prevents the pattern]
```

The outer-loop review distills new entries here. Before any significant task,
skim this file for relevant rules.

> Note: this plays the role the guidelines call `tasks/lessons.md`. This repo
> has no `tasks/` directory, so the file lives at the root where it stays
> visible. Same format, same function.

---

## 2026-09-14 date-verification
Mistake: A wrongly stored start date (Sun Sep 20) was treated as fact and
propagated into multiple artifacts before being corrected to Mon Sep 21.
Rule: Never work out weekdays from memory; ground every date-sensitive claim
with `date -d` and re-verify against the most recent correction before acting.
