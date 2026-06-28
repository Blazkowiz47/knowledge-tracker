---
name: run
description: Use only when the user invokes /run or explicitly asks to record or update an experiment, evaluation, benchmark, or long-running job in project memory. Do not use for executing shell commands, running tests, or starting ordinary programs unless the user asks to log that run in memory.
---

# Run

Follow the project `AGENTS.md` memory directives. This skill is a project-local shortcut; it does not override project instructions.

## Steps

1. Update `memory/runs.md` with date, node/device/server, branch/commit, command/config, dataset/input, output path, result, and next action.
2. If the stable `<node>` name is not known, ask the user before creating or writing a new node-specific note.
3. Add a short entry to today's project note, preferring `memory/notes/YYYY-MM-DD-<node>.md` for new notes.
4. If the result changes the project's durable understanding, update `memory/learnings.md`.
5. If the run changes the current blocker or next action, update `memory/index.md`.
6. Avoid pasting raw logs; summarize and link to output paths.
