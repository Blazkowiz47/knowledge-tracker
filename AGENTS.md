# Knowledge Tracker Instructions

This repository is the main knowledge base for the user's projects, research, experiments, development, decisions, and reusable concepts. Treat it as an Obsidian-compatible Markdown vault and as the source of truth for memory organization.

## Core Model

- `wiki/` contains maintained knowledge.
- `wiki/workstreams/` contains the active lines of work. A workstream may be a project, method, experiment family, demo, paper direction, or development effort.
- Project repositories remain outside this knowledge base. Link to them by absolute path.
- Project repositories may have their own `memory/` folder for operational, date-wise memory and project-local scratch captures.
- This knowledge base owns global synthesis, cross-project learning, daily planning, and high-level indexing.
- Individual project memories own local operational detail: daily notes, runs, devices, decisions, and project-specific learnings.

## Repository Boundary And Sync

- When operating from this knowledge-base repository, treat external project repositories as read-only by default.
- The only default exception is explicit project memory initialization: when the user asks to initialize, initialise, set up, or add memory for a project path, Codex may update only that project's memory infrastructure.
- During project memory initialization, allowed external-project edits are limited to the target project's `AGENTS.md` Knowledge Tracker memory block, `CLAUDE.md` import stub, and `memory/` files.
- Do not edit external project source code, experiment scripts, configs, data files, outputs, or unrelated documentation from a knowledge-base session.
- Do not stage, commit, or push changes in external project repositories from a knowledge-base session, including project memory initialization changes.
- If any other task would require modifying an external project repository, stop and ask the user to run Codex from that project repository or to explicitly override this boundary.
- After finishing any knowledge-base file edits, run `git status --short`.
- Stage only the knowledge-base files changed for the current task.
- Create a compact commit describing the memory, wiki, or procedure update.
- Push the current branch to its configured remote.
- If commit or push fails, report the failure and leave the repository state clear.

## Required Procedures

At the start of a knowledge-base session, or before writing any knowledge-base log entry, follow:

- `system/procedures/maintain_daily_log.md`

If the user's prompt begins with a slash command such as `/log-day`, `/summarise-day`, `/sync`, or `/check-initialisation`, read the matching command spec in:

- `system/commands/`

Codex repo-local skill adapters for these commands live in:

- `.agents/skills/`

Use command specs as shortcuts to the canonical procedures. They do not replace this `AGENTS.md` file or the procedure documents.
The skills are discoverability and invocation wrappers only; if a skill and command spec disagree, follow this file, then the command spec, then the referenced procedure.

When the user asks to initialize, initialise, set up, or add memory for a project path, follow:

- `system/procedures/initialise_project.md`

When the user asks to ingest today's work from project memories, follow:

- `system/procedures/ingest_project_day.md`

When ingestion is automated, scheduled, retried, or must handle model/rate/quota/weekly-limit fallback, follow:

- `system/procedures/automated_project_ingest.md`

When creating day, month, or year summaries across multiple devices, follow:

- `system/procedures/device_aware_summaries.md`

When the user asks to plan tomorrow from synced memories, follow:

- `system/procedures/plan_tomorrow.md`

Do not invent a different project memory structure unless the user explicitly asks to redesign the system.

## Project Memory Initialization Rules

- Existing project `AGENTS.md` files must be preserved.
- `AGENTS.md` is the canonical cross-agent instruction file.
- `CLAUDE.md` must be a regular file that imports `AGENTS.md` with `@AGENTS.md` as its first line.
- When initializing project memory from this knowledge base, ensure the target project has a `CLAUDE.md` import stub after preserving any existing Claude-only instructions below the import.
- Add or update only the clearly delimited Knowledge Tracker memory block in project `AGENTS.md`:
  - `<!-- BEGIN KNOWLEDGE TRACKER MEMORY DIRECTIVES -->`
  - `<!-- END KNOWLEDGE TRACKER MEMORY DIRECTIVES -->`
- If a project already has the block, replace only that block.
- If a project has `AGENTS.md` but no block, append the block to the end.
- If a project has no `AGENTS.md`, create one containing the block.
- If a project has an existing `CLAUDE.md`, do not discard it. Preserve unique Claude-only instructions below the `@AGENTS.md` import when safe; if the preservation is ambiguous, stop and ask the user.
- Do not remove, rewrite, reorder, or weaken existing project-specific instructions.
- Generate or maintain `memory/scratch/index.md` so project-local agents have a clear place for uncertain project-only captures and in-flight working notes.
- Scratch-only project work should stay in `memory/scratch/`; agents should not create or update a project daily note unless the scratch result is promoted, a run/decision/learning/status changes, or the user explicitly asks to log it.
- Generate or maintain project memory command specs under `memory/commands/` so project-local agents can use shortcuts such as `/remember`, `/log`, `/run`, `/decision`, `/learned`, `/status`, `/scratch`, `/organise-scratch`, and `/check-initialisation`.
- Prefer project daily notes named `memory/notes/YYYY-MM-DD-<node>.md` for new work, where `<node>` is a stable lowercase device/server slug.
- If the stable `<node>` name is not known, ask the user for it before creating or writing a new node-specific project note; do not invent generic names such as `server`, `gpu`, `desktop`, or `default`.
- Preserve backward compatibility by reading existing `memory/notes/YYYY-MM-DD.md` files as legacy/default-node notes. Continue writing an unsuffixed note only when it is already the active note for that date or the user explicitly asks to keep the legacy convention.
- Do not stage, commit, or push the target project repository after initializing memory from this knowledge base.
- Do not create Python, shell, or other executable initializer scripts for this workflow. The procedure documents are the automation contract for Codex and Claude.

## Wiki Maintenance Rules

- Read `wiki/logs/index.md` by default for recent memory before opening detailed daily logs.
- Keep `wiki/logs/index.md` compact as the default log startup surface.
- Keep detailed daily logs under `wiki/logs/YYYY/MM/DD.md`.
- Keep daily summaries in `wiki/logs/YYYY/MM/index.md`; summaries should be brief and concise, but not artificially limited to one line.
- Keep monthly summaries in `wiki/logs/YYYY/MM/summary.md` and yearly summaries in `wiki/logs/YYYY/summary.md`.
- Keep device-scoped summaries under `system/sync/device-days/<node>/`, `system/sync/device-months/<node>/`, and `system/sync/device-years/<node>/` when requested. Use `KB_NODE_NAME` as the node identity and ask the user if it is missing.
- Combined month and year summaries should use existing combined lower-level summaries when available, but must fall back to device summaries rather than forcing combined daily or monthly summaries to be created first.
- Use `Pending` for the active day, month, or year until rollover or explicit summary.
- Keep every `index.md` useful as a fast overview.
- Update `wiki/workstreams/index.md` whenever a workstream is created, renamed, archived, or meaningfully reclassified.
- Create or update the workstream folder `wiki/workstreams/<workstream-slug>/` (with `index.md`, `learnings.md`, `decisions.md`, `runs.md`, `logs.md`) for every initialized project memory. See § Workstream Folder Layout for the file responsibilities.
- Keep pages compact. Prefer durable synthesis, links, paths, and next actions over long pasted material.
- Do not paste giant logs, full papers, full transcripts, or bulky experiment output into the wiki.
- If a detail is only useful as evidence, link to the file/path where it lives and summarize the durable lesson.
- Record meaningful curation, structural changes, and daily ingestion in the current daily log under `wiki/logs/YYYY/MM/DD.md`.
- Treat project-local notes as authoritative and knowledge-base summaries as derived, refreshable state.
- If summarisation fails due to model, rate, quota, weekly-limit, network, or availability limits, defer ingestion safely rather than writing a fabricated summary.
- Use Obsidian-friendly Markdown links where useful, especially between concepts, workstreams, decisions, and questions.

## Workstream Folder Layout

Every active workstream lives in its own folder under `wiki/workstreams/<slug>/` with these files:

```text
wiki/workstreams/<slug>/
  index.md          # Context Card + Active Threads + Files links + Links
  learnings.md      # durable findings
  decisions.md      # decision ledger
  runs.md           # run highlights
  logs.md           # date-headed activity entries, newest first
```

`index.md` must preserve a compact context card near the top:

```md
## Context Card
Status:
Domain:
Tags:
Project path:
Devices/servers:
Latest useful result:
Current blocker:
Next action:
```

Update the context card first when the workstream state changes. `index.md` stays slim — the only growing surface inside it is `Active Threads`, which gets trimmed when threads close (durable outcomes move into `learnings.md` or `decisions.md`; dated activity moves into `logs.md`).

## Operating Bias

- Optimize for context recovery. The next agent session should understand the state quickly.
- Prefer one clear place over many clever places.
- If information belongs to one project, keep it in that project memory and summarize it in the relevant workstream.
- When uncertain project-only information is not ready for today's note, a run, a decision, or a learning, capture it under that project's `memory/scratch/` and route it later with `/organise-scratch`; scratch-only work does not need a project daily note.
- If information cuts across projects, summarize it in the relevant workstream indexes or drop a short capture into `wiki/scratch/` (one file per capture) until a clear home exists; `/organise-scratch` routes it at end of day.
- When uncertain where something belongs, place a short note in `wiki/scratch/` and record the uncertainty.
