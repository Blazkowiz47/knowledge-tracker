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

If optional values are not provided, infer conservative defaults from the project path and repository context.

## Naming Rules

- Project name defaults to the final folder name of the project path.
- Workstream slug defaults to the project name converted to lowercase with spaces and underscores changed to hyphens.
- Preserve the actual project folder name in displayed paths.
- Use the current local date for daily notes.

## Non-Negotiable Rules

- Confirm the project path exists before editing.
- Preserve existing project instructions.
- Never remove, rewrite, reorder, or weaken existing project `AGENTS.md` content.
- Treat `AGENTS.md` as canonical.
- Ensure `CLAUDE.md` is a relative symlink to `AGENTS.md` after preserving any existing Claude-only instructions.
- Add or update only the marked Sushrut memory block.
- Do not create executable initializer scripts.
- Keep project memory compact and chronological.
- Register the project in the main knowledge base.

## Step 1: Inspect The Project

Inspect the target project path and identify:

- Whether `AGENTS.md` exists
- Whether `CLAUDE.md` exists, and whether it is already a symlink to `AGENTS.md`
- Whether `README.md` exists
- Whether a `memory/` folder already exists
- Whether existing notes, docs, experiment logs, or run logs already exist
- Whether the path is a Git repository, and if so the current branch and latest commit

Read existing project instructions before editing `AGENTS.md`. If `CLAUDE.md` is a regular file, read it too and preserve any unique Claude-only instructions before replacing it with a symlink.

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

- If `CLAUDE.md` does not exist, create a relative symlink named `CLAUDE.md` pointing to `AGENTS.md`.
- If `CLAUDE.md` already points to `AGENTS.md`, leave it as-is unless it is absolute; prefer converting absolute links to relative links.
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

## Step 6: Log The Initialization

Append an entry to:

```text
wiki/log.md
```

Include:

- Date
- Project name
- Project path
- Workstream slug
- Whether project `AGENTS.md` was created, appended, or updated
- Whether `CLAUDE.md` was created as a symlink, already correct, or converted after preserving content
- Whether new memory files were created

## Completion Checklist

Before finishing, verify:

- The project path exists.
- `memory/index.md` exists.
- `memory/notes/` exists.
- Today's note exists.
- Project `AGENTS.md` contains exactly one Sushrut memory block.
- Project `CLAUDE.md` is a relative symlink to `AGENTS.md`.
- Existing project instructions were preserved.
- `wiki/workstreams/index.md` links to the workstream.
- `wiki/workstreams/<workstream-slug>/index.md` exists.
- `wiki/log.md` records the initialization.
