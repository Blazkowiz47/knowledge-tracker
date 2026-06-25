# Knowledge-Base Commands

Portable slash-command specs for Codex and Claude. If a prompt begins with one of these commands, read the matching file and follow it as a shortcut to the canonical `AGENTS.md` and `system/procedures/` instructions.

Codex repo-local skill adapters for these commands live under `.agents/skills/`. The skills provide discovery and invocation; these command specs remain the canonical workflow source.

Command specs do not replace repository instructions. If there is a conflict, follow `AGENTS.md` and the referenced procedure.

## Commands

| Command | Spec | Purpose |
|---|---|---|
| `/log-day` | `log-day.md` | Append a compact entry to today's knowledge-base daily log. |
| `/summarise` | `summarise.md` | Summarise the requested day, month, or year using the appropriate summary command. |
| `/summarise-day` | `summarise-day.md` | Finalize or refresh a daily summary. |
| `/summarise-month` | `summarise-month.md` | Create or refresh a monthly summary. |
| `/summarise-year` | `summarise-year.md` | Create or refresh a yearly summary. |
| `/ingest` | `ingest.md` | Ingest missing, changed, or date-scoped project memory notes into the knowledge base. |
| `/auto-ingest` | `auto-ingest.md` | Detect changed project memory notes and ingest them safely with deferred fallback. |
| `/plan-tomorrow` | `plan-tomorrow.md` | Produce or write the next-day plan from synced memory. |
| `/device-sync` | `device-sync.md` | Pull the knowledge base, publish this node's changed project-memory sources into per-node KB staging, then commit and push those node-owned files only. |
| `/aggregate-sync` | `aggregate-sync.md` | Pull the knowledge base, merge device-staged sources into global KB synthesis, then commit and push coordinator-owned files. |
| `/sync` | `sync.md` | Primary/coordinator sync: pull the knowledge base, ingest missing or changed registered project memories into global KB state, then commit and push knowledge-base changes only. |
| `/organise-scratch` | `organise-scratch.md` | Sweep `wiki/scratch/` and route each captured note to its proper home. |
| `/check-initialisation` | `check-initialisation.md` | Verify and align a project's memory initialization. |

## Rules

- Run `system/procedures/maintain_daily_log.md` before writing any knowledge-base log entry.
- Keep external project repositories read-only except for the explicit project-memory initialization/check exception.
- Never stage, commit, or push external project repositories from a knowledge-base session.
- On non-primary devices, prefer `/device-sync` so automated runs write only node-owned staging files. Use `/aggregate-sync` or `/sync` only from the chosen coordinator unless the user explicitly overrides the multi-device conflict policy.
- Treat project-local notes as authoritative and knowledge-base summaries as refreshable derived state.
- If summarisation fails due to model, rate, quota, weekly-limit, or network limits, defer ingestion instead of fabricating a summary.
- Commit and push knowledge-base edits after command execution, following the root `AGENTS.md` sync directive.
