---
name: check-initialisation
description: Use when the user types /check-initialisation or asks to verify, repair, align, or finish a project's Knowledge Tracker memory initialization from the knowledge base.
---

# Check Initialisation

Use this skill as a thin Codex adapter for the knowledge-base `/check-initialisation` command.

## Workflow

1. Read and follow this repository q{'}s `AGENTS.md`.
2. Read and follow `system/commands/check-initialisation.md`.
3. Follow any procedures referenced by that command, especially:
   - `system/procedures/maintain_daily_log.md`
   - `system/procedures/initialise_project.md`
4. Treat the command spec as the canonical workflow. This skill should not duplicate or override it.

## Claude Import Check

- Treat `AGENTS.md` as the canonical cross-agent instruction file.
- Align `CLAUDE.md` as a regular file whose first non-empty line is exactly `@AGENTS.md`.
- Preserve existing Claude-only guidance below the import when it is clearly complementary.
- If a previous `CLAUDE.md -> AGENTS.md` symlink is found, replace it with the import stub during alignment.

## Boundaries

- From the knowledge-base repo, modify only the target project's memory infrastructure allowed by the command spec.
- Do not edit target project source code, experiment files, configs, outputs, or unrelated docs.
- Do not stage, commit, or push the target project repository.
- After knowledge-base edits, commit and push only the knowledge-base repository according to `AGENTS.md`.
