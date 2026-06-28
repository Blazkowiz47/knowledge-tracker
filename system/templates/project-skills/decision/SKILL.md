---
name: decision
description: Use only when the user invokes /decision or explicitly asks to record a project decision and rationale in project memory.
---

# Decision

Follow the project `AGENTS.md` memory directives. This skill is a project-local shortcut; it does not override project instructions.

## Steps

1. Add a row to `memory/decisions.md` with date, decision, reason, consequence, and revisit condition if relevant.
2. If the stable `<node>` name is not known, ask the user before creating or writing a new node-specific note.
3. Add a short entry to today's project note, preferring `memory/notes/YYYY-MM-DD-<node>.md` for new notes.
4. If the decision changes project status, blocker, latest useful result, or next action, update `memory/index.md`.
5. Preserve uncertainty. If the decision is tentative, mark it clearly.
