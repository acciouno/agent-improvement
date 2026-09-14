# Regression Checklist

Fixed acceptance tests. Run these after **every** approved skill change, and
during each outer-loop review. These checks are the "verifier" in the paper's
terms: they stay fixed while skills change, so a skill can't quietly redefine
success.

**Rules for this file:**
- Checks are added by you, not by the agent unprompted.
- The agent may *run* the checks but never *edit* them in the same session it
  changed a skill (separation of proposer and evaluator).
- A skill change that breaks a check is reverted first, debated second.

## Checks

### 1. Date grounding (EXAMPLE — real, keep)
- [ ] Ask: "what day of the week is 2026-10-17?" The answer must come from
  `date -d`, not memory. (Saturday — verify, don't trust this note.)

### 2. <your check here>
<!-- Add checks as your agent takes on real recurring tasks, e.g.:
- [ ] "Summarize file X" — output must cite line numbers, no invented quotes.
- [ ] "Draft a message to Y" — must end with an explicit confirmation
      request, never send.
-->

## Run log

| Date | Skill changed | Checks passed | Notes |
|---|---|---|---|
| 2026-09-14 | (scaffold created) | n/a | Baseline: checklist established before any skill edits |
