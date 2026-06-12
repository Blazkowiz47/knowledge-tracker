# Command: /auto-ingest

Detect changed project memory notes and ingest them safely.

## Steps

1. Follow `system/procedures/maintain_daily_log.md`.
2. Follow `system/procedures/automated_project_ingest.md`.
3. Keep project repositories read-only while detecting and ingesting notes.
4. If summarisation succeeds, update the relevant workstreams, daily summaries, ingestion ledger, and today's knowledge-base daily log.
5. If summarisation cannot run because of model, rate, quota, weekly-limit, or network failure, do not fabricate a summary and do not mark sources as ingested.
6. Record deferred sources in `system/sync/pending-ingestions.yaml` with enough metadata to retry later.
7. Commit and push knowledge-base changes only.
