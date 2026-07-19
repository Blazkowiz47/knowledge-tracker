# Procedure: Ingest Project Memories

Follow this procedure when the user asks to ingest, sync, summarize, or consolidate project memories.

## Goal

Read date-wise project memory notes and update the main knowledge base without copying raw detail. The output should improve overview, planning, and cross-project learning.

Project-local notes are authoritative. Knowledge-base summaries are derived, disposable, and refreshable.

## Inputs

Usually:

- A scope:
  - Global changed-source mode: default for `/sync` and `/ingest` on the primary/coordinator when no date is named.
  - Device-staging changed-source mode: default for `/device-sync` on non-primary devices.
  - Global aggregation mode: default for `/aggregate-sync` when consuming device staging.
  - Date-scoped mode: use when the user names a date or explicitly asks for today's notes.
- One or more project paths, or all sync-enabled paths in `system/registry/projects.yaml`.
- Candidate source notes:
  - `memory/notes/YYYY-MM-DD.md`
  - `memory/notes/YYYY-MM-DD-<node>.md`
- Ingestion ledger:
  - `system/sync/ingestion-ledger.yaml`
- Device-local ingestion staging:
  - `system/sync/device-ingestions/<node>/ledger.yaml`
  - `system/sync/device-ingestions/<node>/pending-ingestions.yaml`
  - `system/sync/device-ingestions/<node>/YYYY-MM-DD.md`
- Optional pending queue:
  - `system/sync/pending-ingestions.yaml`

## Modes

### Global Changed-Source Mode

Use this mode for `/sync`, `/ingest` without a named date, and requests to ingest all registered or changed project memories into global KB synthesis on the primary/coordinator machine.

1. Read `system/sync/ingestion-ledger.yaml` if it exists.
2. Resolve the canonical node and discover reachable sync-enabled paths from `system/registry/projects.yaml`, unless the user named a subset.
3. For each reachable project, scan all matching `memory/notes/*.md` source notes.
4. For each source, resolve:
   - project slug or registered workstream
   - source path
   - `work_date` from the filename
   - node from the filename suffix, using `default` only for legacy unsuffixed notes
   - source hash from the file content
5. A source needs ingestion when:
   - no `ingested` ledger entry exists for the same project/source/hash, or
   - a prior ledger entry for the same project/source has a different hash, or
   - it is present in `pending-ingestions.yaml` with `pending`, `deferred`, or `conflict` state and can now be safely handled, or
   - the user explicitly asks to refresh or re-ingest it.
6. Group sources by project and `work_date`. When one source for a project/date needs ingestion, read all source notes for that same project/date so node-specific notes merge coherently.
7. If no sources need ingestion, update operational status and report current without creating a human log.

### Device-Staging Changed-Source Mode

Use this mode for `/device-sync` and non-primary multi-device automation.

1. Resolve `KB_NODE_NAME`; ask the user for the stable node slug if it is missing.
2. Read `system/sync/device-ingestions/<node>/ledger.yaml` if it exists.
3. Discover reachable sync-enabled paths for this node from `system/registry/projects.yaml`, unless the user named a subset.
4. For each reachable project, scan all matching `memory/notes/*.md` source notes that belong to this node or are legacy/default-node notes visible from this node.
5. Resolve project slug, source path, work date, node, and source hash as in global changed-source mode.
6. A source needs device publishing when no `published` entry exists in the node ledger for the same project/source/hash, the prior node-ledger entry for that project/source has a different hash, it is present in the node pending queue, or the user explicitly asks to refresh it.
7. For each changed source, write or refresh a compact source record in `system/sync/device-ingestions/<node>/YYYY-MM-DD.md`, grouped by source `work_date`. Include project, source path, source hash, source node, published timestamp, and a concise synthesis of the source note.
8. Update `system/sync/device-ingestions/<node>/ledger.yaml` for each source successfully published to staging. Use `state: published`, not `state: ingested`, because global synthesis has not necessarily consumed it yet.
9. Use `system/sync/device-ingestions/<node>/pending-ingestions.yaml` for detected sources that cannot be safely summarized into staging.
10. Do not update `wiki/logs/`, `wiki/workstreams/`, `wiki/today.md`, `system/sync/ingestion-ledger.yaml`, or root-level `system/sync/pending-ingestions.yaml` in this mode.
11. If no sources need device publishing, report that this node's staging is current without writing a global daily-log audit entry.

### Global Aggregation Mode

Use this mode for `/aggregate-sync` and the one-merger workflow.

1. Read `system/sync/ingestion-ledger.yaml` if it exists.
2. Read device staging under `system/sync/device-ingestions/*/` and device day summaries under `system/sync/device-days/*/` when relevant.
3. For each staged source record, compare project/source/hash with the global ingestion ledger.
4. A staged source needs aggregation when no global `ingested` entry exists for the same project/source/hash, the global entry for the same project/source has a different hash, or the source is in the global pending queue and can now be handled.
5. Group staged records by project and `work_date`, merging node-specific records coherently.
6. Update global workstream files, daily summaries, and global ledgers using the same synthesis rules as global changed-source mode.
7. Do not delete device staging files after successful aggregation; the global ledger prevents duplicate incorporation.

### Date-Scoped Mode

Use this mode when the user names a date or explicitly asks for today's project notes.

1. Use the requested date, or the current local date when the user explicitly says today.
2. Identify matching notes for the requested project scope only:
   - `memory/notes/YYYY-MM-DD.md`
   - `memory/notes/YYYY-MM-DD-<node>.md`
3. Merge all matching notes for the same project/date; do not choose only the newest file.
4. Update the ingestion ledger only for source notes actually summarized into the knowledge base.

## Steps

1. Do not create a human log before discovery. Follow `maintain_daily_log.md` only after meaningful global synthesis or a failure requiring attention.
2. Select changed-source mode or date-scoped mode from the user's request and command context.
3. Identify project paths from `system/registry/projects.yaml`, plus explicit paths the user named.
4. Keep project repositories read-only. If a registered path is unreachable on the current device, skip it and record that in the audit entry when useful.
5. Identify candidate source notes according to the selected mode.
6. Read the selected notes and each project `memory/index.md`.
7. Extract:
   - Work done
   - Experiments or runs
   - Results
   - Durable learnings
   - Decisions
   - Blockers
   - Next actions
   - Device/server/path information
8. Treat the unsuffixed `YYYY-MM-DD.md` file as the legacy/default-node source for that date.
9. Treat each suffixed `YYYY-MM-DD-<node>.md` file as an explicit node-specific source for that date.
10. Merge all date-matching sources into the date's knowledge-base summary or, in device-staging mode, into the node-owned staging record; do not choose only the newest file.
11. Use file path plus node name as source identity. If old notes lack metadata, infer `work_date` from the filename and `node` as `default`.
12. In global modes, update the relevant `wiki/workstreams/<workstream>/index.md` context card and `Active Threads` only when those change. In device-staging mode, do not update workstream pages.
13. In global modes, write extracted content into the dedicated workstream sibling files:
    - Durable findings → `wiki/workstreams/<workstream>/learnings.md` under the right subhead.
    - Decisions and their rationale → new row in `wiki/workstreams/<workstream>/decisions.md`.
    - Notable runs/evaluations → new row in `wiki/workstreams/<workstream>/runs.md`.
    - Dated activity, work done, ingestion records → a `## YYYY-MM-DD` section in `wiki/workstreams/<workstream>/logs.md` (newest first).
    Do not pile growing content back into `index.md`; keep that file slim.
14. In global modes, update `wiki/today.md` or create a date-specific daily summary if requested. In device-staging mode, keep output under the current node's staging and device-summary paths.
15. Update `system/sync/ingestion-ledger.yaml` for each source note successfully summarized into global knowledge-base files. Replace older entries for the same project/source with the new hash and `ingested_at` timestamp. In device-staging mode, update only `system/sync/device-ingestions/<node>/ledger.yaml` with `published_at` and `state: published`.
16. If a previously pending or deferred source is successfully ingested or published, remove or mark the matching pending queue entry as ingested/published in the correct global or node-local queue.
17. Append human logs only for meaningful ingestion, refreshed synthesis, or failures requiring attention. Record no-op audits in operational status.

## Rules

- Summarize; do not copy long daily notes wholesale.
- Keep project operational detail in the project memory.
- Promote only cross-project ideas into global wiki pages.
- Preserve links and absolute paths for traceability.
- If project notes conflict, record the uncertainty instead of silently choosing one.
- Preserve both work chronology and ingestion chronology: summarize work under the source note's work date, and log late backfills on the current knowledge-base day.
- Previously summarized days may be refreshed when new node-specific notes appear later.
- Do not skip an older source note merely because its `work_date` is not today; changed-source mode must find missing or changed historical notes.
- Never mark a source note as ingested unless the knowledge base was actually updated from it or a deliberate refresh confirmed that the existing summary already covers the same source hash.
- Never mark a source note as globally ingested merely because `/device-sync` published it to node staging.
- Device-staging mode owns only `system/sync/device-ingestions/<node>/` and optional device summary paths for the current node.
- Global aggregation and primary `/sync` own shared synthesis files and root-level ledgers.
- If summarisation fails because of model, rate, quota, weekly-limit, network, or availability limits, do not fabricate a summary and do not mark the source as ingested.
- For failed or deferred ingestion, follow `system/procedures/automated_project_ingest.md` and record the source in `system/sync/pending-ingestions.yaml` when useful.
- Do not append detailed entries to `wiki/log.md`; it is only a pointer to `wiki/logs/index.md`.
