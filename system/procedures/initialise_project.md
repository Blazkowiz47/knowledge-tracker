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

Project memory initialization is the only default exception to the knowledge-base rule that external project repositories are read-only.

During this procedure, allowed target-project edits are limited to:

- `AGENTS.md`, only to create it or add/update the marked Knowledge Tracker memory block
- `CLAUDE.md`, only to preserve any unique regular-file instructions and make it a relative symlink to `AGENTS.md`
- `memory/index.md`
- `memory/devices.md`
- `memory/runs.md`
- `memory/learnings.md`
- `memory/decisions.md`
- `memory/notes/YYYY-MM-DD.md` or `memory/notes/YYYY-MM-DD-<node>.md`
- `memory/scratch/index.md`
- `memory/commands/` project memory command specs

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
  commands/
    index.md
    remember.md
    log.md
    run.md
    decision.md
    learned.md
    status.md
    scratch.md
    organise-scratch.md
    check-initialisation.md
  notes/
    YYYY-MM-DD-<node>.md
  scratch/
    index.md
```

`memory/scratch/` is the project-local holding area for uncertain project-only captures and multi-day, in-flight working notes. Keep `memory/scratch/index.md` as the short routing guide. Use one topic per scratch file, for example `memory/scratch/dataset-consistency.md`. Durable findings inside a scratch file are promoted to `memory/learnings.md`, `memory/decisions.md`, `memory/runs.md`, `memory/index.md`, or a dated note; the scratch file itself is deleted or marked closed when the investigation closes.

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

Use `system/templates/project-commands/` for new `memory/commands/` files.

Do not overwrite existing memory files. If a file exists, update it only when the update is necessary and consistent with its current content.

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
- Use `memory/commands/` slash command specs when the user starts a prompt with a project memory command.
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

### Windows Fallback When Symlinks Are Not Permitted

On Windows hosts without Administrator privileges or Developer Mode enabled, all symlink-creating commands fail:

- `ln -s AGENTS.md CLAUDE.md` in Git Bash silently copies the file instead of linking, or fails with `Operation not permitted`.
- `mklink CLAUDE.md AGENTS.md` from cmd reports `You do not have sufficient privilege to perform this operation.`
- `New-Item -ItemType SymbolicLink -Path CLAUDE.md -Target AGENTS.md` reports `Administrator privilege required for this operation.`

When all three fail, do not insist on a symlink. Use this fallback:

- Replace `CLAUDE.md` with a regular file containing only this single line:

  ```text
  Read AGENTS.md in this directory for all project instructions.
  ```

- Do not duplicate the full `AGENTS.md` content into `CLAUDE.md`; the duplicate will drift.
- Do not leave `CLAUDE.md` containing only the literal text `AGENTS.md`; that is not a usable instruction to Claude, which reads `CLAUDE.md` verbatim as project guidance.
- Record in the daily log that the symlink was skipped because the host lacked Developer Mode and that `CLAUDE.md` is the documented pointer stub.
- The user can later enable Windows Developer Mode (Settings → Privacy & security → For developers) and re-run `/check-initialisation` to convert the pointer stub into a real symlink.

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
- Whether `CLAUDE.md` was created as a relative symlink, already correct, or converted after preserving content
- Whether new memory files were created
- Which project note naming convention was used: legacy `YYYY-MM-DD.md` or node-specific `YYYY-MM-DD-<node>.md`
- Whether project memory command specs under `memory/commands/` were created or aligned
- Whether project `memory/scratch/index.md` was created or aligned
- That the target project repository was not staged, committed, or pushed

## Step 7: Verify And Sync

Before finishing, verify:

- The project path exists.
- Only allowed target-project memory infrastructure changed.
- `memory/index.md` exists.
- `memory/notes/` exists.
- `memory/scratch/index.md` exists.
- `memory/commands/index.md` exists and links the project memory commands.
- Project command specs exist for `/remember`, `/log`, `/run`, `/decision`, `/learned`, `/status`, `/scratch`, `/organise-scratch`, and `/check-initialisation`.
- Today's note exists.
- Project `AGENTS.md` contains exactly one Knowledge Tracker memory block.
- Project `CLAUDE.md` is a relative symlink to `AGENTS.md`, verified by `readlink "$PROJECT_PATH/CLAUDE.md"` returning exactly `AGENTS.md`. On Windows hosts without admin/Developer Mode, the documented pointer-stub fallback (single line: `Read AGENTS.md in this directory for all project instructions.`) is acceptable.
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
