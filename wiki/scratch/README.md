# Scratch

Quick-capture surface for the Obsidian vault. This folder is the default target for Ctrl+N new notes.

Use this for anything you want to write down without first deciding where it belongs:

- A rough thought.
- A todo or follow-up.
- A question to answer later.
- The first sketch of a multi-day investigation that will later live in a workstream or project memory.

## Rules

- Anything in this folder is temporary. Files can disappear at the next `/organise-scratch` pass.
- Free-form file names are fine. Obsidian's default `Untitled.md` works; a date stamp like `2026-05-26-pad-fmts.md` is friendlier when you scan the folder.
- `README.md` is reserved and is never swept by `/organise-scratch`.
- Project-specific multi-day working docs do **not** belong here. They belong in `<project_path>/memory/scratch/<topic>.md` so they live alongside the project they describe.

## End-of-day sweep

Run `/organise-scratch` at the end of the day. The command reads each file and routes it to one of:

- A project's `memory/scratch/<topic>.md` (multi-day project investigation).
- A project's `memory/notes/YYYY-MM-DD-<node>.md` (same-day operational detail).
- A project's `memory/learnings.md` or `memory/decisions.md` (durable).
- `wiki/today.md` Questions section, or a workstream `index.md` (cross-project).
- `wiki/logs/YYYY/MM/DD.md` (knowledge-base daily log).
- Deleted, if ephemeral and resolved.

See `system/procedures/organise_scratch.md` for the full routing rules.
