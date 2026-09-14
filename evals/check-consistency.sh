#!/usr/bin/env bash
#
# check-consistency.sh — structural invariants, answered deterministically.
#
#   1. evals/regression-checklist.md matches its sha256 pin. The checklist is
#      the acceptance rule; if it can be edited silently, every other check
#      is theater. (Proposer/evaluator separation, enforced by mechanism.)
#      NOTE: this script cannot protect itself — the outer pin lives in
#      .github/workflows/checks.yml, which verifies the scripts' hashes
#      before running them. See the checklist's "Rules for this file".
#   2. Every entry ID cited in proposals/ exists in experience-log/.
#      A proposal citing evidence that doesn't resolve is a hunch wearing
#      a citation. Fenced code blocks are skipped on both sides: the log's
#      ## Format example must never resolve as evidence, and example IDs in
#      a proposal's code blocks don't count as citations.
#   3. Every proposal file carries all required template sections
#      (line-anchored match — same treatment skills already get).
#
# Usage: ./evals/check-consistency.sh   (from the repo root)
# Exit 0 when all checks pass, 1 otherwise.
#
# After an APPROVED eval change, regenerate the pins in the same commit:
#   sha256sum evals/regression-checklist.md > evals/checksums.sha256
#   # and update the *_SHA256 pins in .github/workflows/checks.yml

set -u

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
fail=0

pass_msg() { echo "PASS: $1"; }
fail_msg() { echo "FAIL: $1"; fail=$((fail+1)); }

# Print a file with fenced code blocks removed.
unfence() { awk '/^```/{f=!f; next} !f' "$1"; }

# 1. Checklist pin
PIN="$ROOT/evals/checksums.sha256"
if [ ! -f "$PIN" ]; then
  fail_msg "pin file missing: evals/checksums.sha256"
else
  if ( cd "$ROOT" && sha256sum -c evals/checksums.sha256 ); then
    pass_msg "checklist matches sha256 pin"
  else
    fail_msg "checklist does NOT match sha256 pin — was it edited without an approved eval change?"
  fi
fi

# 2. Evidence IDs resolve — entry IDs look like YYYY-MM-DD-NN.
#    Both sides skip fenced blocks: the log's format example carries no real
#    ID anymore, and this makes that guarantee structural, not coincidental.
LOG="$ROOT/experience-log/experience-log.md"
checked=0
for f in "$ROOT"/proposals/pending/*.md "$ROOT"/proposals/approved/*.md \
         "$ROOT"/proposals/rejected/*.md "$ROOT"/proposals/EXAMPLE-proposal-format.md; do
  [ -e "$f" ] || continue
  while IFS= read -r id; do
    [ -z "$id" ] && continue
    checked=$((checked+1))
    if unfence "$LOG" | grep -q "^## $id"; then
      pass_msg "$id cited in $(basename "$f") resolves"
    else
      fail_msg "$id cited in $(basename "$f") has no log entry"
    fi
  done <<< "$(unfence "$f" | grep -oE '[0-9]{4}-[0-9]{2}-[0-9]{2}-[0-9]{2}' | sort -u)"
done
[ "$checked" -eq 0 ] && echo "NOTE: no entry IDs cited in proposals/"

# 3. Proposal sections — every proposal file must carry the template's
#    required sections, line-anchored (renaming a heading must fail).
REQUIRED_PROPOSAL_SECTIONS=(
  "## Proposed change"
  "## Hypothesis"
  "## Assumptions"
  "## Motivating evidence"
  "## Root cause"
  "## Why not extend an existing skill?"
  "## Out of scope"
  "## Acceptance criteria"
  "## Kill criteria"
  "## Regression risk"
  "## Decision record"
)
for f in "$ROOT"/proposals/pending/*.md "$ROOT"/proposals/approved/*.md \
         "$ROOT"/proposals/rejected/*.md "$ROOT"/proposals/EXAMPLE-proposal-format.md; do
  [ -e "$f" ] || continue
  base="$(basename "$f")"
  section_fail=0
  while IFS= read -r section; do
    if ! unfence "$f" | sed 's/[[:space:]]*$//' | grep -qxF -- "$section"; then
      echo "FAIL: proposal $base: missing section: $section"
      section_fail=1
    fi
  done <<< "$(printf '%s\n' "${REQUIRED_PROPOSAL_SECTIONS[@]}")"
  if [ "$section_fail" -eq 0 ]; then
    pass_msg "proposal $base: all required sections present"
  else
    fail=$((fail+1))
  fi
done

echo "---"
[ "$fail" -eq 0 ]
