# Sushrut Knowledge Base Instructions

This repository is the main knowledge base for Sushrut's Mobai work, PhD work, experiments, development, decisions, and reusable concepts. Treat it as an Obsidian-compatible Markdown vault and as the source of truth for memory organization.

## Core Model

- `wiki/` contains maintained knowledge.
- `wiki/workstreams/` contains the active lines of work. A workstream may be a project, method, experiment family, demo, paper direction, or development effort.
- Project repositories remain outside this knowledge base. Link to them by absolute path.
- Project repositories may have their own `memory/` folder for operational, date-wise memory.
- This knowledge base owns global synthesis, cross-project learning, daily planning, and high-level indexing.
- Individual project memories own local operational detail: daily notes, runs, devices, decisions, and project-specific learnings.

## Required Procedures

When the user asks to initialize, initialise, set up, or add memory for a project path, follow:

- `system/procedures/initialise_project.md`

When the user asks to ingest today's work from project memories, follow:

- `system/procedures/ingest_project_day.md`

When the user asks to plan tomorrow from synced memories, follow:

- `system/procedures/plan_tomorrow.md`

Do not invent a different project memory structure unless the user explicitly asks to redesign the system.

## Project Memory Initialization Rules

- Existing project `AGENTS.md` files must be preserved.
- `AGENTS.md` is the canonical instruction file for both Codex and Claude.
- `CLAUDE.md` must be a relative symlink to `AGENTS.md` whenever possible.
- When initializing project memory, ensure the target project has `CLAUDE.md -> AGENTS.md` as a relative symlink after preserving any existing Claude-only instructions.
- Add or update only the clearly delimited Sushrut memory block in project `AGENTS.md`:
  - `<!-- BEGIN SUSHRUT MEMORY DIRECTIVES -->`
  - `<!-- END SUSHRUT MEMORY DIRECTIVES -->`
- If a project already has the block, replace only that block.
- If a project has `AGENTS.md` but no block, append the block to the end.
- If a project has no `AGENTS.md`, create one containing the block.
- If a project has a regular `CLAUDE.md`, do not discard it. Preserve unique instructions by merging them into `AGENTS.md` when safe; if the merge is ambiguous, stop and ask the user.
- Do not remove, rewrite, reorder, or weaken existing project-specific instructions.
- Do not create Python, shell, or other executable initializer scripts for this workflow. The procedure documents are the automation contract for Codex and Claude.

## Wiki Maintenance Rules

- Keep every `index.md` useful as a fast overview.
- Update `wiki/workstreams/index.md` whenever a workstream is created, renamed, archived, or meaningfully reclassified.
- Create or update `wiki/workstreams/<workstream-slug>/index.md` for every initialized project memory.
- Keep pages compact. Prefer durable synthesis, links, paths, and next actions over long pasted material.
- Do not paste giant logs, full papers, full transcripts, or bulky experiment output into the wiki.
- If a detail is only useful as evidence, link to the file/path where it lives and summarize the durable lesson.
- Record meaningful curation, structural changes, and daily ingestion in `wiki/log.md`.
- Use Obsidian-friendly Markdown links where useful, especially between concepts, workstreams, decisions, and questions.

## Workstream Index Standard

Every active workstream `index.md` must preserve a compact context card near the top:

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

Update the context card first when the workstream state changes.

## Operating Bias

- Optimize for context recovery. The next agent session should understand the state quickly.
- Prefer one clear place over many clever places.
- If information belongs to one project, keep it in that project memory and summarize it in the relevant workstream.
- If information cuts across projects, summarize it in the relevant workstream indexes or place a short routing note in `wiki/inbox.md` until a clear home exists.
- When uncertain where something belongs, place a short note in `wiki/inbox.md` and record the uncertainty.
