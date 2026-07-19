---
name: initialise-project
description: Use when the user asks to initialize, initialise, set up, or add project memory for a project path from the knowledge base, with either an empty scaffold or user-provided initial contents, context, or directions.
---

# Initialise Project

Use this skill as a thin Codex adapter for the knowledge-base project-memory initialization procedure.

## Workflow

1. Read and follow this repository's `AGENTS.md`.
2. Read and follow `system/commands/initialise-project.md`.
3. Read every procedure referenced by that command.
4. Treat those documents as canonical. This skill should not duplicate or override them.

## Inputs

- Require a target project path.
- Use optional user-provided project name, workstream slug, domain, tags, node name, and initial directions when available.
- If the user provides initial contents or directions, seed them only into allowed memory and workstream files, such as `memory/index.md`, today's project note, `memory/scratch/`, or the KB workstream pages.
- If no initial contents are provided, create the empty scaffold from templates.

## Boundaries

- From the knowledge-base repo, modify only the target project's memory infrastructure allowed by the initialization procedure.
- The initialization path may create or align project-local memory skills under the target project's `.agents/skills/` and `.claude/skills/`.
- Do not edit target project source code, experiment files, configs, outputs, or unrelated docs.
- Do not stage, commit, or push the target project repository.
- After knowledge-base edits, commit and push only the knowledge-base repository according to `AGENTS.md`.
