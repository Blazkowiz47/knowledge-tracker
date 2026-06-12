# Knowledge Tracker

Knowledge Tracker is a portable, Obsidian-compatible scaffold for building a personal or team knowledge base around projects, research, experiments, decisions, reusable concepts, and daily planning.

It is intentionally empty: clone it, rename it if you want, and let your own projects, logs, workstreams, and summaries grow from the templates and procedures.

## Quick Start

1. Open this repository as an Obsidian vault, or edit the Markdown files directly.
2. Set your device name with `KB_NODE_NAME`, for example `laptop` or `workstation-01`, if you want device-aware summaries.
3. Start from `wiki/index.md` and `wiki/today.md`.
4. Add active projects by following `system/procedures/initialise_project.md`.
5. Let project repositories keep detailed operational memory in their own `memory/` folders.
6. Use this knowledge base for synthesis: workstream summaries, daily logs, planning, decisions, and cross-project learning.

## Agent Workflow

The repository is designed for agents such as Codex or Claude, but it also works as plain Markdown.

When using an agent:

1. Start the agent from this knowledge-base repository when planning, syncing, or organizing work.
2. Initialize project memories from here by giving the agent a project path.
3. Work inside individual repositories as usual.
4. Let project-level agents maintain date-wise project memory in `memory/notes/`.
5. Return here at the end of the day to ingest project memories and plan tomorrow.

The main instructions live in `AGENTS.md`.

## Main Entry Points

- `wiki/index.md` - main map
- `wiki/scratch/README.md` - temporary capture area
- `wiki/today.md` - current daily planning surface
- `wiki/workstreams/index.md` - active workstreams and project memories
- `system/commands/index.md` - portable slash-command specs
- `system/procedures/initialise_project.md` - how agents initialize memory inside a project
- `system/procedures/ingest_project_day.md` - how agents ingest project daily notes
- `system/procedures/plan_tomorrow.md` - how agents plan the next day

## Privacy Model

This repository should contain reusable structure, summaries, and links, not raw private evidence. Keep sensitive project files, datasets, logs, credentials, and large outputs in their source repositories or private storage. Link to them only when appropriate.

The public scaffold ships without personal workstreams, daily history, ingestion ledgers, device summaries, or project paths.

## License

MIT. See `LICENSE`.

## Design Principle

Project repositories keep operational memory close to the work. The knowledge base keeps the global map clean, compact, and useful.
