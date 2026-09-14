# Agent Improvement Loop

A human-gated improvement setup for a personal AI agent, built from the
ideas in *The Last AI Built by Humans: Toward Genuine Recursive Self-Improvement*
(arXiv 2609.11873v1).

## The honest framing

This setup targets **L1 with touches of L2** on the paper's autonomy ladder:

- **You** own the objectives, the acceptance tests, and the release button.
- **The agent** executes tasks (inner loop) and *proposes* improvements (outer loop).
- Nothing changes the system without your approval. That gate is a feature,
  not a limitation — it is what keeps the loop trustworthy.

## The two loops

**Inner loop — daily task execution.** The agent does work using the current
skills. Every task appends one entry to `experience-log/experience-log.md`
(ID format `YYYY-MM-DD-NN`): what worked, what failed, and why. Failures are
the most valuable entries.

**Outer loop — system improvement.** On review (whenever you ask; weekly
suggested), follow `reviews/review-template.md`: sweep the log for lessons,
check registry health, decide pending proposals, audit the evaluator itself,
and check cross-skill interactions. Each review appends a row to
`reviews/review-log.md`. Without the review, the log is B0 with a filing
cabinet — the review is what closes the loop.

Proposals live in `proposals/` and say: which skill is targeted, what would
change, what evidence motivates it (linked log-entry IDs), and what regression
risk it carries. Decisions — approvals *and* rejections — are recorded in
`proposals/decisions.md`. You approve or reject; approved changes get a
changelog entry and a re-run of the regression checks.

This inner/outer separation is the Humanlaya pattern from the paper: one loop
repairs the current delivery, the other improves the system that will handle
later deliveries.

## The three gates (never skip)

1. **Proposal, not edit.** The agent never rewrites a skill directly. It writes
   a proposal diff. (Guards against the paper's Gödel Agent failure: recursive
   self-edits that silently made things worse.)
2. **Independent check.** After a skill change, run `evals/regression-checklist.md`.
   The checks are fixed and the agent does not train on them. A second pair of
   eyes — yours — is the independent evaluator. (Guards against the paper's
   "self-judge shares the proposer's blind spots" problem.)
3. **Provenance.** Every skill records *why* it exists and *what evidence*
   supports each change. A skill without provenance gets retired, not trusted.
   (This is the paper's "inheritance substrate" idea: successors need the
   reasoning, including rejected alternatives, not just the conclusion.)

## Retirement rule (anti library-drift)

The paper names the failure mode: an ever-growing skill library degrades
retrieval and stalls improvement. So:

- Every skill has a **last-validated date** in `skills/_index.md`.
- Any skill unvalidated for **60 days** is flagged for review: revalidate,
  revise, or delete.
- Deletion is safe: git history keeps everything, so rollback is one command.

## Layout

- `skills/` — versioned skill files + `_index.md` registry
- `experience-log/` — append-only log of task outcomes (stable entry IDs)
- `proposals/` — pending proposals, `decisions.md` log, one filled example
- `evals/` — fixed regression checklist (the acceptance tests) + run log
- `reviews/` — outer-loop procedure: template + review log
- `templates/` — blank skill and proposal templates
- `LICENSE` — MIT

## Quick start

1. Read `skills/_index.md`, then one skill file to see the format.
2. After the agent finishes a task, check that it logged the outcome in
   `experience-log/experience-log.md` with an entry ID.
3. When you want a review, say "run an outer-loop review." Proposals land in
   `proposals/`; decisions go in `proposals/decisions.md`; the review itself
   is logged in `reviews/review-log.md`.
4. After approving a change, run the regression checklist in `evals/` and log
   the run.
