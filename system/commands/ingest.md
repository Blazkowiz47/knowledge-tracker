# Command: /ingest

Ingest missing, changed, or date-scoped project memory notes into the knowledge base.

## Steps

1. Follow `system/procedures/maintain_daily_log.md`.
2. Follow `system/procedures/ingest_project_day.md`.
3. If the user did not name a date, use changed-source mode: scan registered project paths, compare source notes with `system/sync/ingestion-ledger.yaml`, and ingest missing or changed notes.
4. If the user named a date, use date-scoped mode for that date and the requested project scope.
5. Keep project repositories read-only while ingesting.
6. If summarisation cannot be completed safely, follow the fallback rules in `system/procedures/automated_project_ingest.md` instead of writing a low-confidence summary.
7. Append the ingestion detail, refresh detail, audit detail, or deferred-ingestion detail to today's knowledge-base daily log.
8. Commit and push knowledge-base changes only.
