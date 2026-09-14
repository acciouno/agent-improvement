# Proposal Decisions

Every decided proposal lands here — approvals *and* rejections. Rejections
are first-class provenance: they record what was considered and why it lost,
which is exactly what a successor needs to avoid re-litigating old ideas.

| Date | Proposal | Decision | Reason | Follow-up |
|---|---|---|---|---|
| 2026-09-14 | Review pass: MIT LICENSE, `reviews/`, decisions log, checklist v1, skill template v2 (`bb86632`) | approved | Arjay reviewed and approved the pass before commit | Re-run evals at next review |
| 2026-09-14 | Behavioral-guidelines implementation: `lessons.md`, `check-skills.sh`, template upgrades; `guidelines.md` with Arjay's guideline-7 revision (`fec784f`, `eba8b67`) | approved | Arjay approved; guideline 7's fixed token numbers removed per his correction | — |
| 2026-09-14 | External-review pass A — skills/system: portable dates, lesson enum, contribution retirement, skill cap, `_meta`, proposal dirs (`093f12b`) | approved | Arjay approved the push; no pending proposal preceded it — process gap recorded, not hidden | Future external-review fixes go through `proposals/pending/` first |
| 2026-09-14 | External-review pass B — evaluator: portable check 1, eval-separation rules, `check-consistency.sh`, checklist pin, CI (`e977819`, `68b4081`) | approved | Same as above; `skills/` and `evals/` kept in separate commits per the separation rule | CI workflow needed a new token scope to push; resolved same day |
| 2026-09-14 | Fix passes C (content) + D (evaluator) from the second external review: 6 evaluator defects, log/placeholder/prose fixes | approved | Arjay explicitly chose "Apply the full fix list" | Deliberate failing PR to prove the mixed-change gate (pass D) |

## Format for new rows

- **Date:** when decided · **Proposal:** path to the file, e.g.
  `proposals/approved/2026-09-20-x.md`
- **Decision:** approved / rejected
- **Reason:** one or two sentences — the actual grounds, not "seemed good"
- **Follow-up:** e.g. "re-run evals 2026-10-01", "revisit if 3 similar failures log"
