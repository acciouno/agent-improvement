# Outer-Loop Review — <YYYY-MM-DD>

Reviewer: <you / agent-assisted>

## 1. Sweep the experience log

- Entries since last review: <list IDs, e.g. 2026-09-14-01 … 2026-09-20-03>
- **Budget:** timebox the sweep. If the log exceeds one sitting, summarize what
  was covered, state what remains, and flag the constraint explicitly — do not
  silently truncate.
- **Enforce the lesson enum.** Every entry's Lesson must be `none`,
  `proposed: <file>`, or `dismissed: <reason>`. A candidate lesson may sit
  unproposed for at most one review cycle — this review either proposes or
  dismisses it. Check that `proposed` files exist and `dismissed` reasons are
  non-empty.
- Candidate lessons → drafted as proposals in `proposals/pending/` (cite entry
  IDs as evidence; a lesson without a proposal is a wish):
  - <entry ID>: <one-line lesson> → proposal file or "dismissed: <why>"
- Distill durable rules into `lessons.md` (format: date, label, Mistake, Rule).
  A correction that doesn't become a rule will repeat.

## 2. Registry health

For each skill in `skills/_index.md`:
- **Activated?** Aggregate the log's skill-use blocks since last review:
  uses / helped / harmed per skill, split by retrieved vs. followed. A skill
  never retrieved and a skill retrieved-but-not-followed are two distinct
  failure modes — the paper's L4 pair — and they need different fixes.
- **Past review date?** The 60-day date triggers the review; the contribution
  record drives the decision: revalidate, revise, or retire. Retired skills
  move to git history only; the registry row becomes `retired` with a date.
- **Cap check:** active skills ≤ 12. A new-skill proposal must displace an
  incumbent or justify growing the cap.

## 3. Proposals

- Pending proposals (`proposals/pending/`): decide approve/reject with reasons
  → `git mv` to `approved/` or `rejected/` as part of the decision → record in
  `proposals/decisions.md`.
- Recently approved: was the change applied with a changelog entry? Were the
  regression checks re-run? Update `last validated` in the registry.
- Eval changes are their own proposal and their own decision, in their own
  commit — never bundled with skill changes.

## 4. Evaluator health

- Do the checks in `evals/` still cover the current skills?
- Could the agent game any check? (The paper's L2 warning: a fixed test the
  improver can see too often stops being a test.) If a check has become
  predictable, rotate or strengthen it.
- If the evaluator changed this cycle: were the old checks run alongside the
  new for one cycle? A new suite must prove it isn't weaker than the old.
- Is the run log complete — every skill change since last review has a row?
  Skipped checks must be logged as skipped, never omitted.

## 5. Cross-skill interactions

- Did any change break another skill's assumptions? Check each skill's
  "Depends on / conflicts with" section against what actually changed.
- Any two skills giving contradictory guidance? Pick one — don't average them.
  State which wins and why; flag the other for cleanup.

## 6. Outcome

- Done: <what was completed>
- Verified: <what was checked and how>
- Remaining: <what is left>
- Not completed: <what was skipped or deferred, and why — silence here is a
  failure mode>
- Validated gains: <k> of <n> approved proposals since last review met their
  acceptance criteria. (Structural change is not the claim; validated
  improvement is.)
- Review effort: <rough time spent — the paper asks that autonomy be assessed
  together with the human effort required>
- Commits: <list>
- Proposals opened: <n> · decided: <n approved / n rejected>
- Skills retired: <list or "none">
- Next review due: <date>
