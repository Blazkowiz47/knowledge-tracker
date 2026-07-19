# Project Memory Skills

Template pack for project-local Codex and Claude memory skills.

For every initialized project, create the same consolidated skill names under both local skill surfaces:

```text
.agents/skills/<skill>/SKILL.md
.claude/skills/<skill>/SKILL.md
```

Use the matching `system/templates/project-skills/<skill>/SKILL.md` file for both agents.

## Skills

| Skill | Purpose |
|---|---|
| `remember` | Infer and record activity, runs, decisions, learnings, or status changes. |
| `scratch` | Capture an uncertain or in-flight project-local note. |
| `organise-scratch` | Route project-local scratch notes into the right memory files. |
| `check-initialisation` | Verify, align, and migrate the project memory structure. |

## Legacy Commands

Do not create `memory/commands/` for new projects by default.

During `check-initialisation`, use old direct-name skills and `system/templates/project-commands/` only as legacy comparison material. Remove exact-template copies after consolidated skills exist; preserve custom content.
