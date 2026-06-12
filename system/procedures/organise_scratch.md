# Procedure: Organise Scratch

Follow this procedure when the user runs `/organise-scratch` or asks to clean up `wiki/scratch/` and route the captured notes to their proper homes.

The router is a written agent procedure, not a script. Perform the steps directly with normal file operations.

## Goal

Move every meaningful capture in `wiki/scratch/` to where it belongs, delete what is ephemeral, and leave only `README.md` and genuinely-unclear captures behind. The default expectation is that the folder is near-empty after a successful sweep.

## Inputs

Optional:

- A single file name inside `wiki/scratch/` to scope the sweep to just that capture.

If no scope is given, sweep every file in `wiki/scratch/` except `README.md`.

## Routing Rules

For each captured note, choose one and only one destination:

| Capture shape | Destination |
|---|---|
| Multi-day, project-specific investigation or working doc | `<project_path>/memory/scratch/<topic>.md` (create if missing; append if it exists) |
| Same-day, project-specific operational detail | Append to `<project_path>/memory/notes/YYYY-MM-DD-<node>.md` under the most relevant section |
| Durable project finding (a confirmed observation, failed approach, or reusable idea) | `<project_path>/memory/learnings.md` under the right subhead |
| Project decision and rationale | New row in `<project_path>/memory/decisions.md` |
| New device, server, or environment used | New row in `<project_path>/memory/devices.md` |
| Experiment or long-running job summary | New row in `<project_path>/memory/runs.md` |
| Cross-project rough idea or open question | `wiki/today.md` Questions section, or the relevant `wiki/workstreams/<slug>/` (Active Threads in `index.md`, or `logs.md` if dated) |
| Knowledge-base daily log fodder | `wiki/logs/YYYY/MM/DD.md` under `## Entries` |
| Ephemeral: resolved, superseded, duplicate, or no-longer-useful | Delete the scratch file |
| Genuinely unclear after asking the user | Leave in `wiki/scratch/` for the next pass |

When in doubt about which destination fits, ask the user. Do not auto-route uncertain captures.

## Write Scope

This procedure routes captures into existing structures, so the usual repository boundary rule applies:

- Allowed external-project edits are limited to that project's `memory/` files (`index.md`, `devices.md`, `runs.md`, `learnings.md`, `decisions.md`, `notes/`, `scratch/`).
- Do not edit external project source code, experiment scripts, configs, data files, outputs, or unrelated documentation.
- Do not stage, commit, or push the target project repository.
- Allowed knowledge-base edits include `wiki/scratch/`, `wiki/today.md`, `wiki/workstreams/<slug>/index.md`, `wiki/workstreams/index.md`, and the current `wiki/logs/YYYY/MM/DD.md`.

## Steps

1. List every file inside `wiki/scratch/` except `README.md`. If a scope file was provided, restrict to that file.
2. For each capture file:
   1. Read its content.
   2. Decide the destination using the routing table above. If the project path is unclear, ask the user; do not infer from file name alone.
   3. If the destination is a project `memory/scratch/<topic>.md` that does not exist yet, create it using `system/templates/project-scratch-doc.md` as a starting shape, then append the capture's content under the appropriate section.
   4. For other destinations, append or insert the capture's content using the destination's existing structure (tables get new rows; sections get new bullets; daily notes get new entries with date and node context where relevant).
   5. If the capture is ephemeral, delete the file outright.
   6. If the capture remains unclear after a clarifying question, leave it untouched.
3. After all routing:
   - Update `<project_path>/memory/index.md` Active Threads when a `memory/scratch/<topic>.md` was created or closed, or when status, blocker, latest result, or next action changed.
   - Update `wiki/workstreams/<slug>/index.md` Context Card and Active Threads when a routed item changes status, blocker, latest result, or next action.
   - Workstream durable findings go to `wiki/workstreams/<slug>/learnings.md`; workstream-level decisions go to `wiki/workstreams/<slug>/decisions.md`; notable runs to `wiki/workstreams/<slug>/runs.md`; dated activity entries to `wiki/workstreams/<slug>/logs.md` under a `## YYYY-MM-DD` heading.
   - Update `wiki/workstreams/index.md` Recently Updated row when relevant.
   - Append a single entry to `wiki/logs/YYYY/MM/DD.md` summarising what was routed where (one short line per non-trivial route is enough; do not enumerate trivial deletions).
4. Verify:
   - `wiki/scratch/` contains only `README.md` plus any captures genuinely left for the next pass.
   - No target project repositories were staged, committed, or pushed.
   - Routed content is in exactly one place; the source capture file is either deleted or clearly marked as still-in-flight.
5. Follow the root `AGENTS.md` sync rule for the knowledge-base repository only:
   - Run `git status --short` in the knowledge-base repository.
   - Stage only knowledge-base files changed by this sweep.
   - Commit with a compact message describing the sweep.
   - Push the current branch to its configured remote.
   - If commit or push fails, report the failure and leave the repository state clear.

## Promotion Notes

A `memory/scratch/<topic>.md` is itself temporary at a longer horizon. When findings inside it crystallize:

- Move durable findings into the project's `memory/learnings.md`.
- Move durable decisions into the project's `memory/decisions.md`.
- Update the workstream's `index.md` Context Card if status, blocker, latest result, or next action changes.
- Delete the scratch file once the investigation closes.

`/organise-scratch` does not automatically promote `memory/scratch/<topic>.md` files; that promotion happens when the user updates a scratch doc or explicitly asks for it.
