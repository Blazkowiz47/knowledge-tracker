---
name: remember
description: Use only when the user invokes /remember or asks to record project activity, a run, decision, learning, status change, blocker, next action, or compact daily memory. Do not use for unrelated reminders or task scheduling.
---

# Remember Project Knowledge

Follow the project `AGENTS.md` memory directives. This skill is a project-local shortcut; it does not override project instructions.

## Steps

1. Identify today's local date and canonical node.
2. If the stable `<node>` name is not known, ask the user before creating or writing a new node-specific note.
3. Prefer exactly one `memory/notes/YYYY-MM-DD-<node>.md` daily note. Never create topic-suffixed daily notes; use `memory/scratch/` for topic documents.
4. Continue writing `memory/notes/YYYY-MM-DD.md` only when that legacy file is already active for the target date or the user explicitly asks to keep the legacy convention.
5. Classify input as activity, run, decision, learning, or status and write once to the smallest canonical memory file.
6. Use today's note for activity; `runs.md` for notable runs; `decisions.md` for decisions; `learnings.md` for durable findings; and `index.md` for status, blocker, latest result, or next action.
7. Read enabled integration policy only when the update may publish externally; missing tools never block local memory.
8. Keep the update compact and link to evidence paths.
