# Procedure: Ingest Project Memories

Follow this procedure when the user asks to ingest, sync, summarize, or consolidate project memories.

## Goal

Read date-wise project memory notes and update the main knowledge base without copying raw detail. The output should improve overview, planning, and cross-project learning.

Project-local notes are authoritative. Knowledge-base summaries are derived, disposable, and refreshable.

## Inputs

Usually:

- A scope:
  - Changed-source mode: default for `/sync` and `/ingest` when no date is named.
  - Date-scoped mode: use when the user names a date or explicitly asks for today's notes.
- One or more project paths, or all registered project paths listed in `wiki/workstreams/index.md`.
- Candidate source notes:
  - `memory/notes/YYYY-MM-DD.md`
  - `memory/notes/YYYY-MM-DD-<node>.md`
- Ingestion ledger:
  - `system/sync/ingestion-ledger.yaml`
- Optional pending queue:
  - `system/sync/pending-ingestions.yaml`

## Modes

### Changed-Source Mode

Use this mode for `/sync`, `/ingest` without a named date, and requests to ingest all registered or changed project memories.

1. Read `system/sync/ingestion-ledger.yaml` if it exists.
2. Discover every reachable registered project path in `wiki/workstreams/index.md`, unless the user named a subset.
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
7. If no sources need ingestion, append a compact audit entry to today's knowledge-base log and report the knowledge base is current.

### Date-Scoped Mode

Use this mode when the user names a date or explicitly asks for today's project notes.

1. Use the requested date, or the current local date when the user explicitly says today.
2. Identify matching notes for the requested project scope only:
   - `memory/notes/YYYY-MM-DD.md`
   - `memory/notes/YYYY-MM-DD-<node>.md`
3. Merge all matching notes for the same project/date; do not choose only the newest file.
4. Update the ingestion ledger only for source notes actually summarized into the knowledge base.

## Steps

1. Follow `system/procedures/maintain_daily_log.md` so today's knowledge-base daily log exists.
2. Select changed-source mode or date-scoped mode from the user's request and command context.
3. Identify the registered project paths in scope from `wiki/workstreams/index.md`, plus any explicit project paths the user named.
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
10. Merge all date-matching sources into the date's knowledge-base summary; do not choose only the newest file.
11. Use file path plus node name as source identity. If old notes lack metadata, infer `work_date` from the filename and `node` as `default`.
12. Update the relevant `wiki/workstreams/<workstream>/index.md` context card and `Active Threads` only when those change.
13. Write extracted content into the dedicated workstream sibling files:
    - Durable findings → `wiki/workstreams/<workstream>/learnings.md` under the right subhead.
    - Decisions and their rationale → new row in `wiki/workstreams/<workstream>/decisions.md`.
    - Notable runs/evaluations → new row in `wiki/workstreams/<workstream>/runs.md`.
    - Dated activity, work done, ingestion records → a `## YYYY-MM-DD` section in `wiki/workstreams/<workstream>/logs.md` (newest first).
    Do not pile growing content back into `index.md`; keep that file slim.
14. Update `wiki/today.md` or create a date-specific daily summary if requested.
15. Update `system/sync/ingestion-ledger.yaml` for each source note successfully summarized into the knowledge base. Replace older entries for the same project/source with the new hash and `ingested_at` timestamp.
16. If a previously pending or deferred source is successfully ingested, remove or mark that pending queue entry as ingested.
17. Append an ingestion entry, refresh entry, or no-op audit entry to today's detailed log at `wiki/logs/YYYY/MM/DD.md`.

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
- If summarisation fails because of model, rate, quota, weekly-limit, network, or availability limits, do not fabricate a summary and do not mark the source as ingested.
- For failed or deferred ingestion, follow `system/procedures/automated_project_ingest.md` and record the source in `system/sync/pending-ingestions.yaml` when useful.
- Do not append detailed entries to `wiki/log.md`; it is only a pointer to `wiki/logs/index.md`.
