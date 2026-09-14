# Proposals

The agent **proposes**; you **dispose**. Nothing changes a skill until its
proposal is approved and the change is applied with a changelog entry.

## Status is the filesystem

- `pending/` — awaiting a human decision.
- `approved/` — decided yes; the change is (or was) applied.
- `rejected/` — decided no, with the reason recorded.

Move proposals with `git mv` as part of the decision — never hand-edit a
status field. A directory is the truth; a text field is a second source of
truth waiting to rot.

Every decision is also recorded with its reason in `decisions.md`, approvals
*and* rejections.

## Lifecycle

1. Agent drafts a proposal from `templates/proposal-template.md` into
   `pending/`: `pending/YYYY-MM-DD-<short-title>.md`.
2. You approve or reject.
3. `git mv` the file to `approved/` or `rejected/`; append the decision row
   to `decisions.md`.
4. If approved: apply the change with a changelog entry, update
   `last validated` in `skills/_index.md`, then run the regression checklist
   in `evals/`.

`EXAMPLE-proposal-format.md` (this directory) shows the expected specificity.
It is not a real proposal.
