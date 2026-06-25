In this knowledge-base repository, perform the conflict-safe non-coordinator evening device sync workflow only.

Use the device-sync skill at `.agents/skills/device-sync/SKILL.md`. Read and follow this repository's `AGENTS.md`, `system/commands/device-sync.md`, `system/sync/README.md`, and any referenced procedures.

This wrapper is for non-coordinator devices only. Use `KB_NODE_NAME` as the node name. Do not run `/sync`, `/aggregate-sync`, or combined/global `/summarise-day` from this prompt.

Use device-sync semantics: run `git fetch`, run `git pull --ff-only`, scan reachable registered project memory notes, compare them with `system/sync/device-ingestions/<node>/ledger.yaml`, publish every missing or changed source into `system/sync/device-ingestions/<node>/`, optionally refresh this node's device-day summary when the command spec allows it, and then stage, commit, and push only this node-owned staging files.

Respect the knowledge-base boundary throughout: keep external project repositories read-only; do not pull, stage, commit, push, or edit external project repositories. Do not update global synthesis files such as `wiki/logs/`, `wiki/workstreams/`, `wiki/today.md`, `system/sync/ingestion-ledger.yaml`, or root-level `system/sync/pending-ingestions.yaml`. If fetch, pull, device publishing, commit, or push cannot be completed safely, report the failure and leave the repository state clear.

This is an unattended cron automation. Do not ask questions. Do not recommend focus items or next actions.

End with a concise report containing: node name, fetch/pull result, device publishing result including unreachable registered paths if any, files changed if any, and commit/push result.
