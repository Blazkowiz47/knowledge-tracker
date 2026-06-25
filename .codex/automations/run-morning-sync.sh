#!/usr/bin/env bash
set -euo pipefail

# Non-coordinator device schedule template.
# Run each device before the coordinator aggregation window.
# Example:
# - gpu-node: 03:40 daily, 20 minutes before the coordinator.
# - laptop-node: 03:50 daily, 10 minutes before the coordinator.
# The coordinator should run aggregation separately instead of this wrapper.
#
# Example crontab entries:
#   40 3 * * * KB_NODE_NAME=gpu-node KB_COORDINATOR_NODE=main-laptop /path/to/knowledge-tracker/.codex/automations/run-morning-sync.sh
#   50 3 * * * KB_NODE_NAME=laptop-node KB_COORDINATOR_NODE=main-laptop /path/to/knowledge-tracker/.codex/automations/run-morning-sync.sh

timestamp() {
  date '+%Y-%m-%dT%H:%M:%S%z'
}

normalize_node() {
  printf '%s' "$1" | tr '[:upper:]' '[:lower:]' | tr -c 'a-z0-9_-' '-'
}

SCRIPT_DIR="$(CDPATH= cd "$(dirname "$0")" && pwd -P)"
REPO_DIR="$(CDPATH= cd "$SCRIPT_DIR/../.." && pwd -P)"
CODEX_BIN="${CODEX_BIN:-/usr/local/bin/codex}"
PROMPT_FILE="$SCRIPT_DIR/morning-sync.prompt.md"
LOG_DIR="$REPO_DIR/.tmp/codex-automations"
LOCK_DIR="$LOG_DIR/automation.lock"

if [ -z "${HOME:-}" ]; then
  printf '%s\n' "HOME is not set; cannot locate CODEX_HOME for Codex automation." >&2
  exit 1
fi

export HOME
export CODEX_HOME="${CODEX_HOME:-$HOME/.codex}"
export PATH="/usr/local/bin:/opt/homebrew/bin:/usr/bin:/bin:/usr/sbin:/sbin:${PATH:-}"

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
  printf '%s %s\n' "$(timestamp)" "another Knowledge Tracker automation is already running"
  exit 0
fi
trap 'rmdir "$LOCK_DIR"' EXIT

{
  printf '\n=== %s morning device sync (%s) ===\n' "$(timestamp)" "$KB_NODE_NAME"
  "$CODEX_BIN" \
    --ask-for-approval never \
    exec \
    -C "$REPO_DIR" \
    --sandbox danger-full-access \
    -o "$LOG_DIR/morning-sync-last.md" \
    - < "$PROMPT_FILE"
} >> "$LOG_DIR/morning-sync.log" 2>&1
