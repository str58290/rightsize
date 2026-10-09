#!/usr/bin/env sh
# Runs at session start, resume, /clear and compaction (manual or automatic).
# Adds the pre-check note and restarts the message count for this session.

HERE="$(dirname "$0")"
. "$HERE/common.sh"

precheck_enabled || exit 0

input="$(cat)"
sid="$(read_session_id "$input")"
dir="$(counter_dir)"

if [ -n "$sid" ]; then
  echo 0 > "$dir/$sid" 2>/dev/null
fi

# Tidy up counters from sessions older than a week
find "$dir" -type f -mtime +7 -exec rm -f {} + 2>/dev/null

cat "$HERE/precheck-note.txt"
