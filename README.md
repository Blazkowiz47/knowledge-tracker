# Knowledge Tracker

Knowledge Tracker is a portable, Obsidian-compatible scaffold for building a personal or team knowledge base around projects, research, experiments, decisions, reusable concepts, and daily planning.

It is intentionally empty: clone it, rename it if you want, and let your own projects, logs, workstreams, and summaries grow from the templates and procedures.

## Quick Start

1. Fork this repository or clone it into a new private repository.
2. Open the repository as an Obsidian vault, or edit the Markdown files directly.
3. Register nodes and the coordinator in `system/registry/nodes.yaml`, then set `KB_NODE_NAME` to a canonical node.
4. Start from `wiki/index.md` and run `/day start` to generate `wiki/today.md`.
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
6. Return here and run `/sync`; the node registry selects publisher or coordinator behavior.
7. Use `/day close` for inbox cleanup, meaningful synthesis, and carry-forward.

The main instructions live in `AGENTS.md`.

Repo-local skills expose the small public surface: `/sync`, `/capture`, `/day`, `/review`, `/doctor`, `/initialise-project`, and `/check-initialisation`. Detailed legacy commands remain internal automation primitives.

## Everyday Commands

- `/sync` — role-aware synchronization
- `/capture` — route any note to its canonical home
- `/day start` and `/day close` — open or close the knowledge workday
- `/review` — review focus and workstream lifecycle state
- `/doctor` — read-only structural and sync-health audit

## Automation Setup

The scaffold includes repo-local Codex automation wrappers under `.codex/automations/`.

### Device Roles

Use one coordinator device and any number of non-coordinator devices.

- Coordinator device: `/sync` publishes its local state and then aggregates global synthesis.
- Non-coordinator devices: `/sync` selects publisher-only behavior.

Set a stable node name on every device:

```sh
export KB_NODE_NAME=<node-name>
```

Optionally set the coordinator name on non-coordinator devices:

```sh
export KB_COORDINATOR_NODE=<coordinator-node-name>
```

### Coordinator Automation

On the coordinator, create Codex app automations or local scheduler jobs that run from this repository.

Morning coordinator prompt shape:

```text
Run $sync, then $day with the start subcommand.
If useful for your workflow, include a short standup section with:
- Since last standup
- Today
- Blockers / asks
```

Evening coordinator prompt shape:

```text
Run $sync, then $day with the close subcommand.
```

The coordinator remains the only unattended writer of global synthesis; `/sync` selects that role from the registry.

### Non-Coordinator Cron

On non-coordinator devices, install cron entries that run before the coordinator. For example, if the coordinator runs at `04:00` and `16:00`, run one device 20 minutes earlier and another 10 minutes earlier:

```cron
40 3 * * * KB_NODE_NAME=gpu-node KB_COORDINATOR_NODE=main-laptop /path/to/knowledge-tracker/.codex/automations/run-morning-sync.sh
50 3 * * * KB_NODE_NAME=laptop-node KB_COORDINATOR_NODE=main-laptop /path/to/knowledge-tracker/.codex/automations/run-morning-sync.sh
40 15 * * * KB_NODE_NAME=gpu-node KB_COORDINATOR_NODE=main-laptop /path/to/knowledge-tracker/.codex/automations/run-evening-sync-summarise.sh
50 15 * * * KB_NODE_NAME=laptop-node KB_COORDINATOR_NODE=main-laptop /path/to/knowledge-tracker/.codex/automations/run-evening-sync-summarise.sh
```

The wrapper names are kept stable for compatibility, but the non-coordinator evening wrapper does not run combined summarisation. It publishes device staging only.

Before installing cron, verify the scripts parse:

```sh
bash -n .codex/automations/run-morning-sync.sh
bash -n .codex/automations/run-evening-sync-summarise.sh
```

### Atlassian Rovo MCP

The scaffold includes a generic `$atlassian-rovo-mcp` skill plus provider-specific `$jira-rovo-mcp` and `$confluence-rovo-mcp` skills. Before using Jira or Confluence integrations, configure and log in to the official Atlassian Rovo MCP server for the agent harness you use.

For Codex:

```sh
codex mcp add atlassian --url https://mcp.atlassian.com/v1/mcp/authv2
codex mcp login atlassian
codex mcp get atlassian
```

For Claude Code:

```sh
claude mcp add --transport http atlassian https://mcp.atlassian.com/v1/mcp/authv2
```

Then run `/mcp` in Claude Code to authenticate. Missing MCP setup, missing authentication, or unavailable tools should never block local memory updates; save drafts locally instead.

## Main Entry Points

- `wiki/index.md` - main map
- `wiki/scratch/README.md` - temporary capture area
- `wiki/today.md` - generated daily brief
- `wiki/workstreams/index.md` - active workstreams and project memories
- `.agents/skills/` - repo-local Codex skill adapters for the command workflows
- `.codex/automations/` - optional scheduler wrappers and prompts for device sync automation
- `system/commands/index.md` - portable slash-command specs
- `system/registry/` - canonical node roles and project paths
- `system/sync/README.md` - conflict-safe sync conventions for per-device staging and global aggregation
- `system/templates/project-integrations-index.md` - optional project integration scaffold, including Jira and Confluence patterns
- `system/procedures/initialise_project.md` - how agents initialize memory inside a project
- `system/procedures/ingest_project_day.md` - how agents ingest missing, changed, or date-scoped project notes
- `system/procedures/plan_tomorrow.md` - how agents plan the next day

## Privacy Model

This repository should contain reusable structure, summaries, and links, not raw private evidence. Keep sensitive project files, datasets, logs, credentials, and large outputs in their source repositories or private storage. Link to them only when appropriate.

The public scaffold ships without personal workstreams, daily history, ingestion ledgers, device summaries, or project paths.

## License

MIT. See `LICENSE`.

## Design Principle

Project repositories keep operational memory close to the work. The knowledge base keeps the global map clean, compact, and useful.
