# Command: /ingest

Ingest project memory notes into the knowledge base.

## Steps

1. Follow `system/procedures/maintain_daily_log.md`.
2. Follow `system/procedures/ingest_project_day.md`.
3. Keep project repositories read-only while ingesting.
4. If summarisation cannot be completed safely, follow the fallback rules in `system/procedures/automated_project_ingest.md` instead of writing a low-confidence summary.
5. Append the ingestion detail, refresh detail, or deferred-ingestion detail to today's knowledge-base daily log.
6. Commit and push knowledge-base changes only.
