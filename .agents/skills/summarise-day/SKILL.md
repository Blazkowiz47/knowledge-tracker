---
name: summarise-day
description: Use when the user types /summarise-day or asks to finalize or refresh a daily knowledge-base summary, including device-scoped day summaries.
---

# Summarise Day

Use this skill as a thin Codex adapter for the knowledge-base `/summarise-day` command.

## Workflow

1. Read and follow this repository's `AGENTS.md`.
2. Read and follow `system/commands/summarise-day.md`.
3. Follow any procedures referenced by that command.
4. Treat the command spec as the canonical workflow. This skill should not duplicate or override it.

## Boundaries

- For combined summaries, update the daily log summary and the matching month-index row.
- For device-scoped summaries, write under `system/sync/device-days/<node>/` and do not update the combined summary unless requested.
- Do not rewrite detailed daily entries except to fix obvious formatting.
- After knowledge-base edits, commit and push only the knowledge-base repository according to `AGENTS.md`.
