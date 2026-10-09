#!/usr/bin/env sh
# Runs on every message you send. Counts messages in this session and
# re-adds the pre-check note every N messages (default 15), so the note
# never drifts too far back in a long conversation. On other messages it
# adds nothing, so they cost no extra tokens.

HERE="$(dirname "$0")"
. "$HERE/common.sh"

precheck_enabled || exit 0

every="${CLAUDE_PLUGIN_OPTION_REFRESH_EVERY:-15}"
case "$every" in
  ''|*[!0-9]*) every=15 ;;
esac
[ "$every" -eq 0 ] && exit 0

input="$(cat)"
sid="$(read_session_id "$input")"
[ -z "$sid" ] && exit 0

file="$(counter_dir)/$sid"
count="$(cat "$file" 2>/dev/null)"
case "$count" in
  ''|*[!0-9]*) count=0 ;;
esac
count=$((count + 1))

if [ "$count" -ge "$every" ]; then
  echo 0 > "$file"
  cat "$HERE/precheck-note.txt"
else
  echo "$count" > "$file"
fi
