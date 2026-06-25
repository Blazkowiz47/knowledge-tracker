# Sync Conventions

This folder holds lightweight cross-device coordination state for the knowledge base.

## Node Identity

Each device or server should set:

```text
KB_NODE_NAME
```

Use a stable lowercase node slug, for example `mobai`, `oslo-laptop`, `workstation-01`, or `a100-node-01`.

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

## Device Ingestion Staging

Device ingestion staging is the conflict-safe publishing layer between project-local notes and global KB synthesis.

```text
system/sync/device-ingestions/<node>/ledger.yaml
system/sync/device-ingestions/<node>/pending-ingestions.yaml
system/sync/device-ingestions/<node>/YYYY-MM-DD.md
```

Use these files for `/device-sync` on non-primary devices. A device may update only its own `<node>` folder. The date-named Markdown files hold compact published source records for that node; the node ledger records source notes already published to staging.

Do not delete device staging files after the coordinator has merged them. The global coordinator skips duplicate incorporation by comparing project/source/hash entries in `system/sync/ingestion-ledger.yaml`.

## Pending Ingestion

Use root-level `pending-ingestions.yaml` only for global/coordinator ingestion state. Device-local deferred sources belong under `system/sync/device-ingestions/<node>/pending-ingestions.yaml`. See `pending-ingestions.example.yaml`.

## Ingestion Ledger

Use root-level `ingestion-ledger.yaml` to record project source notes that were successfully synthesized into global knowledge-base files. `/sync`, `/ingest`, and `/aggregate-sync` compare source hashes against this ledger so older missing notes and changed notes are not skipped merely because their work date is not today.

Do not update root-level `ingestion-ledger.yaml` from `/device-sync`; node-local publishing uses `system/sync/device-ingestions/<node>/ledger.yaml`.
