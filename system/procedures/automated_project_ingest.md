# Procedure: Automated Project Ingest

Follow this procedure when project memory ingestion is run by a scheduler, long-running server, or unattended agent.

## Goal

Safely detect and ingest project-local memory notes across devices without corrupting summaries when summarisation is unavailable, rate-limited, or quota-limited.

## Source Of Truth

- Project-local notes are authoritative.
- Knowledge-base summaries are derived, disposable, and refreshable.
- Never mark a source note as ingested unless the knowledge base was actually updated from it.
- Never replace an existing useful summary with a partial, low-confidence, or failed summary.
- `system/sync/ingestion-ledger.yaml` tracks source notes that were successfully synthesized.
- `system/sync/pending-ingestions.yaml` tracks detected sources that still need synthesis or review.

## Inputs

Usually:

- Known project paths from `wiki/workstreams/index.md`, future project registry files, or explicit user input
- Project notes matching:
  - `memory/notes/YYYY-MM-DD.md`
  - `memory/notes/YYYY-MM-DD-<node>.md`
- Ingestion ledger:
  - `system/sync/ingestion-ledger.yaml`
- Optional pending queue:
  - `system/sync/pending-ingestions.yaml`

## States

Use these states for automated ingestion tracking:

- `pending`: source was detected but has not been summarized into the knowledge base.
- `in_progress`: source is locked by the current runner.
- `ingested`: source was successfully summarized into the knowledge base.
- `deferred`: source was skipped because summarisation was unavailable, rate-limited, quota-limited, weekly-limit-limited, or unsafe.
- `conflict`: source needs human review because notes disagree or metadata is ambiguous.

## Safe Run Order

1. Pull or otherwise update the knowledge-base repository before writing.
2. Pull or otherwise update project repositories only if the user or infrastructure policy allows it; otherwise read the local checkout as-is.
3. Acquire a single-run lock before writing knowledge-base state. If a lock exists, stop instead of running two summarizers.
4. Discover changed or pending project notes across all reachable registered project paths.
5. Resolve each source note identity as:
   - project slug or path
   - source path
   - work date
   - node, inferred as `default` only for legacy unsuffixed notes
   - source hash or Git object ID when available
6. Compare each source against `system/sync/ingestion-ledger.yaml`; skip only sources with an `ingested` entry for the same project/source/hash.
7. Add newly discovered or changed sources to the pending queue before attempting summarisation.
8. Attempt summarisation by project and work date, merging all date-matching source notes.
9. If summarisation succeeds, update workstream pages, daily summaries, ingestion ledger, pending queue, and today's daily log.
10. If summarisation fails safely, leave existing summaries unchanged and keep or update the pending queue.
11. Release the lock and commit/push only knowledge-base changes.

## Limit And Failure Fallback

If the agent hits a model limit, rate limit, weekly limit, network failure, unavailable model, or other summarisation failure:

- Do not fabricate durable synthesis.
- Do not overwrite existing summaries.
- Do not mark the source as `ingested`.
- Mark the source as `deferred` with `reason`, `last_attempt_at`, and incremented `attempts`.
- Add or preserve a compact visibility entry only if useful, clearly labelled `Pending synthesis`.
- Retry later from `system/sync/pending-ingestions.yaml`.

Acceptable visibility-only entry:

```md
- Pending synthesis: detected `example-project` note for `2026-05-04` from node `laptop`; source at `/path/to/project/memory/notes/2026-05-04-laptop.md`.
```

This entry is not a durable summary and must not cause the source to be marked `ingested`.

## Pending Queue

Use the pending queue for sources that are detected but not yet safely synthesized:

```text
system/sync/pending-ingestions.yaml
```

Each pending item should include:

- `project`
- `work_date`
- `node`
- `source`
- `source_hash` when available
- `state`
- `reason`
- `first_seen_at`
- `last_attempt_at`
- `attempts`

If the queue file does not exist, create it from `system/sync/pending-ingestions.example.yaml`.

## Ingestion Ledger

Use the ledger for sources that were successfully synthesized:

```text
system/sync/ingestion-ledger.yaml
```

Each ingested item should include:

- `project`
- `work_date`
- `node`
- `source`
- `source_hash`
- `ingested_at`
- `state: ingested`

When a source file changes, replace the older ledger entry for the same project/source only after the refreshed summary is written.

## Rules

- Keep source notes untouched.
- Keep external project repositories read-only unless the user explicitly requested project-memory initialization or alignment.
- Prefer retryable queue updates over lossy summaries.
- Back off repeated failures instead of retrying in a tight loop.
- If notes conflict, mark the relevant queue item as `conflict` and record the uncertainty rather than silently choosing one source.
- Preserve work chronology and ingestion chronology separately: work belongs to `work_date`, while failed or successful automation attempts are logged on the current knowledge-base day.
- Do not limit discovery to today's date unless the user or scheduler explicitly requested a date-scoped run.
