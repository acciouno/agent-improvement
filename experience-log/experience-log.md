# Experience Log

Append-only. One entry per task outcome — successes briefly, failures in more
detail. The outer-loop review reads this file, so write for a future reader
(you, or the agent) who wasn't there.

## Format

Every entry gets a stable ID — `YYYY-MM-DD-NN` (NN = sequence that day) —
because proposals cite entries, and citations need anchors that survive edits.

**Lesson is a closed enum** — `none` | `proposed: <proposal file>` |
`dismissed: <reason>`. "Not yet proposed" is not a value. A candidate lesson
may sit unproposed for at most one review cycle; the review either proposes
or dismisses it. Lessons are not allowed to rot in limbo — an open loop that
never fires is a diary, not an improvement system.

```
## 2026-09-14-01 — <task>
- Outcome: <what happened>
- Worked: <what helped>
- Failed: <what didn't, and why you think so>
- Skills used: <per skill: retrieved? followed? helped / harmed / neutral>
- Lesson: <the enum above>
```

The `Skills used` block is the contribution record. The review aggregates it
into uses / helped / harmed per skill — that's what the retirement decision
runs on, not the calendar alone. Without the retrieved/followed split you
can't distinguish a bad skill from a good skill the agent never opened.

---

## 2026-09-14-01 — RSI paper explanation (EXAMPLE ENTRY)

- Outcome: Read arXiv 2609.11873v1 end to end (~4,700 lines) and explained it
  in plain terms with examples.
- Worked: Reading in sequential chunks with targeted finds for appendices;
  keeping a running distinction between "demonstrated" vs "aspirational."
- Failed: First assumed the paper was a breakthrough announcement from the
  title; the actual contribution is a survey + framework. Title-first reading
  misleads.
- Skills used: none (predates the skill library).
- Lesson: proposed: proposals/EXAMPLE-proposal-format.md
