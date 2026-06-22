---
name: plan-tomorrow
description: Use when the user types /plan-tomorrow or asks to create or update the next-day plan from synced knowledge-base and workstream memory.
---

# Plan Tomorrow

Use this skill as a thin Codex adapter for the knowledge-base `/plan-tomorrow` command.

## Workflow

1. Read and follow this repository q{'}s `AGENTS.md`.
2. Read and follow `system/commands/plan-tomorrow.md`.
3. Follow any procedures referenced by that command.
4. Treat the command spec as the canonical workflow. This skill should not duplicate or override it.

## Boundaries

- Use synced knowledge-base logs, `wiki/today.md`, and relevant workstream context.
- Keep plans compact, concrete, and recoverable for the next day.
- Do not stage, commit, or push external project repositories.
- After knowledge-base edits, commit and push only the knowledge-base repository according to `AGENTS.md`.
