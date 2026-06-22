# Knowledge Tracker

Knowledge Tracker is a portable, Obsidian-compatible scaffold for building a personal or team knowledge base around projects, research, experiments, decisions, reusable concepts, and daily planning.

It is intentionally empty: clone it, rename it if you want, and let your own projects, logs, workstreams, and summaries grow from the templates and procedures.

## Quick Start

1. Fork this repository or clone it into a new private repository.
2. Open the repository as an Obsidian vault, or edit the Markdown files directly.
3. Set your device name with `KB_NODE_NAME`, for example `laptop` or `workstation-01`, if you want device-aware summaries.
4. Start from `wiki/index.md` and `wiki/today.md`.
5. Add active projects by following `system/procedures/initialise_project.md`.
6. Let project repositories keep detailed operational memory in their own `memory/` folders.
7. Use this knowledge base for synthesis: workstream summaries, daily logs, planning, decisions, and cross-project learning.

## Use This Template

This scaffold is meant to become your own private knowledge base. The template itself should stay reusable and empty; your fork or clone is where personal logs, project paths, workstreams, and decisions should live.

### Option A: Fork On GitHub

1. Fork the repository.
2. Make your fork private if you plan to store personal or company context.
3. Clone your fork:

   ```sh
   git clone git@github.com:<you>/<your-knowledge-base>.git
   cd <your-knowledge-base>
   ```

4. Optional: rename the repository to something personal, such as `knowledge-base`, `research-memory`, or `work-brain`.
5. Open the folder in Obsidian, Codex, Claude Code, or your editor.

### Option B: Clone Without Forking

```sh
git clone git@github.com:<source-org>/knowledge-tracker.git my-knowledge-base
cd my-knowledge-base
git remote remove origin
git remote add origin git@github.com:<you>/<private-repo>.git
git push -u origin main
```

Use this when you want a clean private repository that starts from the template without retaining a fork relationship.

### First Personalization Pass

1. Replace placeholder wording in `wiki/index.md` and `wiki/today.md`.
2. Keep `AGENTS.md` as the canonical instruction file for agents.
3. Keep `CLAUDE.md` as a tiny Claude Code import file:

   ```md
   @AGENTS.md
   ```

   Add Claude-specific notes below that line only if you need them.

4. Set a stable device name before writing device-aware notes:

   ```sh
   export KB_NODE_NAME=work-laptop
   ```

5. Commit your first personalized version:

   ```sh
   git add .
   git commit -m "Initialize personal knowledge tracker"
   git push
   ```

## Agent Workflow

The repository is designed for agents such as Codex or Claude, but it also works as plain Markdown.

When using an agent:

1. Start the agent from this knowledge-base repository when planning, syncing, or organizing work.
2. Initialize project memories from here by giving the agent a project path.
3. Work inside individual repositories as usual.
4. Let project-level agents maintain date-wise project memory in `memory/notes/`.
5. Optionally connect project memory to external systems through `memory/integrations/`, keeping local memory canonical and using drafts when tools are unavailable.
6. Return here at the end of the day and use `/sync` to pull the knowledge base, ingest project memories, and push the updated knowledge base before planning tomorrow.

The main instructions live in `AGENTS.md`.

Repo-local Codex skill adapters live in `.agents/skills/`. They expose the same workflows as the command specs, such as `/log-day`, `/ingest`, `/check-initialisation`, `/summarise`, `/plan-tomorrow`, and `/sync`, while keeping `AGENTS.md` and `system/commands/` as the canonical instructions.

## Main Entry Points

- `wiki/index.md` - main map
- `wiki/scratch/README.md` - temporary capture area
- `wiki/today.md` - current daily planning surface
- `wiki/workstreams/index.md` - active workstreams and project memories
- `.agents/skills/` - repo-local Codex skill adapters for the command workflows
- `system/commands/index.md` - portable slash-command specs
- `system/templates/project-integrations-index.md` - optional project integration scaffold, including Jira and Confluence patterns
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
