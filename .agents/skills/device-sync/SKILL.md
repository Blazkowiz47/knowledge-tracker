---
name: device-sync
description: Use when the user types /device-sync or asks for conflict-safe multi-device sync from a non-primary device by publishing this node's changed project memories into node-owned KB staging files.
---

# Device Sync

Use this skill as a thin Codex adapter for the knowledge-base `/device-sync` command.

## Workflow

1. Read and follow this repository's `AGENTS.md`.
2. Read and follow `system/commands/device-sync.md`.
3. Follow any procedures referenced by that command.
4. Treat the command spec as the canonical workflow. This skill should not duplicate or override it.

## Boundaries

- Resolve `KB_NODE_NAME`; ask if it is missing.
- Run `git fetch` and `git pull --ff-only` before scanning.
- Publish only this node's source records under `system/sync/device-ingestions/<node>/` and optional device summary paths.
- Do not update global synthesis files such as `wiki/logs/`, `wiki/workstreams/`, `wiki/today.md`, `system/sync/ingestion-ledger.yaml`, or root-level `system/sync/pending-ingestions.yaml`.
- Keep external project repositories read-only.
- Stage, commit, and push only this node's allowed knowledge-base staging files.
