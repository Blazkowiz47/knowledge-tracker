# Procedure: Review The Portfolio

Read the project registry, portfolio index, every workstream frontmatter and Context Card, recent workstream evidence as needed, today's brief, inbox, pending queues, and sync status.

1. Validate every workstream has one allowed state: `now`, `next`, `waiting`, `parked`, or `archived`.
2. Compare `last_activity`, latest workstream log, blocker, next action, and `review_after`.
3. Propose state changes when evidence supports them; do not archive or reactivate on ambiguity.
4. Keep at most three `now` workstreams unless the user explicitly chooses otherwise.
5. Require one concrete next action for `now` and `next`; require an explicit dependency for `waiting`.
6. Close stale Active Threads by promoting durable outcomes and dated history.
7. Rebuild `wiki/workstreams/index.md` as a compact state-grouped portfolio without a chronological update feed.
8. Regenerate `wiki/today.md` if focus changed.
9. Log only meaningful portfolio decisions or structural changes.

For report-only review, make no changes and return proposed moves with reasons.
