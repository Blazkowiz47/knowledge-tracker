---
name: sync
description: Use when the user types /sync or asks to synchronize the knowledge base. Resolve the current node through the registry, publish node-owned staging on publishers, and publish then aggregate on the coordinator.
---

# Sync

Use this skill as a thin adapter for the role-aware `/sync` command.

1. Read and follow this repository's `AGENTS.md`.
2. Read and follow `system/commands/sync.md`.
3. Follow referenced procedures and treat them as canonical.

Do not select low-level device or aggregation behavior independently; resolve it from `system/registry/nodes.yaml`.
