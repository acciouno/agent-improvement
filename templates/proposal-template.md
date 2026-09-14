# Proposal: <short title>

- **Date:** <YYYY-MM-DD>
- **Target skill:** `skills/<name>.skill.md` (or "new skill" if creating one)
- **Status:** pending | approved | rejected — status is the filesystem:
  the file lives in `proposals/pending/`, `proposals/approved/`, or
  `proposals/rejected/`. Move it with `git mv` on decision.
- **Decided by:** <who> on <date>

## Proposed change

Describe the change as a diff or precise edit. "Improve the skill" is not
a proposal — show the before and after.

## Hypothesis

What you believe, stated so it can be wrong. <belief> — would be disproven by
<observable>.

## Assumptions

What this proposal takes for granted. State them; if an assumption is wrong,
the proposal is wrong. Do not hide confusion behind a confident diff.

## Motivating evidence

Cite experience-log entries by stable ID (`YYYY-MM-DD-NN`) — at least one
must resolve (CI checks this). A proposal without resolvable evidence is a
hunch, not an improvement.

## Root cause

Is this treating the cause or a symptom? What evidence says so? If the fix
feels hacky, stop — name the elegant solution instead, or label this a
temporary workaround with a TODO and the reason.

## Why not extend an existing skill?

Required for new skills; write "n/a — edits <skill>" otherwise. Which
existing skill came closest, and why can't it absorb this change?

## Out of scope

What this change deliberately does not touch. Every changed line should trace
to the request; adjacent "improvements" belong in their own proposals.

## Acceptance criteria

How we will know this worked — observable and dated. E.g. "zero date
corrections logged for 30 days," not "skill seems better." The evidence must
exist **before merge**, not as a follow-up promise.

## Kill criteria

Conditions under which this change gets reverted even if approved. E.g.
"revert if the next review's contribution record shows zero helped and any
harmed."

## Regression risk

What could this break? Which regression checks cover it?

## Decision record

- Approved / rejected because: <reason>
- Follow-up: <re-run evals on YYYY-MM-DD / observe for N tasks>
