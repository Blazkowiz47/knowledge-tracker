# Command: /summarise-month

Create or refresh a monthly summary.

## Inputs

- Optional month in `YYYY-MM` form. Defaults to the most recent completed month; if none exists, use the current month.
- Optional scope from user intent:
  - device-scoped if the user asks for "this device", "current node", or "device summary"
  - combined/global otherwise

## Steps

1. Follow `system/procedures/device_aware_summaries.md`.
2. For device-scoped summaries, resolve `KB_NODE_NAME`; ask the user for the stable node name if it is not set.
3. Read `wiki/logs/index.md`.
4. For a device-scoped month summary, prefer `system/sync/device-days/<node>/YYYY-MM-DD.md` and fall back to that node's project notes only when needed.
5. For a combined month summary, prefer combined daily summaries that already exist under `wiki/logs/YYYY/MM/DD.md`.
6. For days without combined daily summaries, fall back to device-day summaries under `system/sync/device-days/*/YYYY-MM-DD.md`.
7. Also use device-month summaries under `system/sync/device-months/*/YYYY/MM.md` when available.
8. Do not create missing combined daily summaries just to make a monthly summary.
9. Update the target summary with a compact synthesis of the month:
   - major workstreams touched
   - durable decisions or protocol changes
   - important blockers or next actions
10. For device-scoped summaries, write `system/sync/device-months/<node>/YYYY/MM.md`.
11. For combined summaries, write `wiki/logs/YYYY/MM/summary.md` and update the month row in `wiki/logs/index.md`.
12. Commit and push knowledge-base changes only.
