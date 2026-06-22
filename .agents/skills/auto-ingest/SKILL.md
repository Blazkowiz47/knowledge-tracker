---
name: auto-ingest
description: Use when the user types /auto-ingest or asks to detect changed project memory notes and ingest them into the knowledge base with safe deferred fallback.
---

# Auto Ingest

Use this skill as a thin Codex adapter for the knowledge-base `/auto-ingest` command.

## Workflow

1. Read and follow this repository's `AGENTS.md`.
2. Read and follow `system/commands/auto-ingest.md`.
3. Follow any procedures referenced by that command.
4. Treat the command spec as the canonical workflow. This skill should not duplicate or override it.

## Boundaries

- Keep external project repositories read-only while detecting and ingesting notes.
- Do not stage, commit, or push external project repositories.
- If summarisation cannot run safely, defer ingestion instead of fabricating a summary.
- After knowledge-base edits, commit and push only the knowledge-base repository according to `AGENTS.md`.
