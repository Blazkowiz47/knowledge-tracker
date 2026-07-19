# Command: /sync

Role-aware knowledge-base synchronization. This is the only sync command users normally need.

## Role Selection

1. Read `system/registry/nodes.yaml`.
2. Resolve `KB_NODE_NAME` to a canonical node or declared alias.
3. If the node is the coordinator, publish its local changes and aggregate all device staging.
4. If the node is a publisher, publish only that node's staging.
5. If the node is unknown, ask during an interactive run or fail safely unattended.

Low-level `/device-sync` and `/aggregate-sync` remain internal primitives.

## Workflow

1. Run `git fetch` and `git pull --ff-only` before scanning or writing.
2. Discover projects from `system/registry/projects.yaml`.
3. For a publisher, follow `system/commands/device-sync.md` without updating global synthesis.
4. For the coordinator, publish the coordinator's reachable changed notes, then follow `system/commands/aggregate-sync.md`.
5. Update `system/sync/device-status/<node>.yaml`; the coordinator also refreshes `system/sync/status.yaml`.
6. Do not create a human log for a successful no-op run.
7. Log only meaningful incorporated knowledge or a failure requiring attention.
8. Stage only role-allowed files, commit when needed, and push.
9. Keep external project repositories read-only.

Report the canonical node, role, fetch/pull result, source counts, knowledge changes, status update, and commit/push result.
