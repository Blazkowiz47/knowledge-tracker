# Command: /log-day

Append a compact entry to today's knowledge-base daily log.

## Inputs

- Optional: text to log.
- Optional: workstream, project path, decision, blocker, or next action context.

## Steps

1. Follow `system/procedures/maintain_daily_log.md`.
2. Append a concise entry under `## Entries` in today's `wiki/logs/YYYY/MM/DD.md`.
3. Link to relevant workstream pages, project paths, commits, or files instead of pasting bulky detail.
4. Leave today's `## Summary` and month-index summary as `Pending` unless the user explicitly asks for a summary.
5. Commit and push knowledge-base changes only.
