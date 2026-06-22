---
name: organise-scratch
description: Use when the user types /organise-scratch or asks to sweep wiki scratch captures and route them to their proper knowledge-base homes.
---

# Organise Scratch

Use this skill as a thin Codex adapter for the knowledge-base `/organise-scratch` command.

## Workflow

1. Read and follow this repository's `AGENTS.md`.
2. Read and follow `system/commands/organise-scratch.md`.
3. Follow any procedures referenced by that command.
4. Treat the command spec as the canonical workflow. This skill should not duplicate or override it.

## Boundaries

- Route `wiki/scratch/` captures into the right knowledge-base location.
- Do not stage, commit, or push external project repositories, even if routing references project memory.
- Keep routing summaries compact and link to destination paths.
- After knowledge-base edits, commit and push only the knowledge-base repository according to `AGENTS.md`.
