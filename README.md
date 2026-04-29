# Sushrut Knowledge Base

This is the main memory map for Sushrut's Mobai work, PhD work, experiments, development, concepts, decisions, and daily planning.

The intended workflow is:

1. Start Codex or Claude from this knowledge base when planning, syncing, or organizing work.
2. Initialize project memories from here by giving the agent a project path.
3. Work inside individual repositories as usual.
4. Let project-level agents maintain date-wise project memory in `memory/notes/`.
5. Return here at the end of the day to ingest project memories and plan tomorrow.

The main instructions live in `AGENTS.md`.

## Main Entry Points

- `wiki/index.md` - main map
- `wiki/today.md` - current daily planning surface
- `wiki/workstreams/index.md` - active workstreams and project memories
- `system/procedures/initialise_project.md` - how agents initialize memory inside a project
- `system/procedures/ingest_project_day.md` - how agents ingest project daily notes
- `system/procedures/plan_tomorrow.md` - how agents plan the next day

## Design Principle

Project repositories keep operational memory close to the work. This knowledge base keeps the global map clean, compact, and useful.
