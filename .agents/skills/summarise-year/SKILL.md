---
name: summarise-year
description: Use when the user types /summarise-year or asks to create or refresh a yearly knowledge-base summary, including device-scoped year summaries.
---

# Summarise Year

Use this skill as a thin Codex adapter for the knowledge-base `/summarise-year` command.

## Workflow

1. Read and follow this repository's `AGENTS.md`.
2. Read and follow `system/commands/summarise-year.md`.
3. Follow any procedures referenced by that command.
4. Treat the command spec as the canonical workflow. This skill should not duplicate or override it.

## Boundaries

- Prefer existing monthly summaries and device summaries before opening lower-level detail.
- Do not create missing combined monthly or daily summaries only to make a yearly summary.
- Keep the year synthesis focused on durable arcs, decisions, reusable concepts, blockers, and carryovers.
- After knowledge-base edits, commit and push only the knowledge-base repository according to `AGENTS.md`.
