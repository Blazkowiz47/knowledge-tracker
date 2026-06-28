---
name: log
description: Use only when the user invokes /log or explicitly asks to record session work or a meaningful project change in project memory. Do not use merely to inspect application logs.
---

# Log

Follow the project `AGENTS.md` memory directives. This skill is a project-local shortcut; it does not override project instructions.

## Steps

1. Identify today's local date and active node.
2. If the stable `<node>` name is not known, ask the user before creating or writing a new node-specific note.
3. Prefer `memory/notes/YYYY-MM-DD-<node>.md` for new notes.
4. Continue writing `memory/notes/YYYY-MM-DD.md` only when that legacy file is already active for the target date or the user explicitly asks to keep the legacy convention.
5. If `memory/integrations/index.md` exists, read it before logging and follow enabled integration policies.
6. Record the work done, why it mattered, and the next action.
7. Include branch, commit, command/config, dataset, output path, and node/device/server when relevant.
8. If an enabled integration asks for one-line auto-comments on active linked issues, publish only when the required adapter is available and authenticated; otherwise save a draft locally and mark publishing skipped.
9. If project status, blocker, latest useful result, or next action changed, update `memory/index.md`.
10. Keep source-code details brief; link to files, commits, or outputs when needed.
