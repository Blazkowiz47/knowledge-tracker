# Knowledge-Base Commands

The public command surface is deliberately small. Command specs define the interface; detailed behavior lives in `system/procedures/`; skills are thin discovery adapters.

## Everyday Commands

| Command | Purpose |
|---|---|
| `/sync` | Select publisher or coordinator behavior from the node registry. |
| `/capture` | Route any learning, decision, run, status, activity, or uncertain note. |
| `/day start` / `/day close` | Generate the daily brief or close the day cleanly. |
| `/review` | Review portfolio state and focus. |
| `/doctor` | Audit structure and sync health; read-only by default. |

## Setup Commands

| Command | Purpose |
|---|---|
| `/initialise-project` | Add project-local memory and a registered workstream. |
| `/check-initialisation` | Verify and align an existing project-memory scaffold. |

## Internal Compatibility Primitives

`device-sync.md`, `aggregate-sync.md`, `ingest.md`, `auto-ingest.md`, the summary specs, `log-day.md`, `plan-tomorrow.md`, and `organise-scratch.md` remain available to automation and precise maintenance.

Resolve nodes and projects from `system/registry/`, keep no-op telemetry out of human logs, preserve external projects, and commit/push knowledge-base edits according to `AGENTS.md`.
