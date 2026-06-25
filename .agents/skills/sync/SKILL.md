---
name: sync
description: Use when the user types /sync or asks the primary/coordinator machine to refresh the knowledge base by fetching and pulling upstream, ingesting missing or changed registered project memories into global KB state, then staging, committing, and pushing knowledge-base changes only.
---

# Sync

Use this skill as a thin Codex adapter for the knowledge-base `/sync` command. For non-primary multi-device publishing, use `$device-sync`; for the one-merger pass, use `$aggregate-sync`.

## Workflow

1. Read and follow this repository's `AGENTS.md`.
2. Read and follow `system/commands/sync.md`.
3. Treat the command spec as the canonical workflow. This skill should not duplicate or override it.

## Boundaries

- Run `git fetch` and `git pull --ff-only` before ingestion so the local knowledge base starts from upstream.
- Ingest missing or changed project memory notes from all registered projects into global KB synthesis unless the user named a subset.
- Stage only knowledge-base files changed for the current sync.
- Do not stage, commit, or push external project repositories.
- Use a compact commit message describing the memory, wiki, procedure, command, or skill update.
- Push the current branch to its configured remote.
- If fetch, pull, ingestion, commit, or push fails, report the failure and leave the repository state clear.
