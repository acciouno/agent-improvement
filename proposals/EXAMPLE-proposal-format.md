# Proposal: read conclusions before summarizing papers

> EXAMPLE — not a real proposal. Shows the level of specificity expected.

- **Date:** 2026-09-14
- **Target skill:** new skill `skills/paper-triage.skill.md`
- **Status:** example — not pending, not decided
- **Decided by:** n/a

## Proposed change

New skill:

```markdown
# Skill: paper-triage
## Trigger conditions
- Any request to read, summarize, or explain a paper/report.
## Procedure
1. Read the abstract, then the conclusion and limitations sections, before
   the body.
2. Write down in one sentence what the paper *claims to have shown* vs. what
   it *actually demonstrates*, before summarizing.
3. Only then read the body — checking each section against that sentence.
## Known limits
- Slows down short-paper requests; apply judgment under ~5 pages.
```

## Hypothesis

Reading conclusions before the body reduces misframed summaries — would be
disproven by three consecutive paper summaries that still misstate the
paper's contribution type after adopting the order.

## Assumptions

- Papers over ~5 pages have a meaningful conclusion/limitations section.
- The reader's failure mode is title-abstract anchoring, not lack of speed.

## Motivating evidence

- `2026-09-14-01` — title-first reading of the RSI paper misled; the
  contribution was a survey/framework, not a breakthrough. Conclusion-first
  would have set the right frame in minutes.

## Root cause

Cause, not symptom: the error was in *reading order* (frame set by title),
not in summarization ability. Re-reading more carefully wouldn't fix it;
reading in a different order would.

## Why not extend an existing skill?

No existing skill covers reading strategy. Closest is `date-verification`,
which is about date claims — absorbing paper-triage into it would violate
one-skill-one-job.

## Out of scope

- Does not change how papers are cited or stored.
- Does not apply to non-paper documents (decided separately if needed).

## Acceptance criteria

- The next three paper summaries each open with a demonstrated-vs-claimed
  sentence before any detail. Evidence: experience-log entries, checked at
  the following review — before the skill is considered validated.

## Kill criteria

- Revert if two consecutive reviews find summaries that still misframe the
  contribution type despite the skill being followed.

## Regression risk

Low. New skill, no existing behavior changes. Covered by a new checklist
item: "paper summary states demonstrated-vs-claimed distinction" (to be added
to `evals/` if approved — as its own proposal and decision).

## Decision record

- (not decided — example only)
