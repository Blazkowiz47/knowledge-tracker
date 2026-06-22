---
name: summarise-month
description: Use when the user types /summarise-month or asks to create or refresh a monthly knowledge-base summary, including device-scoped month summaries.
---

# Summarise Month

Use this skill as a thin Codex adapter for the knowledge-base `/summarise-month` command.

## Workflow

1. Read and follow this repository q{'}s `AGENTS.md`.
2. Read and follow `system/commands/summarise-month.md`.
3. Follow any procedures referenced by that command.
4. Treat the command spec as the canonical workflow. This skill should not duplicate or override it.

## Boundaries

- Prefer existing daily summaries and device summaries before opening detailed logs.
- Do not create missing combined daily summaries only to make a monthly summary.
- Keep the month synthesis compact and update the relevant month row when writing a combined summary.
- After knowledge-base edits, commit and push only the knowledge-base repository according to `AGENTS.md`.
