# Procedure: Ingest Project Day

Follow this procedure when the user asks to ingest, sync, summarize, or consolidate today's project memories.

## Goal

Read date-wise project memory notes and update the main knowledge base without copying raw detail. The output should improve overview, planning, and cross-project learning.

## Inputs

Usually:

- A date, defaulting to the current local date
- One or more project paths, or all known projects listed in `wiki/workstreams/index.md`

## Steps

1. Follow `system/procedures/maintain_daily_log.md` so today's knowledge-base daily log exists.
2. Identify candidate project notes:
   - `memory/notes/YYYY-MM-DD.md`
   - `memory/notes/YYYY-MM-DD-<device>.md`
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
5. Update the relevant `wiki/workstreams/<workstream>/index.md` context card.
6. Update or create compact sections for recent work, recent runs, learnings, decisions, blockers, and next actions.
7. Update `wiki/today.md` or create a date-specific daily summary if requested.
8. Append an ingestion entry to today's detailed log at `wiki/logs/YYYY/MM/DD.md`.

## Rules

- Summarize; do not copy long daily notes wholesale.
- Keep project operational detail in the project memory.
- Promote only cross-project ideas into global wiki pages.
- Preserve links and absolute paths for traceability.
- If project notes conflict, record the uncertainty instead of silently choosing one.
- Do not append detailed entries to `wiki/log.md`; it is only a pointer to `wiki/logs/index.md`.
