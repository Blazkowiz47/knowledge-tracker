# Sync Conventions

This folder holds lightweight cross-device coordination state for the knowledge base.

## Node Identity

Each device or server should set:

```text
KB_NODE_NAME
```

Use a stable lowercase node slug, for example `laptop`, `oslo-laptop`, `workstation-01`, or `gpu-node-01`.

## Device Summaries

Device summaries are optional source summaries. They are never overwritten by combined summaries.

```text
system/sync/device-days/<node>/YYYY-MM-DD.md
system/sync/device-months/<node>/YYYY/MM.md
system/sync/device-years/<node>/YYYY.md
```

Combined summaries stay in:

```text
wiki/logs/YYYY/MM/DD.md
wiki/logs/YYYY/MM/summary.md
wiki/logs/YYYY/summary.md
```

Use `system/procedures/device_aware_summaries.md` for source selection and lazy merging rules.

## Pending Ingestion

Use `pending-ingestions.yaml` only when automation detects work that cannot be safely summarized yet. See `pending-ingestions.example.yaml`.

## Ingestion Ledger

Use `ingestion-ledger.yaml` to record project source notes that were successfully synthesized into the knowledge base. `/sync` and default `/ingest` runs compare registered project `memory/notes/*.md` files against this ledger so older missing notes and changed notes are not skipped merely because their work date is not today.
