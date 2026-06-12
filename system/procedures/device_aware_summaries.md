# Procedure: Device-Aware Summaries

Follow this procedure when creating or refreshing day, month, or year summaries in a multi-device knowledge-base setup.

## Goal

Keep summary commands simple while allowing lazy cross-device merging. Existing summary commands remain the only interface; device-aware behavior is selected from user intent and `KB_NODE_NAME`.

## Environment

Use:

```text
KB_NODE_NAME
```

`KB_NODE_NAME` is the stable lowercase node slug for the current device or server, for example `laptop`, `oslo-laptop`, `workstation-01`, or `gpu-node-01`.

If a device-scoped summary is requested and `KB_NODE_NAME` is not set or cannot be read, ask the user for the stable node name. Do not invent generic node names.

## Summary Kinds

- Device summaries describe what one node saw or did.
- Combined summaries describe the best merged view across all available nodes.
- Combined summaries are lazy and optional at lower levels. Do not create combined daily summaries just to make a monthly or yearly summary.

## Paths

Device summaries:

```text
system/sync/device-days/<node>/YYYY-MM-DD.md
system/sync/device-months/<node>/YYYY/MM.md
system/sync/device-years/<node>/YYYY.md
```

Combined summaries:

```text
wiki/logs/YYYY/MM/DD.md
wiki/logs/YYYY/MM/summary.md
wiki/logs/YYYY/summary.md
```

## Device Summary Metadata

Device summaries should include compact metadata when useful:

```yaml
scope: device-day
node: laptop
period: 2026-05-04
sources:
  - /absolute/path/to/project/memory/notes/2026-05-04-laptop.md
last_refreshed_at:
```

Use `scope: device-month` or `scope: device-year` for month and year summaries.

## Combined Summary Coverage

Combined summaries should record coverage when the source set is incomplete or useful for future refresh:

```yaml
coverage:
  nodes: [laptop, oslo-laptop]
  missing_nodes: [workstation-01]
  source_level: combined-days-and-device-days
```

Do not pretend a combined summary has seen nodes that have not synced yet.

## Daily Summaries

When the user asks for this device's day summary:

1. Resolve the date.
2. Resolve `KB_NODE_NAME`; ask if missing.
3. Read local or synced project notes for that node and date:
   - `memory/notes/YYYY-MM-DD-<node>.md`
   - legacy `memory/notes/YYYY-MM-DD.md` only if it is clearly the active note for this node/date.
4. Write or refresh `system/sync/device-days/<node>/YYYY-MM-DD.md`.
5. Do not update the combined daily summary unless the user asked for the combined day.

When the user asks for a normal day summary:

1. Resolve the date.
2. Prefer existing device-day summaries:
   - `system/sync/device-days/*/YYYY-MM-DD.md`
3. Also use relevant project notes if device-day summaries are missing or stale.
4. Write or refresh the combined day summary:
   - `wiki/logs/YYYY/MM/DD.md`
5. Record coverage and any missing or late nodes when relevant.

## Monthly Summaries

When the user asks for this device's month summary:

1. Resolve the month.
2. Resolve `KB_NODE_NAME`; ask if missing.
3. Prefer this node's device-day summaries for the month:
   - `system/sync/device-days/<node>/YYYY-MM-DD.md`
4. Fall back to this node's project notes for days without device-day summaries.
5. Write or refresh:
   - `system/sync/device-months/<node>/YYYY/MM.md`

When the user asks for a normal month summary:

1. Resolve the month.
2. Prefer combined daily summaries where they already exist:
   - `wiki/logs/YYYY/MM/DD.md`
3. For days without combined daily summaries, use device-day summaries:
   - `system/sync/device-days/*/YYYY-MM-DD.md`
4. Also use device-month summaries if available:
   - `system/sync/device-months/*/YYYY/MM.md`
5. Write or refresh:
   - `wiki/logs/YYYY/MM/summary.md`
6. Do not create missing combined daily summaries as a prerequisite.

## Yearly Summaries

When the user asks for this device's year summary:

1. Resolve the year.
2. Resolve `KB_NODE_NAME`; ask if missing.
3. Prefer this node's device-month summaries:
   - `system/sync/device-months/<node>/YYYY/MM.md`
4. Fall back to this node's device-day summaries or project notes when needed.
5. Write or refresh:
   - `system/sync/device-years/<node>/YYYY.md`

When the user asks for a normal year summary:

1. Resolve the year.
2. Prefer combined monthly summaries where they already exist:
   - `wiki/logs/YYYY/MM/summary.md`
3. For months without combined monthly summaries, use device-month summaries:
   - `system/sync/device-months/*/YYYY/MM.md`
4. Also use device-year summaries if available:
   - `system/sync/device-years/*/YYYY.md`
5. Write or refresh:
   - `wiki/logs/YYYY/summary.md`
6. Do not create missing combined monthly or daily summaries as a prerequisite.

## Rules

- Keep command names stable; do not add new slash commands for device summaries.
- Device summaries must never be overwritten by combined summaries.
- Combined summaries can be refreshed whenever new device summaries arrive.
- Missing nodes are not an error; record partial coverage when useful.
- If summarisation fails due to model, rate, quota, weekly-limit, network, or availability limits, preserve source summaries and defer safely rather than fabricating a combined summary.
