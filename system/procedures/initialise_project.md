# Procedure: Initialise Project Memory

Follow this procedure when the user asks to initialize, initialise, set up, or add memory for a specific project path.

The initializer is a written agent procedure, not a script. Perform the steps directly with normal file operations.

## Inputs

Required:

- Project path

Optional:

- Project name
- Domain, for example `mobai`, `phd`, `personal`, or `mixed`
- Tags
- Workstream slug
- Device/server context

If optional values are not provided, infer conservative defaults from the project path, repository context, and user message.

## Naming Rules

- Project name defaults to the final folder name of the project path.
- Workstream slug defaults to the project name converted to lowercase with spaces and underscores changed to hyphens.
- Preserve the actual project folder name in displayed paths.
- Use the current local date for daily notes and knowledge-base daily log entries.

## Write Scope

Project memory initialization is the only default exception to the knowledge-base rule that external project repositories are read-only.

During this procedure, allowed target-project edits are limited to:

- `AGENTS.md`, only to create it or add/update the marked Sushrut memory block
- `CLAUDE.md`, only to preserve any unique regular-file instructions and make it a relative symlink to `AGENTS.md`
- `memory/index.md`
- `memory/devices.md`
- `memory/runs.md`
- `memory/learnings.md`
- `memory/decisions.md`
- `memory/notes/YYYY-MM-DD.md` or `memory/notes/YYYY-MM-DD-<device>.md`

Allowed knowledge-base edits are limited to:

- `wiki/workstreams/<workstream-slug>/index.md`
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
- Whether `CLAUDE.md` exists, and whether it is already a relative symlink to `AGENTS.md`
- Whether `README.md` exists
- Whether a `memory/` folder already exists
- Whether existing notes, docs, experiment logs, or run logs already exist
- Whether the path is a Git repository, and if so the current branch, latest commit, and relevant uncommitted status

Read existing project instructions before editing `AGENTS.md`. If `CLAUDE.md` is a regular file, read it too and preserve any unique Claude-only instructions before replacing it with a symlink.

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
    YYYY-MM-DD.md
```

If today's note already exists and clearly belongs to another device/server, create a device-specific note instead:

```text
memory/notes/YYYY-MM-DD-<device>.md
```

Use the templates in `system/templates/` for new files.

Do not overwrite existing memory files. If a file exists, update it only when the update is necessary and consistent with its current content.

Keep project memory compact and chronological. Summarize durable lessons and link to output paths rather than pasting large logs, tables, or raw experiment output.

## Step 3: Update Project `AGENTS.md`

Use the template in:

```text
system/templates/agents-memory-block.md
```

The block must be inserted between these exact markers:

```md
<!-- BEGIN SUSHRUT MEMORY DIRECTIVES -->
<!-- END SUSHRUT MEMORY DIRECTIVES -->
```

Behavior:

- If `AGENTS.md` does not exist, create it with the memory block.
- If `AGENTS.md` exists and has no Sushrut memory block, append the block to the end.
- If `AGENTS.md` exists and already has the Sushrut memory block, replace only the content between the markers.
- Preserve all other `AGENTS.md` content exactly unless the user explicitly requests broader edits.

The inserted block must instruct agents to:

- Maintain `memory/notes/YYYY-MM-DD.md` during active work.
- After every meaningful experiment, update today's note.
- After every meaningful analysis result, update today's note and `memory/learnings.md`.
- After every meaningful code change or commit, record what changed and why.
- Record device/server, repo path, branch/commit, command/config, dataset, output path, result, blocker, and next action where relevant.
- Update `memory/devices.md` when a new device/server/path is used.
- Update `memory/runs.md` for experiments and long-running jobs.
- Keep `memory/index.md` as the fast project overview.
- Avoid pasting giant logs; summarize and link to paths.
- Prefer compact durable learning over exhaustive raw dumping.

## Step 4: Ensure `CLAUDE.md` Is A Relative Symlink

After `AGENTS.md` is correct, ensure Claude uses the same instructions:

```text
CLAUDE.md -> AGENTS.md
```

Rules:

- If `CLAUDE.md` does not exist, create a relative symlink named `CLAUDE.md` whose target text is exactly `AGENTS.md`.
- The command may use an absolute link path, but the symlink target must stay relative:

```sh
ln -s AGENTS.md "$PROJECT_PATH/CLAUDE.md"
```

- Verify with:

```sh
readlink "$PROJECT_PATH/CLAUDE.md"
```

The output must be exactly:

```text
AGENTS.md
```

- Do not use `ln -s "$PROJECT_PATH/AGENTS.md" "$PROJECT_PATH/CLAUDE.md"` because that creates an absolute symlink target.
- If `CLAUDE.md` already points to `AGENTS.md`, leave it as-is unless it is absolute; prefer converting absolute links to relative links after confirming the target is the adjacent `AGENTS.md`.
- If `CLAUDE.md` is a regular file, preserve its unique instructions first:
  - If the content is clearly complementary, append it to `AGENTS.md` under an appropriate existing or new heading.
  - If the content conflicts with `AGENTS.md` or the merge is ambiguous, stop and ask the user.
  - Only after preservation, replace `CLAUDE.md` with the relative symlink.
- Do not keep separate duplicated `AGENTS.md` and `CLAUDE.md` instruction files.

## Step 5: Register The Workstream In The Main Brain

Create or update:

```text
wiki/workstreams/<workstream-slug>/index.md
```

Use `system/templates/workstream-index.md` for new pages.

Update:

```text
wiki/workstreams/index.md
```

Add the project to the Active table if it is not already listed. Use the absolute project path.

The workstream page should include:

- A compact context card
- The absolute project path
- Whether project-local `memory/` was created or already existed
- Any observed device/server context from the user request
- Current blocker and next action

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
- Whether `CLAUDE.md` was created as a relative symlink, already correct, or converted after preserving content
- Whether new memory files were created
- That the target project repository was not staged, committed, or pushed

## Step 7: Verify And Sync

Before finishing, verify:

- The project path exists.
- Only allowed target-project memory infrastructure changed.
- `memory/index.md` exists.
- `memory/notes/` exists.
- Today's note exists.
- Project `AGENTS.md` contains exactly one Sushrut memory block.
- Project `CLAUDE.md` is a relative symlink to `AGENTS.md`, verified by `readlink "$PROJECT_PATH/CLAUDE.md"` returning exactly `AGENTS.md`.
- Existing project instructions were preserved.
- No target-project files were staged, committed, or pushed.
- `wiki/workstreams/index.md` links to the workstream.
- `wiki/workstreams/<workstream-slug>/index.md` exists.
- The current daily log under `wiki/logs/YYYY/MM/DD.md` records the initialization.

Then follow the root `AGENTS.md` repository sync directive for the knowledge-base repository only:

- Run `git status --short` in the knowledge-base repository.
- Stage only knowledge-base files changed for this task.
- Commit with a compact message.
- Push the current branch to its configured remote.
- If commit or push fails, report the failure and leave the repository state clear.
