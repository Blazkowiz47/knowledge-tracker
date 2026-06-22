# Command: /sync

Refresh the knowledge base, ingest missing or changed registered project memories, then commit and push knowledge-base changes only.

## Steps

1. Follow `system/procedures/maintain_daily_log.md`.
2. Run `git fetch` in the knowledge-base repository to refresh upstream state.
3. Run `git pull --ff-only` in the knowledge-base repository before ingestion or new edits.
4. Follow `system/procedures/ingest_project_day.md` in changed-source mode: scan all reachable registered project paths from `wiki/workstreams/index.md`, compare project `memory/notes/*.md` sources with `system/sync/ingestion-ledger.yaml`, and ingest every missing or changed source unless the user named a subset.
5. If summarisation cannot be completed safely, follow `system/procedures/automated_project_ingest.md` instead of writing a low-confidence summary.
6. Keep project repositories read-only while ingesting; do not pull, stage, commit, or push external project repositories unless the user explicitly overrides that boundary.
7. Run `git status --short --branch` in the knowledge-base repository.
8. Stage only files inside the knowledge-base repository that belong to the current sync.
9. If there are staged changes, create a compact commit message describing the memory, wiki, procedure, command, or skill update.
10. Push the current branch to its configured remote.
11. If there are no changes after ingestion, report that the knowledge base is already clean.
12. If fetch, pull, ingestion, commit, or push fails, report the failure and leave the repository state clear.
