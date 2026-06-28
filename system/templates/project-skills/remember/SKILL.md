---
name: remember
description: Use only when the user invokes /remember or explicitly asks to add a compact note to today's project memory. Do not use for unrelated reminders or task scheduling.
---

# Remember

Follow the project `AGENTS.md` memory directives. This skill is a project-local shortcut; it does not override project instructions.

## Steps

1. Identify today's local date and the active node.
2. If the stable `<node>` name is not known, ask the user before creating or writing a new node-specific note.
3. Prefer `memory/notes/YYYY-MM-DD-<node>.md` for new notes.
4. Continue writing `memory/notes/YYYY-MM-DD.md` only when that legacy file is already active for the target date or the user explicitly asks to keep the legacy convention.
5. If `memory/integrations/index.md` exists, read it before logging and follow enabled integration policies.
6. Append the note under the most relevant section, such as `Work Done`, `Analysis Results`, `Learnings`, `Blockers`, or `Next`.
7. If an enabled integration asks for one-line auto-comments on active linked issues, publish only when the required adapter is available and authenticated; otherwise save a draft locally and mark publishing skipped.
8. If the note is durable, also update `memory/learnings.md`, `memory/decisions.md`, `memory/runs.md`, or `memory/index.md` as appropriate.
9. Keep the note compact. Link to evidence paths instead of pasting bulky output.
