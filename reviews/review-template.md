# Outer-Loop Review — <YYYY-MM-DD>

Reviewer: <you / agent-assisted>

## 1. Sweep the experience log

- Entries since last review: <list IDs, e.g. 2026-09-14-01 … 2026-09-20-03>
- **Budget:** timebox the sweep. If the log exceeds one sitting, summarize what
  was covered, state what remains, and flag the constraint explicitly — do not
  silently truncate.
- Candidate lessons → drafted as proposals in `proposals/` (link entry IDs
  as evidence; a lesson without a proposal is a wish):
  - <entry ID>: <one-line lesson> → proposal file or "no proposal: <why>"
- Distill durable rules into `lessons.md` (format: date, label, Mistake, Rule).
  A correction that doesn't become a rule will repeat.

## 2. Registry health

For each skill in `skills/_index.md`:
- **Activated?** Was it actually retrieved and followed since last review, or
  did it sit unused? (The paper's L4 failure modes: never retrieved, or
  retrieved but not followed — both are skill failures, not task failures.)
- **Past review date?** → revalidate, revise, or retire. Retired skills move
  to git history only; the registry row becomes `retired` with a date.

## 3. Proposals

- Pending proposals: decide approve/reject with reasons → record in
  `proposals/decisions.md`.
- Recently approved: was the change applied with a changelog entry? Were the
  regression checks re-run? Update `last validated` in the registry.

## 4. Evaluator health

- Do the checks in `evals/` still cover the current skills?
- Could the agent game any check? (The paper's L2 warning: a fixed test the
  improver can see too often stops being a test.) If a check has become
  predictable, rotate or strengthen it.
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
- Commits: <list>
- Proposals opened: <n> · decided: <n approved / n rejected>
- Skills retired: <list or "none">
- Next review due: <date>
