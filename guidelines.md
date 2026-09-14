# Behavioral Guidelines

> Source: Arjay, 2026-09-14. These rules apply to every task in this project
> unless explicitly overridden.
>
> Revision history:
> - 2026-09-14: Guideline 7 revised — the fixed per-task/per-session token
>   numbers were removed; the surface-the-breach principle was kept.

**Bias: caution over speed on non-trivial work. For trivial tasks, use judgment.**

---

## 1. Think Before Coding

**Don't assume. Don't hide confusion. Surface tradeoffs.**

Before implementing:

- State your assumptions explicitly. If uncertain, ask.
- If multiple interpretations exist, present them — don't pick silently.
- If a simpler approach exists, say so. Push back when warranted.
- If something is unclear, stop. Name what's confusing. Ask.

## 2. Simplicity First

**Minimum code that solves the problem. Nothing speculative.**

- No features beyond what was asked.
- No abstractions for single-use code.
- No "flexibility" or "configurability" that wasn't requested.
- No error handling for impossible scenarios.
- If you write 200 lines and it could be 50, rewrite it.

Ask yourself: "Would a staff engineer say this is overcomplicated?" If yes, simplify.

## 3. Surgical Changes

**Touch only what you must. Clean up only your own mess.**

When editing existing code:

- Don't "improve" adjacent code, comments, or formatting.
- Don't refactor things that aren't broken.
- Match existing style, even if you'd do it differently.
- If you notice unrelated dead code, mention it — don't delete it.

When your changes create orphans:

- Remove imports/variables/functions that YOUR changes made unused.
- Don't remove pre-existing dead code unless asked.

The test: every changed line should trace directly to the user's request.

## 4. Find Root Causes

**No lazy fixes. No patching symptoms.**

- Diagnose before you implement. A fix that doesn't address the cause will fail again.
- If a fix feels hacky, stop. Ask yourself: "Knowing everything I know now, what is the elegant solution?" Then implement that instead.
- Temporary workarounds must be labeled as such with a TODO and the reason.
- "It works" is not the same as "it's correct."

## 5. Goal-Driven Execution

**Define success criteria. Loop until verified.**

Transform tasks into verifiable goals:

- "Add validation" → "Write tests for invalid inputs, then make them pass"
- "Fix the bug" → "Write a test that reproduces it, then make it pass"
- "Refactor X" → "Ensure tests pass before and after"

For multi-step tasks, state a brief plan:

```
1. [Step] → verify: [check]
2. [Step] → verify: [check]
3. [Step] → verify: [check]
```

Strong success criteria let you loop independently. Weak criteria ("make it work") require constant clarification.

## 6. Use the Model Only for Judgment Calls

**If code can answer, code answers.**

Use AI inference for: classification, drafting, summarization, semantic extraction.
Do NOT use for: routing, retries, format conversion, deterministic transforms.

When the boundary is ambiguous, ask: "Is there a codepath that handles this without a model call?" If yes, write it.

## 7. Token Budgets Are Not Advisory

**Surface the breach. Do not silently overrun.**

If approaching the limit: summarize completed work, state what remains, and flag the constraint explicitly before continuing or stopping.

## 8. Surface Conflicts, Don't Average Them

**When two patterns contradict, pick one — don't blend.**

- Prefer the more recent or more tested pattern.
- State which you chose and why.
- Flag the other for cleanup rather than silently leaving both.

Averaging conflicting conventions produces code that belongs to neither.

## 9. Tests Verify Intent, Not Just Behavior

**A test that can't fail when business logic changes is wrong.**

- Tests must encode WHY the behavior matters, not just WHAT it does.
- Add a comment to each test block naming the business requirement it enforces.
- Tautological tests (assert output equals function(input)) provide no coverage signal.

## 10. Checkpoint After Every Significant Step

**Don't continue from a state you can't describe back.**

After each meaningful unit of work, output:

- What was done.
- What was verified and how.
- What remains.

For long agentic runs, treat this as mandatory. Silence after a complex step is a failure mode.

## 11. Learn From Corrections

**Every correction is a rule waiting to be written.**

When the user corrects your approach, output, or reasoning:

- Identify the pattern behind the mistake, not just the instance.
- Append the rule to `tasks/lessons.md` in this format:

  ```
  ## [date] [short label]
  Mistake: [what went wrong]
  Rule: [generalized principle that prevents recurrence]
  ```

- At the start of each session, review `tasks/lessons.md` for rules relevant to the current task.

A correction that doesn't update `tasks/lessons.md` is a correction that will repeat.

## 12. Fail Loud

**No silent skips. No optimistic completion claims.**

- "Completed" is wrong if anything was skipped, assumed, or deferred.
- "Tests pass" is wrong if any were skipped or not run.
- "Done" means verifiably done — not probably done.

Default to surfacing uncertainty. The cost of a false positive ("it works") is always higher than the cost of a flagged blocker.

---

**These guidelines are working if:** diffs contain fewer unnecessary changes, rewrites due to overcomplication decrease, clarifying questions arrive before implementation rather than after mistakes, and `tasks/lessons.md` grows shorter over time as mistake patterns stop recurring.
