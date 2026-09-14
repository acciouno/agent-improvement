#!/usr/bin/env bash
#
# check-consistency.sh — structural invariants, answered deterministically.
#
#   1. evals/regression-checklist.md matches its sha256 pin. The checklist is
#      the acceptance rule; if it can be edited silently, every other check
#      is theater. (Proposer/evaluator separation, enforced by mechanism.)
#   2. Every entry ID cited in proposals/ exists in experience-log/.
#      A proposal citing evidence that doesn't resolve is a hunch wearing
#      a citation.
#
# Usage: ./evals/check-consistency.sh   (from the repo root)
# Exit 0 when all checks pass, 1 otherwise.
#
# After an APPROVED eval change, regenerate the pin in the same commit:
#   sha256sum evals/regression-checklist.md > evals/checksums.sha256

set -u

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
fail=0

pass_msg() { echo "PASS: $1"; }
fail_msg() { echo "FAIL: $1"; fail=$((fail+1)); }

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

# 2. Evidence IDs resolve — entry IDs look like YYYY-MM-DD-NN
LOG="$ROOT/experience-log/experience-log.md"
checked=0
for f in "$ROOT"/proposals/pending/*.md "$ROOT"/proposals/approved/*.md \
         "$ROOT"/proposals/rejected/*.md "$ROOT"/proposals/EXAMPLE-proposal-format.md; do
  [ -e "$f" ] || continue
  while IFS= read -r id; do
    [ -z "$id" ] && continue
    checked=$((checked+1))
    if grep -q "^## $id" "$LOG"; then
      pass_msg "$id cited in $(basename "$f") resolves"
    else
      fail_msg "$id cited in $(basename "$f") has no log entry"
    fi
  done <<< "$(grep -oE '[0-9]{4}-[0-9]{2}-[0-9]{2}-[0-9]{2}' "$f" | sort -u)"
done
[ "$checked" -eq 0 ] && echo "NOTE: no entry IDs cited in proposals/"

echo "---"
[ "$fail" -eq 0 ]
