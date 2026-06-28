# Project Memory Skills

Template pack for project-local Codex and Claude memory skills.

For every initialized project, create the same direct skill names under both local skill surfaces:

```text
.agents/skills/<skill>/SKILL.md
.claude/skills/<skill>/SKILL.md
```

Use the matching `system/templates/project-skills/<skill>/SKILL.md` file for both agents.

## Skills

| Skill | Purpose |
|---|---|
| `remember` | Add a compact note to today's project memory. |
| `log` | Record session work or a meaningful project change. |
| `run` | Add or update an experiment, evaluation, benchmark, or long-running job. |
| `decision` | Record a project decision and rationale. |
| `learned` | Record a durable finding or reusable lesson. |
| `status` | Update the project context card. |
| `scratch` | Capture an uncertain or in-flight project-local note. |
| `organise-scratch` | Route project-local scratch notes into the right memory files. |
| `check-initialisation` | Verify, align, and migrate the project memory structure. |

## Legacy Commands

Do not create `memory/commands/` for new projects by default.

During `check-initialisation`, use `system/templates/project-commands/` only as legacy comparison material. If an existing project has exact-template legacy command specs, migrate them into local skills and remove the legacy command directory. If command specs contain custom project-specific content, preserve them and report that manual migration is needed.
