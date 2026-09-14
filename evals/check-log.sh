#!/usr/bin/env bash
#
# check-log.sh — experience-log structure, answered deterministically.
#
# The contribution record ("Skills used") is what the retirement decision
# runs on, and the lesson enum is what keeps candidate lessons from rotting
# in limbo. Both were prose-only until this script. Now, for every entry:
#   1. the header is exactly "## YYYY-MM-DD-NN — <title>"
#   2. "- Lesson:" holds the closed enum: none | proposed: <file> |
#      dismissed: <reason>  ("not yet proposed" is not a value)
#   3. "- Skills used:" is present with a non-blank value (the contribution
#      record: retrieved? followed? helped / harmed / neutral)
#
# Fenced code blocks are skipped — the ## Format example must not parse as
# an entry, and a placeholder ID must never resolve as evidence.
#
# Usage: ./evals/check-log.sh   (from the repo root)
# Exit 0 when all checks pass, 1 otherwise.

set -u

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
LOG="$ROOT/experience-log/experience-log.md"
fail=0

pass_msg() { echo "PASS: $1"; }
fail_msg() { echo "FAIL: $1"; fail=$((fail+1)); }

if [ ! -f "$LOG" ]; then
  fail_msg "experience log missing: $LOG"
  echo "---"
  exit 1
fi

# Strip fenced code blocks before parsing.
unfenced="$(awk '/^```/{f=!f; next} !f' "$LOG")"

# "## " line numbers in the unfenced text.
mapfile -t hlines < <(printf '%s\n' "$unfenced" | grep -n '^## ' | cut -d: -f1)

if [ "${#hlines[@]}" -eq 0 ]; then
  echo "NOTE: no entries in experience log"
  echo "---"
  exit 0
fi

# Split headings: entry headers strictly match "## YYYY-MM-DD-NN — <title>".
# The only other permitted "## " line is the documented "## Format" section —
# anything else is a malformed entry header (or an undocumented section) and
# fails loudly rather than being silently skipped.
entry_lines=()
for ln in "${hlines[@]}"; do
  htext="$(printf '%s\n' "$unfenced" | sed -n "${ln}p")"
  if printf '%s' "$htext" | grep -qE '^## [0-9]{4}-[0-9]{2}-[0-9]{2}-[0-9]{2} — .+'; then
    entry_lines+=("$ln")
  elif [ "$htext" != "## Format" ]; then
    fail_msg "line $ln: unrecognized '## ' heading — entries must be '## YYYY-MM-DD-NN — <title>': $htext"
  fi
done

if [ "${#entry_lines[@]}" -eq 0 ]; then
  echo "NOTE: no entries in experience log"
  echo "---"
  [ "$fail" -eq 0 ]
  exit
fi

valid_lesson() {
  local lesson="$1" rest
  case "$lesson" in
    none) return 0 ;;
    "proposed: "?*) rest="${lesson#proposed: }" ;;
    "dismissed: "?*) rest="${lesson#dismissed: }" ;;
    *) return 1 ;;
  esac
  [ -n "$(printf '%s' "$rest" | tr -d '[:space:]')" ]
}

total_lines="$(printf '%s\n' "$unfenced" | wc -l)"
for start in "${entry_lines[@]}"; do
  # Entry body runs to the next "## " heading (any kind) or EOF.
  end="$total_lines"
  for hl in "${hlines[@]}"; do
    if [ "$hl" -gt "$start" ]; then end="$((hl-1))"; break; fi
  done
  header="$(printf '%s\n' "$unfenced" | sed -n "${start}p")"
  block="$(printf '%s\n' "$unfenced" | sed -n "${start},${end}p")"

  id="$(printf '%s' "$header" | grep -oE '[0-9]{4}-[0-9]{2}-[0-9]{2}-[0-9]{2}')"
  pass_msg "$id: header format ok"

  lesson="$(printf '%s\n' "$block" | grep -E '^- Lesson:' | head -1 | sed 's/^- Lesson: *//' || true)"
  if [ -z "$lesson" ]; then
    fail_msg "$id: no '- Lesson:' line"
  elif valid_lesson "$lesson"; then
    pass_msg "$id: lesson enum valid ($lesson)"
  else
    fail_msg "$id: lesson '$lesson' is not in the closed enum (none | proposed: <file> | dismissed: <reason>)"
  fi

  skills_used="$(printf '%s\n' "$block" | grep -E '^- Skills used:' | head -1 | sed 's/^- Skills used: *//' || true)"
  if [ -z "$(printf '%s' "$skills_used" | tr -d '[:space:]')" ]; then
    fail_msg "$id: no '- Skills used:' contribution record — the retirement decision runs on this data"
  else
    pass_msg "$id: skills-used record present"
  fi
done

echo "---"
[ "$fail" -eq 0 ]
