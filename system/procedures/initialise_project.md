# Procedure: Initialise Project Memory

Follow this procedure when the user asks to initialize, initialise, set up, or add memory for a specific project path.

The initializer is a written agent procedure, not a script. Perform the steps directly with normal file operations.

## Inputs

Required:

- Project path

Optional:

- Project name
- Domain, for example `research`, `engineering`, `personal`, or `mixed`
- Tags
- Workstream slug
- Node context, meaning the stable device or server name used for memory notes
- Initial contents, context, directions, or seed notes to place into project memory and the workstream

If the node context is needed for a new project note and cannot be inferred safely from the user request or existing project memory, ask the user for the stable `<node>` name before creating or writing that note.

If optional values are not provided, infer conservative defaults from the project path, repository context, and user message.

## Naming Rules

- Project name defaults to the final folder name of the project path.
- Workstream slug defaults to the project name converted to lowercase with spaces and underscores changed to hyphens.
- Preserve the actual project folder name in displayed paths.
- Use the current local date for daily notes and knowledge-base daily log entries.
- Node names should be stable lowercase slugs, for example `oslo-laptop`, `workstation-01`, `gpu-node-01`, or `h100-lab`.
- Prefer `node` as the generic term because it covers laptops, workstations, servers, and cluster machines.

## Write Scope

Project memory initialization and project memory initialization checks are the only default exceptions to the knowledge-base rule that external project repositories are read-only.

During this procedure, allowed target-project edits are limited to:

- `AGENTS.md`, only to create it or add/update the marked Knowledge Tracker memory block
- `CLAUDE.md`, only to preserve any unique Claude-specific instructions and make it a regular file importing `AGENTS.md`
- `memory/index.md`
- `memory/devices.md`
- `memory/runs.md`
- `memory/learnings.md`
- `memory/decisions.md`
- `memory/notes/YYYY-MM-DD.md` or `memory/notes/YYYY-MM-DD-<node>.md`
- `memory/scratch/index.md`
- `memory/integrations/index.md` and existing enabled integration files/folders under `memory/integrations/`
- `.agents/skills/` project-local Codex memory skills
- `.claude/skills/` project-local Claude memory skills
- legacy `memory/commands/` migration only when `/check-initialisation` is refactoring old template-derived command specs into skills

Allowed knowledge-base edits are limited to:

- `wiki/workstreams/<workstream-slug>/index.md`, `learnings.md`, `decisions.md`, `runs.md`, `logs.md`
- `wiki/workstreams/index.md`
- the current daily log under `wiki/logs/YYYY/MM/DD.md`
- relevant log indexes and summaries under `wiki/logs/`

Forbidden from a knowledge-base session:

- Do not edit target-project source code, experiment scripts, configs, data files, outputs, or unrelated documentation.
- Do not stage, commit, or push the target project repository.
- Do not create Python, shell, or other executable initializer scripts.
- Do not remove, rewrite, reorder, or weaken existing project-specific instructions.

After finishing, commit and push only the knowledge-base repository changes according to the root `AGENTS.md` sync rule.

## Step 1: Inspect The Project

Confirm the target project path exists before editing.

Inspect the target project path and identify:

- Whether `AGENTS.md` exists
- Whether `CLAUDE.md` exists, and whether it is already a regular file whose first non-empty line is exactly `@AGENTS.md`
- Whether `README.md` exists
- Whether a `memory/` folder already exists
- Whether existing notes, docs, experiment logs, or run logs already exist
- Whether the path is a Git repository, and if so the current branch, latest commit, and relevant uncommitted status

Read existing project instructions before editing `AGENTS.md`. If `CLAUDE.md` exists, inspect it too and preserve any unique Claude-only instructions before replacing or rewriting it as an import stub.

If existing instructions conflict with the memory block or the preservation/merge is ambiguous, stop and ask the user.

## Step 2: Create Missing Project Memory Files

Create this structure inside the project if missing:

```text
memory/
  index.md
  devices.md
  runs.md
  learnings.md
  decisions.md
  notes/
    YYYY-MM-DD-<node>.md
  scratch/
    index.md
  integrations/
    index.md
.agents/
  skills/
    remember/SKILL.md
    log/SKILL.md
    run/SKILL.md
    decision/SKILL.md
    learned/SKILL.md
    status/SKILL.md
    scratch/SKILL.md
    organise-scratch/SKILL.md
    check-initialisation/SKILL.md
.claude/
  skills/
    remember/SKILL.md
    log/SKILL.md
    run/SKILL.md
    decision/SKILL.md
    learned/SKILL.md
    status/SKILL.md
    scratch/SKILL.md
    organise-scratch/SKILL.md
    check-initialisation/SKILL.md
```

`memory/scratch/` is the project-local holding area for uncertain project-only captures and multi-day, in-flight working notes. Keep `memory/scratch/index.md` as the short routing guide. Use one topic per scratch file, for example `memory/scratch/dataset-consistency.md`. Durable findings inside a scratch file are promoted to `memory/learnings.md`, `memory/decisions.md`, `memory/runs.md`, `memory/index.md`, or a dated note; the scratch file itself is deleted or marked closed when the investigation closes.

`memory/integrations/` is the project-local home for optional external connections. Always create `memory/integrations/index.md` from `system/templates/project-integrations-index.md`. Do not enable provider-specific integrations by default. When a provider is already enabled or the user asks to add it, preserve and align its files. For Jira via Atlassian Rovo MCP, use:

```text
memory/integrations/
  jira.md
  jira/
    issues/
      ISSUE-KEY.md
    drafts/
```

Use `system/templates/project-integration-jira.md` for `jira.md` and `system/templates/project-integration-jira-issue.md` for new issue files. Empty `issues/` and `drafts/` directories may be created when Jira is enabled, but missing Atlassian Rovo MCP setup or authentication must not block initialization or memory updates.

For Confluence via Atlassian Rovo MCP, use:

```text
memory/integrations/
  confluence.md
  confluence/
    pages/
      PAGE-ID.md
    blogs/
      BLOG-ID-OR-SLUG.md
    drafts/
```

Use `system/templates/project-integration-confluence.md` for `confluence.md`, `system/templates/project-integration-confluence-page.md` for new page files, and `system/templates/project-integration-confluence-blog.md` for new blog files. Empty `pages/`, `blogs/`, and `drafts/` directories may be created when Confluence is enabled, but missing Atlassian Rovo MCP setup, authentication, or exposed Confluence tools must not block initialization or memory updates.

Use a node-specific note for new project memory:

```text
memory/notes/YYYY-MM-DD-<node>.md
```

If the stable node name is not known, stop and ask the user for it before creating today's note. Do not invent a generic node name such as `server`, `gpu`, `desktop`, or `default`.

Keep backward compatibility with existing project memories that already use the legacy unsuffixed note:

```text
memory/notes/YYYY-MM-DD.md
```

Do not rename existing legacy notes during initialization. Existing `YYYY-MM-DD.md` files remain valid and mean the legacy/default-node source for that date.

Use the templates in `system/templates/` for new files.

Use `system/templates/project-skills/<skill>/SKILL.md` for both Codex and Claude project-local memory skills. Create the same direct skill names under both `.agents/skills/` and `.claude/skills/`:

```text
remember
log
run
decision
learned
status
scratch
organise-scratch
check-initialisation
```

Do not create `memory/commands/` for new projects by default. Treat `system/templates/project-commands/` as legacy migration comparison material only.

During `/check-initialisation`, if legacy `memory/commands/` exists, first ensure the matching project-local skills exist. Then:

- If every legacy command file is an exact template-derived file, remove the legacy `memory/commands/` directory after the skills are in place.
- If any legacy command file has custom project-specific content, preserve `memory/commands/`, report the custom files, and do not delete them.

Do not overwrite existing memory files. If a file exists, update it only when the update is necessary and consistent with its current content.

If the user provides initial contents, context, or directions, seed them compactly into allowed memory surfaces only:

- Put stable project overview, status, blockers, and next actions into `memory/index.md`.
- Put dated setup context into today's project note.
- Put uncertain or in-flight directions into `memory/scratch/`.
- Put durable lessons, decisions, or runs into their matching structured memory files only when the user clearly provides that kind of content.
- Summarize the same seed context in the KB workstream pages when it helps future recovery.

If no initial contents are provided, create the scaffold empty from templates.

Keep project memory compact and chronological. Summarize durable lessons and link to output paths rather than pasting large logs, tables, or raw experiment output.

## Step 3: Update Project `AGENTS.md`

Use the template in:

```text
system/templates/agents-memory-block.md
```

The block must be inserted between these exact markers:

```md
<!-- BEGIN KNOWLEDGE TRACKER MEMORY DIRECTIVES -->
<!-- END KNOWLEDGE TRACKER MEMORY DIRECTIVES -->
```

Behavior:

- If `AGENTS.md` does not exist, create it with the memory block.
- If `AGENTS.md` exists and has no Knowledge Tracker memory block, append the block to the end.
- If `AGENTS.md` exists and already has the Knowledge Tracker memory block, replace only the content between the markers.
- Preserve all other `AGENTS.md` content exactly unless the user explicitly requests broader edits.

The inserted block must instruct agents to:

- Maintain today's project note during active work.
- Prefer `memory/notes/YYYY-MM-DD-<node>.md` for new notes when a stable node name is known.
- Ask the user for the stable `<node>` name if it is not known before creating or writing a new node-specific note.
- Continue reading `memory/notes/YYYY-MM-DD.md` for legacy project memory.
- Continue writing `memory/notes/YYYY-MM-DD.md` only when that legacy file is already the active note for the target date or the user explicitly asks to keep the legacy convention.
- Treat `memory/notes/YYYY-MM-DD.md` as the legacy/default-node note and `memory/notes/YYYY-MM-DD-<node>.md` as explicit-node notes.
- After every meaningful experiment, update today's note.
- After every meaningful analysis result, update today's note and `memory/learnings.md`.
- After every meaningful code change or commit, record what changed and why.
- Record node/device/server, repo path, branch/commit, command/config, dataset, output path, result, blocker, and next action where relevant.
- Update `memory/devices.md` when a new device/server/path is used.
- Update `memory/runs.md` for experiments and long-running jobs.
- Keep `memory/index.md` as the fast project overview.
- Use `memory/scratch/` for uncertain project-only captures and in-flight notes that are not ready for the structured memory files.
- Treat scratch-only work as scratch-only: do not create or update today's project note unless the scratch result is promoted, a run/decision/learning/status changes, or the user explicitly asks to log it.
- Use `memory/integrations/` for optional external connections and read `memory/integrations/index.md` before logging project work when it exists.
- Treat external integrations as visibility surfaces, not the canonical memory. Missing tools or authentication must never block local memory updates; save drafts locally and mark external publishing as skipped on the current node.
- Use project-local skills under `.agents/skills/` and `.claude/skills/` when the user starts a prompt with a project memory shortcut or explicitly asks to record project memory.
- Treat `memory/commands/` as a legacy fallback only when project-local memory skills are missing.
- Avoid pasting giant logs; summarize and link to paths.
- Prefer compact durable learning over exhaustive raw dumping.

## Step 4: Ensure `CLAUDE.md` Imports `AGENTS.md`

After `AGENTS.md` is correct, ensure Claude uses the same instructions:

```md
@AGENTS.md
```

Rules:

- `CLAUDE.md` must be a regular file, not a symlink.
- Its first non-empty line must be exactly:

  ```md
  @AGENTS.md
  ```

- If `CLAUDE.md` does not exist, create it with only that import line.
- Verify with:

```sh
test -f "$PROJECT_PATH/CLAUDE.md" && sed -n '1,5p' "$PROJECT_PATH/CLAUDE.md"
```

- The first non-empty output line must be exactly:

```md
@AGENTS.md
```

- If `CLAUDE.md` is a symlink to `AGENTS.md`, replace the symlink with the regular import file.
- If `CLAUDE.md` is a regular file, preserve its unique instructions first:
  - If the content is already only `@AGENTS.md` plus optional Claude-specific guidance, leave it as-is.
  - If the content is clearly complementary, keep it below the `@AGENTS.md` import under an appropriate existing or new heading.
  - If the content conflicts with `AGENTS.md` or the merge is ambiguous, stop and ask the user.
  - Only after preservation, rewrite `CLAUDE.md` as a regular file with `@AGENTS.md` first and preserved Claude-only guidance below it.
- Do not duplicate the full `AGENTS.md` content into `CLAUDE.md`; the duplicate will drift.
- Do not leave `CLAUDE.md` containing only the literal text `AGENTS.md`; Claude Code imports files with `@AGENTS.md`.

## Step 5: Register The Workstream In The Knowledge Base

Create or update the workstream folder:

```text
wiki/workstreams/<workstream-slug>/
  index.md          # Context Card + Active Threads + Files links + Links
  learnings.md      # durable findings
  decisions.md      # decision ledger
  runs.md           # run highlights
  logs.md           # date-headed activity entries, newest first
```

Use these templates for new files:

- `system/templates/workstream-index.md`
- `system/templates/workstream-learnings.md`
- `system/templates/workstream-decisions.md`
- `system/templates/workstream-runs.md`
- `system/templates/workstream-logs.md`

Update:

```text
wiki/workstreams/index.md
```

Add the project to the Active table if it is not already listed. Use the absolute project path.

The workstream `index.md` must include:

- A compact context card
- The absolute project path
- Whether project-local `memory/` was created or already existed
- Any observed device/server context from the user request
- Current blocker and next action
- Wiki links to `learnings`, `decisions`, `runs`, and `logs`

Seed `logs.md` with one `## YYYY-MM-DD` entry recording the initialization (project path, node, whether `memory/` was created or already existed). Leave `learnings.md`, `decisions.md`, and `runs.md` empty under the template headings; they fill in as work happens.

## Step 6: Log The Initialization

Follow `system/procedures/maintain_daily_log.md`, then append an entry to the current daily log:

```text
wiki/logs/YYYY/MM/DD.md
```

Include:

- Date
- Project name
- Project path
- Workstream slug
- Whether project `AGENTS.md` was created, appended, or updated
- Whether `CLAUDE.md` was created as an import stub, already correct, or converted after preserving Claude-only content
- Whether new memory files were created
- Which project note naming convention was used: legacy `YYYY-MM-DD.md` or node-specific `YYYY-MM-DD-<node>.md`
- Whether project-local memory skills under `.agents/skills/` and `.claude/skills/` were created or aligned
- Whether legacy `memory/commands/` was absent, migrated, preserved due to custom content, or left as a fallback
- Whether project `memory/scratch/index.md` was created or aligned
- Whether project `memory/integrations/index.md` was created or aligned
- That the target project repository was not staged, committed, or pushed

## Step 7: Verify And Sync

Before finishing, verify:

- The project path exists.
- Only allowed target-project memory infrastructure changed.
- `memory/index.md` exists.
- `memory/notes/` exists.
- `memory/scratch/index.md` exists.
- `memory/integrations/index.md` exists.
- Project-local memory skills exist under `.agents/skills/` and `.claude/skills/` for `remember`, `log`, `run`, `decision`, `learned`, `status`, `scratch`, `organise-scratch`, and `check-initialisation`.
- Legacy `memory/commands/` is absent, or preserved only because it contains custom project-specific content.
- Today's note exists.
- Project `AGENTS.md` contains exactly one Knowledge Tracker memory block.
- Project `CLAUDE.md` is a regular file whose first non-empty line is exactly `@AGENTS.md`.
- Existing project instructions were preserved.
- No target-project files were staged, committed, or pushed.
- `wiki/workstreams/index.md` links to the workstream.
- `wiki/workstreams/<workstream-slug>/` contains `index.md`, `learnings.md`, `decisions.md`, `runs.md`, `logs.md`.
- The current daily log under `wiki/logs/YYYY/MM/DD.md` records the initialization.

Then follow the root `AGENTS.md` repository sync directive for the knowledge-base repository only:

- Run `git status --short` in the knowledge-base repository.
- Stage only knowledge-base files changed for this task.
- Commit with a compact message.
- Push the current branch to its configured remote.
- If commit or push fails, report the failure and leave the repository state clear.
