---
name: ingest
description: Use when the user types /ingest or asks to ingest project memory notes into the knowledge base while keeping project repositories read-only.
---

# Ingest

Use this skill as a thin Codex adapter for the knowledge-base `/ingest` command.

## Workflow

1. Read and follow this repository q{'}s `AGENTS.md`.
2. Read and follow `system/commands/ingest.md`.
3. Follow any procedures referenced by that command.
4. Treat the command spec as the canonical workflow. This skill should not duplicate or override it.

## Boundaries

- Keep project repositories read-only while ingesting.
- If summarisation cannot be completed safely, follow the deferred-ingestion fallback rules.
- Do not stage, commit, or push external project repositories.
- After knowledge-base edits, commit and push only the knowledge-base repository according to `AGENTS.md`.
