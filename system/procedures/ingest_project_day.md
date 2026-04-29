# Procedure: Ingest Project Day

Follow this procedure when the user asks to ingest, sync, summarize, or consolidate today's project memories.

## Goal

Read date-wise project memory notes and update the main knowledge base without copying raw detail. The output should improve overview, planning, and cross-project learning.

## Inputs

Usually:

- A date, defaulting to the current local date
- One or more project paths, or all known projects listed in `wiki/workstreams/index.md`

## Steps

1. Identify candidate project notes:
   - `memory/notes/YYYY-MM-DD.md`
   - `memory/notes/YYYY-MM-DD-<device>.md`
2. Read the matching notes and the project `memory/index.md`.
3. Extract:
   - Work done
   - Experiments or runs
   - Results
   - Durable learnings
   - Decisions
   - Blockers
   - Next actions
   - Device/server/path information
4. Update the relevant `wiki/workstreams/<workstream>/index.md` context card.
5. Update or create compact sections for recent work, recent runs, learnings, decisions, blockers, and next actions.
6. Update `wiki/today.md` or create a date-specific daily summary if requested.
7. Append an ingestion entry to `wiki/log.md`.

## Rules

- Summarize; do not copy long daily notes wholesale.
- Keep project operational detail in the project memory.
- Promote only cross-project ideas into global wiki pages.
- Preserve links and absolute paths for traceability.
- If project notes conflict, record the uncertainty instead of silently choosing one.
