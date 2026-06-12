# Procedure: Ingest Project Day

Follow this procedure when the user asks to ingest, sync, summarize, or consolidate today's project memories.

## Goal

Read date-wise project memory notes and update the main knowledge base without copying raw detail. The output should improve overview, planning, and cross-project learning.

Project-local notes are authoritative. Knowledge-base summaries are derived, disposable, and refreshable.

## Inputs

Usually:

- A date, defaulting to the current local date
- One or more project paths, or all known projects listed in `wiki/workstreams/index.md`

## Steps

1. Follow `system/procedures/maintain_daily_log.md` so today's knowledge-base daily log exists.
2. Identify candidate project notes:
   - `memory/notes/YYYY-MM-DD.md`
   - `memory/notes/YYYY-MM-DD-<node>.md`
3. Read the matching notes and the project `memory/index.md`.
4. Extract:
   - Work done
   - Experiments or runs
   - Results
   - Durable learnings
   - Decisions
   - Blockers
   - Next actions
   - Device/server/path information
5. Treat the unsuffixed `YYYY-MM-DD.md` file as the legacy/default-node source for that date.
6. Treat each suffixed `YYYY-MM-DD-<node>.md` file as an explicit node-specific source for that date.
7. Merge all date-matching sources into the date's knowledge-base summary; do not choose only the newest file.
8. Use file path plus node name as source identity. If old notes lack metadata, infer `work_date` from the filename and `node` as `default`.
9. Update the relevant `wiki/workstreams/<workstream>/index.md` context card and `Active Threads` only when those change.
10. Write extracted content into the dedicated workstream sibling files:
    - Durable findings → `wiki/workstreams/<workstream>/learnings.md` under the right subhead.
    - Decisions and their rationale → new row in `wiki/workstreams/<workstream>/decisions.md`.
    - Notable runs/evaluations → new row in `wiki/workstreams/<workstream>/runs.md`.
    - Dated activity, work done, ingestion records → a `## YYYY-MM-DD` section in `wiki/workstreams/<workstream>/logs.md` (newest first).
    Do not pile growing content back into `index.md`; keep that file slim.
11. Update `wiki/today.md` or create a date-specific daily summary if requested.
12. Append an ingestion entry to today's detailed log at `wiki/logs/YYYY/MM/DD.md`.

## Rules

- Summarize; do not copy long daily notes wholesale.
- Keep project operational detail in the project memory.
- Promote only cross-project ideas into global wiki pages.
- Preserve links and absolute paths for traceability.
- If project notes conflict, record the uncertainty instead of silently choosing one.
- Preserve both work chronology and ingestion chronology: summarize work under the source note's work date, and log late backfills on the current knowledge-base day.
- Previously summarized days may be refreshed when new node-specific notes appear later.
- If summarisation fails because of model, rate, quota, weekly-limit, network, or availability limits, do not fabricate a summary and do not mark the source as ingested.
- For failed or deferred ingestion, follow `system/procedures/automated_project_ingest.md` and record the source in `system/sync/pending-ingestions.yaml` when useful.
- Do not append detailed entries to `wiki/log.md`; it is only a pointer to `wiki/logs/index.md`.
