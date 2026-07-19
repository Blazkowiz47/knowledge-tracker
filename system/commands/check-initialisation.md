# Command: /check-initialisation

Verify and align a target project's memory initialization from the knowledge base.

## Inputs

- Required: target project path, unless the user clearly names a workstream with a single project path in `wiki/workstreams/index.md`.

## Allowed Writes

This command uses the same narrow exception as project memory initialization. It may update only:

- target project `AGENTS.md` Knowledge Tracker memory block
- target project `CLAUDE.md` import stub
- target project `memory/` files, including `memory/scratch/`, `memory/integrations/`, and legacy `memory/commands/` migration
- target project project-local memory skills under `.agents/skills/` and `.claude/skills/`
- knowledge-base workstream pages and today's daily log

It must not edit target project source code, configs, experiment files, outputs, or unrelated docs. It must not stage, commit, or push the target project repository.

## Steps

1. Follow `system/procedures/maintain_daily_log.md`.
2. Inspect the target project path, `AGENTS.md`, `CLAUDE.md`, and `memory/` structure.
3. Compare the project against `system/procedures/initialise_project.md` and current templates.
4. If anything is missing or stale, align only the allowed memory infrastructure:
   - ensure exactly one Knowledge Tracker memory block in `AGENTS.md`
   - ensure `CLAUDE.md` is a regular file whose first non-empty line is exactly `@AGENTS.md`
   - ensure required memory files, `memory/scratch/index.md`, and `memory/integrations/index.md` exist
   - ensure consolidated skills exist under `.agents/skills/` and `.claude/skills/` for `remember`, `scratch`, `organise-scratch`, and `check-initialisation`
   - remove old direct-name skills and legacy commands only when they exactly match historical templates; preserve and report custom instructions
   - if an integration provider file already exists, align only its local scaffolding and skip any external checks that need unavailable tools or authentication
   - update the workstream page and daily log if alignment changed anything
5. Verify the target project repository has not been staged, committed, or pushed.
6. Commit and push knowledge-base changes only.

## Report

Report:

- whether the project was already initialized correctly
- what memory infrastructure was aligned
- any unresolved ambiguity that needs user input
- whether the target project repo was left uncommitted
