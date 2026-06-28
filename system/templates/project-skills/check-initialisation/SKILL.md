---
name: check-initialisation
description: Use only when the user invokes /check-initialisation or asks to verify, repair, align, migrate, or finish this project's memory initialization.
---

# Check Initialisation

Follow the project `AGENTS.md` memory directives. This skill is a project-local shortcut; it does not override project instructions.

## Steps

1. Confirm required memory files exist:
   - `memory/index.md`
   - `memory/devices.md`
   - `memory/runs.md`
   - `memory/learnings.md`
   - `memory/decisions.md`
   - `memory/notes/`
   - `memory/scratch/index.md`
   - `memory/integrations/index.md`
2. Confirm project-local memory skills exist for `remember`, `log`, `run`, `decision`, `learned`, `status`, `scratch`, `organise-scratch`, and `check-initialisation` under both `.agents/skills/` and `.claude/skills/`.
3. Confirm `AGENTS.md` contains exactly one project memory block.
4. Confirm `CLAUDE.md` is a regular file whose first non-empty line is exactly `@AGENTS.md`, unless the user explicitly asked to skip it.
5. If legacy `memory/commands/` exists, migrate exact-template command specs to project-local skills and preserve/report custom command specs.
6. If provider-specific integration files exist, align their local folders and drafts/ledgers without requiring external tools or authentication.
7. Align missing memory infrastructure when it is safe to do so, preserving all existing project instructions and memory content.
8. If existing instructions conflict or preservation is ambiguous, stop and ask the user.
9. Do not stage, commit, or push unless the user explicitly asks from this project repository.

## Report

Report whether initialization is correct, what was aligned, and any remaining issue.
