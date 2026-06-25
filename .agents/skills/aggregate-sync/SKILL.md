---
name: aggregate-sync
description: Use when the user types /aggregate-sync or asks the primary/coordinator machine to merge per-device KB sync outputs into global knowledge-base synthesis.
---

# Aggregate Sync

Use this skill as a thin Codex adapter for the knowledge-base `/aggregate-sync` command.

## Workflow

1. Read and follow this repository's `AGENTS.md`.
2. Read and follow `system/commands/aggregate-sync.md`.
3. Follow any procedures referenced by that command.
4. Treat the command spec as the canonical workflow. This skill should not duplicate or override it.

## Boundaries

- Run `git fetch` and `git pull --ff-only` before aggregation.
- Read device staging under `system/sync/device-ingestions/*/` and device summaries under `system/sync/device-days/*/`.
- Merge only new or changed staged source hashes into global KB synthesis.
- Update `system/sync/ingestion-ledger.yaml` only after global synthesis has incorporated the source.
- Do not delete device staging files; deduplicate with the global ledger.
- Keep external project repositories read-only.
- Stage, commit, and push only knowledge-base files changed by the aggregation pass.
