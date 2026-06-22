---
name: sync
description: Use when the user types /sync or asks to stage, commit, and push knowledge-base memory, wiki, procedure, command, or skill updates only.
---

# Sync

Use this skill as a thin Codex adapter for the knowledge-base `/sync` command.

## Workflow

1. Read and follow this repository q{'}s `AGENTS.md`.
2. Read and follow `system/commands/sync.md`.
3. Treat the command spec as the canonical workflow. This skill should not duplicate or override it.

## Boundaries

- Stage only knowledge-base files changed for the current task.
- Do not stage, commit, or push external project repositories.
- Use a compact commit message describing the memory, wiki, procedure, command, or skill update.
- Push the current branch to its configured remote.
- If commit or push fails, report the failure and leave the repository state clear.
