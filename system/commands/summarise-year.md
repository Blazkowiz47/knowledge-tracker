# Command: /summarise-year

Internal compatibility primitive. Prefer `/review` unless a year-only refresh is explicitly needed.

Create or refresh a yearly summary.

## Inputs

- Optional year. Defaults to the most recent completed year; if none exists, use the current year.
- Optional scope from user intent:
  - device-scoped if the user asks for "this device", "current node", or "device summary"
  - combined/global otherwise

## Steps

1. Follow `system/procedures/device_aware_summaries.md`.
2. For device-scoped summaries, resolve `KB_NODE_NAME`; ask the user for the stable node name if it is not set.
3. Read `wiki/logs/index.md`.
4. For a device-scoped year summary, prefer `system/sync/device-months/<node>/YYYY/MM.md` and fall back to that node's device-day summaries or project notes only when needed.
5. For a combined year summary, prefer combined monthly summaries that already exist under `wiki/logs/YYYY/*/summary.md`.
6. For months without combined monthly summaries, fall back to device-month summaries under `system/sync/device-months/*/YYYY/MM.md`.
7. Also use device-year summaries under `system/sync/device-years/*/YYYY.md` when available.
8. Do not create missing combined monthly or daily summaries just to make a yearly summary.
9. Update the target summary with a concise synthesis of the year:
   - major research, development, and writing arcs
   - durable decisions and reusable concepts
   - unresolved blockers and next-year carryovers
10. For device-scoped summaries, write `system/sync/device-years/<node>/YYYY.md`.
11. For combined summaries, write `wiki/logs/YYYY/summary.md` and update the year row in `wiki/logs/index.md` if needed.
12. Commit and push knowledge-base changes only.
