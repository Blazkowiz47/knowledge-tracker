# Command: /aggregate-sync

Coordinator merge for conflict-safe multi-device sync.

## Purpose

Run from the primary/coordinator machine. Pull all device-staged KB sync outputs, merge new source hashes into global synthesis, and update shared KB files once.

## Steps

1. Follow `system/procedures/maintain_daily_log.md`.
2. Run `git fetch` in the knowledge-base repository.
3. Run `git pull --ff-only` before reading device staging or writing global files.
4. Read `system/sync/README.md` and follow the device-staging ownership rules.
5. Read existing device staging under:
   - `system/sync/device-ingestions/*/`
   - `system/sync/device-days/*/`
6. Compare staged source records with `system/sync/ingestion-ledger.yaml`; skip records already incorporated with the same project/source/hash.
7. For new or changed staged sources, follow `system/procedures/ingest_project_day.md` in global aggregation mode:
   - update relevant `wiki/workstreams/<workstream>/` files
   - update combined daily/month/year summaries only when requested or required by the command context
   - update `system/sync/ingestion-ledger.yaml`
   - update root-level `system/sync/pending-ingestions.yaml` only for global pending/deferred aggregation state
8. Do not delete device staging files after aggregation. Treat them as evidence and deduplicate through the global ledger.
9. Keep project repositories read-only; aggregation should not require editing external project repositories.
10. Append a compact aggregation entry to today's knowledge-base daily log.
11. Run `git status --short --branch`.
12. Stage only knowledge-base files changed by this aggregation pass.
13. If there are staged changes, create a compact commit message such as `Aggregate device sync outputs`.
14. Push the current branch to its configured remote.
15. If no new device-staged sources needed aggregation, report that global synthesis is current.
16. If fetch, pull, aggregation, commit, or push fails, report the failure and leave the repository state clear.

## Output

End with a concise report containing:

- fetch/pull result
- device nodes considered
- source records aggregated, skipped, or deferred
- files changed
- commit/push result
- any follow-up needed
