---
name: log-day
description: Use when the user types /log-day or asks to append a compact entry to today's knowledge-base daily log.
---

# Log Day

Use this skill as a thin Codex adapter for the knowledge-base `/log-day` command.

## Workflow

1. Read and follow this repository q{'}s `AGENTS.md`.
2. Read and follow `system/commands/log-day.md`.
3. Follow any procedures referenced by that command.
4. Treat the command spec as the canonical workflow. This skill should not duplicate or override it.

## Boundaries

- Write concise log entries to the active daily log under `wiki/logs/YYYY/MM/DD.md`.
- Link to relevant workstreams, paths, commits, or files instead of pasting bulky detail.
- Leave active summaries as `Pending` unless the user explicitly asks for a summary.
- After knowledge-base edits, commit and push only the knowledge-base repository according to `AGENTS.md`.
