# Command: /status

Update the project context card and fast overview.

## Steps

1. Update the context card in `memory/index.md` first.
2. Keep `Status`, `Latest useful result`, `Current blocker`, and `Next action` current and specific.
3. If the stable `<node>` name is not known, ask the user for it before creating or writing a new node-specific note.
4. If `memory/integrations/index.md` exists, read it before logging and follow enabled integration policies.
5. Add a short entry to today's project note explaining what changed, preferring `memory/notes/YYYY-MM-DD-<node>.md` for new notes.
6. If an enabled integration asks for one-line auto-comments on active linked issues, publish only when the required adapter is available and authenticated; otherwise save a draft locally and mark publishing skipped.
7. If the status update reflects a decision or durable learning, update `memory/decisions.md` or `memory/learnings.md`.
