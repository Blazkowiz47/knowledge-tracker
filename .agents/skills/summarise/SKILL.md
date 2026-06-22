---
name: summarise
description: Use when the user types /summarise or asks to summarize a day, month, year, pending log, current device, or current knowledge-base period.
---

# Summarise

Use this skill as a thin Codex adapter for the knowledge-base `/summarise` command.

## Workflow

1. Read and follow this repository's `AGENTS.md`.
2. Read and follow `system/commands/summarise.md`.
3. Dispatch to `system/commands/summarise-day.md`, `system/commands/summarise-month.md`, or `system/commands/summarise-year.md` as directed by the command spec.
4. Follow any procedures referenced by those commands.
5. Treat the command specs as the canonical workflow. This skill should not duplicate or override them.

## Boundaries

- Keep summaries brief and useful for future startup context.
- Use device-aware summary rules when the user asks for this device, current node, or a device summary.
- If summarisation cannot run safely, defer instead of fabricating a summary.
- After knowledge-base edits, commit and push only the knowledge-base repository according to `AGENTS.md`.
