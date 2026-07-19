#!/usr/bin/env bash
set -euo pipefail

# Non-coordinator device schedule template.
# Run each device before the coordinator aggregation and summary window.
# Example:
# - gpu-node: 15:40 daily, 20 minutes before the coordinator.
# - laptop-node: 15:50 daily, 10 minutes before the coordinator.
# The coordinator runs aggregation and combined summarisation separately.
#
# Example crontab entries:
#   40 15 * * * KB_NODE_NAME=gpu-node KB_COORDINATOR_NODE=main-laptop /path/to/knowledge-tracker/.codex/automations/run-evening-sync-summarise.sh
#   50 15 * * * KB_NODE_NAME=laptop-node KB_COORDINATOR_NODE=main-laptop /path/to/knowledge-tracker/.codex/automations/run-evening-sync-summarise.sh

timestamp() {
  date '+%Y-%m-%dT%H:%M:%S%z'
}

normalize_node() {
  printf '%s' "$1" | tr '[:upper:]' '[:lower:]' | tr -c 'a-z0-9_-' '-'
}

SCRIPT_DIR="$(CDPATH= cd "$(dirname "$0")" && pwd -P)"
REPO_DIR="$(CDPATH= cd "$SCRIPT_DIR/../.." && pwd -P)"
CODEX_BIN="${CODEX_BIN:-}"
PROMPT_FILE="$SCRIPT_DIR/evening-sync-summarise.prompt.md"
LOG_DIR="$REPO_DIR/.tmp/codex-automations"
LOCK_DIR="$LOG_DIR/automation.lock"
LOCK_PID_FILE="$LOCK_DIR/pid"
RUN_LOG="$LOG_DIR/evening-sync-summarise.log"

if [ -z "${HOME:-}" ]; then
  printf '%s\n' "HOME is not set; cannot locate CODEX_HOME for Codex automation." >&2
  exit 1
fi

export HOME
export CODEX_HOME="${CODEX_HOME:-$HOME/.codex}"
export PATH="/usr/local/bin:/opt/homebrew/bin:/usr/bin:/bin:/usr/sbin:/sbin:${PATH:-}"

if [ -z "$CODEX_BIN" ]; then
  CODEX_BIN="$(command -v codex 2>/dev/null || true)"
fi
if [ -z "$CODEX_BIN" ] || [ ! -x "$CODEX_BIN" ]; then
  printf '%s\n' "Set CODEX_BIN to an executable Codex CLI path." >&2
  exit 1
fi

COORDINATOR_NODE="$(normalize_node "${KB_COORDINATOR_NODE:-main-laptop}")"
NODE_NAME="${KB_NODE_NAME:-}"
if [ -z "$NODE_NAME" ] && command -v hostname >/dev/null 2>&1; then
  NODE_NAME="$(hostname -s 2>/dev/null || hostname 2>/dev/null || true)"
fi
NODE_NAME="$(normalize_node "${NODE_NAME:-}")"

if [ -z "$NODE_NAME" ]; then
  printf '%s\n' "Set KB_NODE_NAME before running this non-coordinator automation." >&2
  exit 1
fi

if [ "$NODE_NAME" = "$COORDINATOR_NODE" ]; then
  printf '%s %s\n' "$(timestamp)" "$NODE_NAME is the KB coordinator; use coordinator aggregation automation instead of this non-coordinator wrapper"
  exit 0
fi

export KB_NODE_NAME="$NODE_NAME"
export KB_COORDINATOR_NODE="$COORDINATOR_NODE"

mkdir -p "$LOG_DIR"
if ! mkdir "$LOCK_DIR" 2>/dev/null; then
  existing_pid="$(sed -n '1p' "$LOCK_PID_FILE" 2>/dev/null || true)"
  if [ -n "$existing_pid" ] && kill -0 "$existing_pid" 2>/dev/null; then
    printf '%s %s\n' "$(timestamp)" "another Knowledge Tracker automation is already running"
    exit 0
  fi
  rm -f "$LOCK_PID_FILE"
  if ! rmdir "$LOCK_DIR" 2>/dev/null || ! mkdir "$LOCK_DIR" 2>/dev/null; then
    printf '%s %s\n' "$(timestamp)" "could not recover stale automation lock" >&2
    exit 1
  fi
fi
printf '%s\n' "$$" > "$LOCK_PID_FILE"
cleanup() {
  rm -f "$LOCK_PID_FILE"
  rmdir "$LOCK_DIR" 2>/dev/null || true
}
trap cleanup EXIT
trap 'exit 129' HUP
trap 'exit 130' INT
trap 'exit 143' TERM

if [ -f "$RUN_LOG" ] && [ "$(wc -c < "$RUN_LOG")" -gt 5242880 ]; then
  mv "$RUN_LOG" "$RUN_LOG.1"
fi

{
  printf '\n=== %s evening device sync (%s) ===\n' "$(timestamp)" "$KB_NODE_NAME"
  "$CODEX_BIN" \
    --ask-for-approval never \
    exec \
    -C "$REPO_DIR" \
    --sandbox danger-full-access \
    -o "$LOG_DIR/evening-sync-summarise-last.md" \
    - < "$PROMPT_FILE"
} >> "$RUN_LOG" 2>&1
