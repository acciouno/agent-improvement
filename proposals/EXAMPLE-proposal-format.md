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

## Motivating evidence

- `2026-09-14-01` — title-first reading of the RSI paper misled; the
  contribution was a survey/framework, not a breakthrough. Conclusion-first
  would have set the right frame in minutes.

## Regression risk

Low. New skill, no existing behavior changes. Covered by a new checklist
item: "paper summary states demonstrated-vs-claimed distinction" (to be added
to `evals/` if approved).

## Decision record

- (not decided — example only)
