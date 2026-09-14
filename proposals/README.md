# Proposals Inbox

The agent **proposes**; you **dispose**. Nothing here changes a skill until
its status is `approved` and the change is applied with a changelog entry.

## Workflow

1. Agent writes a proposal from `templates/proposal-template.md` into this
   directory: `proposals/YYYY-MM-DD-<short-title>.md`, status `pending`.
2. You set status to `approved` or `rejected` with a one-line reason.
3. If approved: apply the change to the skill, add a changelog entry with the
   evidence, update `last validated` in `skills/_index.md`, then run the
   regression checklist in `evals/`.
4. Rejected proposals stay on file — they are the "rejected alternatives"
   part of the skill's provenance.

No pending proposals right now.
