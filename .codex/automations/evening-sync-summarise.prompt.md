In this knowledge-base repository, perform the conflict-safe non-coordinator evening device sync workflow only.

Use the role-aware sync skill at `.agents/skills/sync/SKILL.md`. Read and follow `AGENTS.md`, `system/commands/sync.md`, `system/sync/README.md`, and referenced procedures.

This wrapper is for non-coordinator devices only. Resolve `KB_NODE_NAME` through `system/registry/nodes.yaml`; `/sync` must select publisher behavior. Stop if the node resolves to the coordinator.

Use publisher semantics: pull safely, scan this node's sync-enabled paths from `system/registry/projects.yaml`, publish missing or changed sources, update `system/sync/device-status/<node>.yaml`, and stage, commit, and push only node-owned sync files.

Keep external projects read-only and do not update global synthesis or human logs. Successful no-op telemetry belongs in node-owned status. Record/report failures and leave repository state clear.

This is an unattended cron automation. Do not ask questions. Do not recommend focus items or next actions.

End with a concise report containing: node name, fetch/pull result, device publishing result including unreachable registered paths if any, files changed if any, and commit/push result.
