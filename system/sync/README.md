# Sync Conventions

Use `/sync`; it selects publisher or coordinator behavior from `system/registry/nodes.yaml`.

## Identity And Discovery

- `system/registry/nodes.yaml` declares nodes, aliases, roles, and the coordinator.
- `system/registry/projects.yaml` maps workstreams to project paths per node.
- `KB_NODE_NAME` must resolve through the node registry.
- Do not discover projects by parsing portfolio Markdown.

## Publisher-Owned State

Each publisher may write only:

```text
system/sync/device-ingestions/<node>/
system/sync/device-days/<node>/
system/sync/device-months/<node>/
system/sync/device-years/<node>/
system/sync/device-status/<node>.yaml
```

Retain staging after aggregation. Node ledgers record published project/source/hash identities.

## Coordinator-Owned State

The coordinator may update global workstreams/logs, `wiki/today.md`, root ledgers/queues, and `system/sync/status.yaml`. It incorporates each current staged project/source/hash once.

Successful no-op runs update operational status rather than human logs. Meaningful ingestion and failures requiring attention may enter human logs.

## Note Identity

Prefer one `memory/notes/YYYY-MM-DD-<node>.md` per project/work-date/node with explicit `node:` frontmatter. Topic documents belong in `memory/scratch/`; arbitrary suffixes are not node identities. Unsuffixed daily notes remain legacy/default-node sources.

## Failure Handling

- Root pending state is coordinator-owned; device pending state stays node-owned.
- Never mark a source incorporated unless target synthesis was written.
- Preserve useful synthesis on model, quota, network, or availability failure.
- Pull with `git pull --ff-only`; never force-push automation output.

See the ingestion procedures for detailed transitions.
