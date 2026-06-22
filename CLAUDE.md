@AGENTS.md

# Skills

The canonical skills live in `.agents/skills/`. `.claude/skills/` mirrors them: each `.claude/skills/<name>/SKILL.md` keeps the `name`/`description` frontmatter (required for discovery) and `@`-imports the original body. When a skill is added, renamed, or has its description changed in `.agents/skills/`, regenerate the matching `.claude/skills/<name>/SKILL.md` so the two stay in sync.
