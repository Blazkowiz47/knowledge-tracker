# Knowledge Tracker Instructions

This repository is an Obsidian-compatible knowledge base for projects, research, experiments, decisions, reusable concepts, and planning.

## Canonical Layers

- External project repositories own operational truth in their project-local `memory/` folders.
- `wiki/workstreams/<slug>/` owns compact, derived synthesis for one line of work.
- `wiki/logs/` records meaningful knowledge and human activity, not routine automation telemetry.
- `wiki/today.md` is a generated daily brief, refreshed through `/day start`.
- `wiki/scratch/` is the knowledge-base inbox for captures whose final destination is uncertain.
- `system/registry/` owns machine-readable project and node identity.
- `system/sync/` owns device staging, ledgers, pending work, per-node status, and the coordinator status view.

Project memory is authoritative. Knowledge-base synthesis is derived and may be refreshed when source notes change.

## Repository Boundary

- Treat external project repositories as read-only by default.
- The default write exceptions are explicit project-memory initialization and initialization checks. Those workflows may edit only the target project's marked `AGENTS.md` memory block, `CLAUDE.md` import stub, `memory/`, `.agents/skills/`, and `.claude/skills/`.
- Public knowledge-base commands write only inside this repository unless the user explicitly authorizes a named external-project write.
- Never edit external project source, configs, datasets, outputs, or unrelated documentation from a knowledge-base task.
- Never stage, commit, or push an external project repository unless the user explicitly overrides this boundary for that repository.

After knowledge-base edits, run `git status --short`, stage only current-task files, create a compact commit, and push the current branch. Report failures and leave the repository state clear.

## Public Command Surface

| Command | Purpose |
|---|---|
| `/sync` | Role-aware device publishing or coordinator aggregation. |
| `/capture` | Record and route a learning, decision, run, status change, activity, or uncertain note. |
| `/day start` | Regenerate today's brief from current workstream and sync state. |
| `/day close` | Organize the inbox, summarize meaningful work, and carry forward next actions. |
| `/review` | Classify work as `now`, `next`, `waiting`, `parked`, or `archived`. |
| `/doctor` | Run a read-only structural and sync-health audit; fix only when explicitly requested. |
| `/initialise-project` | Initialize project-local memory and its workstream. |
| `/check-initialisation` | Verify and align initialized project memory. |

Command specs live in `system/commands/`. Detailed algorithms live in `system/procedures/`. Repo-local skills are thin discovery adapters.

Low-level commands such as `/device-sync`, `/aggregate-sync`, `/ingest`, individual summary commands, `/log-day`, `/plan-tomorrow`, and `/organise-scratch` remain internal compatibility primitives. Do not make users choose among them when a public command can select the behavior.

## Session Startup And Logging

- For read-only questions, begin with `wiki/logs/index.md`; do not create a daily log merely because a session started.
- Before writing human-facing knowledge or logs, follow `system/procedures/maintain_daily_log.md`.
- Successful no-op publisher syncs update `system/sync/device-status/<node>.yaml`; the coordinator refreshes `system/sync/status.yaml`.
- Write human logs only for meaningful synthesis, decisions, planning, curation, structural changes, or failures requiring attention.

## Registry And Node Rules

- `system/registry/nodes.yaml` is the canonical node registry and coordinator declaration.
- `system/registry/projects.yaml` maps workstreams to project paths per node.
- `KB_NODE_NAME` must resolve to a canonical node or declared alias. Ask during interactive runs when unknown; unattended runs fail safely.
- Prefer exactly one project daily note per project/work-date/node: `memory/notes/YYYY-MM-DD-<node>.md`.
- Topic-specific working documents belong in `memory/scratch/`; do not encode topics after the node suffix.
- Continue reading unsuffixed daily notes as legacy/default-node notes.

## Sync Model

- Publishers write only their node-owned staging, device summaries, and device status.
- The coordinator is the only unattended writer of global workstream synthesis, combined summaries, root ledgers, `wiki/today.md`, and the combined status view.
- Retain device staging as evidence and deduplicate by project/source/hash.
- Pull with `git pull --ff-only`; never force-push automation output.
- Follow `system/procedures/automated_project_ingest.md` for retry and failure fallback.

## Workstream Model

Every workstream contains `index.md`, `learnings.md`, `decisions.md`, `runs.md`, and `logs.md`.

Each `index.md` begins with:

```yaml
---
workstream: example
state: next
last_activity: 2026-07-19
review_after:
---
```

Allowed states are `now`, `next`, `waiting`, `parked`, and `archived`. Keep at most three `now` items unless a broader focus is intentional. The Context Card stores descriptive status, domain, tags, paths, latest result, blocker, and next action.

`wiki/workstreams/index.md` is a compact state-grouped portfolio. Do not grow a duplicate chronological update feed; dated history belongs in workstream logs.

## Project Memory Initialization

Follow `system/procedures/initialise_project.md` and preserve all project instructions. The marked block is:

```text
<!-- BEGIN KNOWLEDGE TRACKER MEMORY DIRECTIVES -->
<!-- END KNOWLEDGE TRACKER MEMORY DIRECTIVES -->
```

New projects receive four public memory skills under both `.agents/skills/` and `.claude/skills/`: `remember`, `scratch`, `organise-scratch`, and `check-initialisation`. `remember` infers activity, runs, decisions, learnings, and status destinations.

Old direct-name skills and `memory/commands/` are compatibility surfaces. Remove only exact-template copies after the consolidated skills exist; preserve and report custom instructions.

`CLAUDE.md` must be a regular file whose first non-empty line is `@AGENTS.md`. Do not stage, commit, or push target-project initialization changes from this repository.

## Operating Bias

- Optimize for rapid context recovery and low cognitive overhead.
- Keep one canonical source for each fact; generate indexes instead of copying prose manually.
- Prefer durable synthesis, links, paths, and explicit next actions over raw output.
- Leave uncertain cross-project material in `wiki/scratch/` until `/capture`, `/day close`, or `/review` can route it safely.
