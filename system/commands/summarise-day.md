# Command: /summarise-day

Finalize or refresh a daily summary.

## Inputs

- Optional date. Defaults to the oldest `Pending` day; if none exists, use yesterday when available.
- Optional scope from user intent:
  - device-scoped if the user asks for "this device", "current node", or "device summary"
  - combined/global otherwise

## Steps

1. Follow `system/procedures/device_aware_summaries.md`.
2. For device-scoped summaries, resolve `KB_NODE_NAME`; ask the user for the stable node name if it is not set.
3. Read `wiki/logs/index.md` and the relevant `wiki/logs/YYYY/MM/index.md`.
4. For a combined day summary, read existing device-day summaries under `system/sync/device-days/*/YYYY-MM-DD.md` before falling back to project notes.
5. If project-memory notes are needed for that work date, confirm all matching legacy and node-specific sources have been considered:
   - `memory/notes/YYYY-MM-DD.md`
   - `memory/notes/YYYY-MM-DD-<node>.md`
6. For a device-scoped summary, write or refresh `system/sync/device-days/<node>/YYYY-MM-DD.md` and do not update the combined daily summary unless requested.
7. For a combined summary, replace the daily log's `## Summary` value with a brief, concise synthesis and update the date's row in `wiki/logs/YYYY/MM/index.md`.
8. Do not rewrite detailed `## Entries` except to fix obvious formatting.
9. If late node-specific notes or device summaries caused a historical day to be refreshed, record that refresh/backfill in the current day's knowledge-base log.
10. Commit and push knowledge-base changes only.
