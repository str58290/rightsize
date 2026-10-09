# Shared helpers for rightsize hooks.

precheck_enabled() {
  case "$CLAUDE_PLUGIN_OPTION_AUTO_PRECHECK" in
    false|False|FALSE|0) return 1 ;;
  esac
  return 0
}

# Read the session id from the hook's JSON input on stdin, without needing jq.
# Keeps only safe filename characters.
read_session_id() {
  printf '%s' "$1" | sed -n 's/.*"session_id"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' | tr -cd 'A-Za-z0-9_-'
}

counter_dir() {
  dir="${CLAUDE_PLUGIN_DATA:-${TMPDIR:-/tmp}/rightsize}/counters"
  mkdir -p "$dir" 2>/dev/null
  printf '%s' "$dir"
}
