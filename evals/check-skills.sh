#!/usr/bin/env bash
#
# check-skills.sh — regression check 4, answered deterministically.
#
# Verifies every `active` skill in skills/_index.md:
#   1. the skill file exists
#   2. it contains every required template section (line-anchored match —
#      renaming a heading must fail, not just deleting one)
#   3. Provenance names a Created and a Last-validated date
#   4. it is inside its review window (Next review >= today); a blank
#      Next review on an active skill is a FAIL, not a skip
#   5. the active skill count is within the cap (12)
#
# Usage: ./evals/check-skills.sh   (from the repo root)
# Exit 0 when all checks pass, 1 otherwise. Nothing is silently skipped:
# the only SKIP left is "no active skills at all" (nothing to verify).

set -u

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
INDEX="$ROOT/skills/_index.md"
TODAY="$(date +%F)"

REQUIRED_SECTIONS=(
  "## Purpose"
  "## Trigger conditions"
  "## Procedure"
  "## Depends on / conflicts with"
  "## How to tell it's working"
  "## Intended executor"
  "## Provenance"
  "## Changelog"
  "## Known limits"
)

pass=0
fail=0
skipped=0

pass_msg() { echo "PASS: $1"; pass=$((pass+1)); }
fail_msg() { echo "FAIL: $1"; fail=$((fail+1)); }
skip_msg() { echo "SKIP: $1"; skipped=$((skipped+1)); }

if [ ! -f "$INDEX" ]; then
  echo "FAIL: registry not found: $INDEX"
  exit 1
fi

# Registry columns: | Skill | Status | Last validated | Next review | Notes |
active_rows="$(grep -E '^\|.*\| *active *\|' "$INDEX" || true)"

if [ -z "$active_rows" ]; then
  skip_msg "no active skills in registry — nothing to verify"
fi

while IFS= read -r row; do
  [ -z "$row" ] && continue
  name="$(echo "$row" | grep -oE '\[[^]]+\]' | head -1 | tr -d '[]')"
  file="$(echo "$row" | grep -oE '\([^)]*\.skill\.md\)' | head -1 | tr -d '()')"
  next_review="$(echo "$row" | awk -F'|' '{gsub(/ /,"",$5); print $5}')"

  if [ -z "$file" ]; then
    fail_msg "$name: no skill file linked in registry row"
    continue
  fi

  path="$ROOT/skills/$file"
  if [ ! -f "$path" ]; then
    fail_msg "$name: file missing: skills/$file"
    continue
  fi
  pass_msg "$name: file exists"

  section_fail=0
  for section in "${REQUIRED_SECTIONS[@]}"; do
    # Line-anchored fixed-string match on whitespace-stripped lines: the
    # heading must BE the section line. A substring match lets "## Known
    # limits" be renamed to "## Known limits (renamed)" — or demoted to a
    # sentence — and still pass. That must fail.
    if ! sed 's/[[:space:]]*$//' "$path" | grep -qxF -- "$section"; then
      echo "FAIL: $name: missing section: $section"
      section_fail=1
    fi
  done
  if [ "$section_fail" -eq 0 ]; then
    pass_msg "$name: all required sections present"
  else
    fail=$((fail+1))
  fi

  if grep -q "Created:" "$path" && grep -q "Last validated:" "$path"; then
    pass_msg "$name: provenance has Created and Last-validated dates"
  else
    fail_msg "$name: provenance missing Created and/or Last-validated date"
  fi

  if [ -z "$next_review" ]; then
    # A blank review date on an ACTIVE skill used to SKIP — and skips never
    # reached the exit code, so CI read it as a pass. The window is required
    # and derivable; missing means FAIL. (The checklist's own words: a silent
    # skip is a false pass.)
    fail_msg "$name: blank Next review date — the review window is required for active skills, not optional"
  elif [[ "$next_review" < "$TODAY" ]]; then
    fail_msg "$name: past review date ($next_review < $TODAY) — revalidate, revise, or retire"
  else
    pass_msg "$name: inside review window (next review $next_review)"
  fi
done <<< "$active_rows"

# The cap is the brake on unbounded library drift (the paper's mechanism
# against it). The registry already states it; now it's counted.
CAP=12
active_count="$(printf '%s\n' "$active_rows" | grep -c . || true)"
if [ "$active_count" -gt "$CAP" ]; then
  fail_msg "active skill count $active_count exceeds cap $CAP — displace an incumbent or justify growing the cap (human decision)"
else
  pass_msg "active skill count $active_count within cap $CAP"
fi

echo "---"
echo "pass=$pass fail=$fail skipped=$skipped"
[ "$fail" -eq 0 ]
