# Command: /device-sync

Conflict-safe device sync for multi-device setups.

## Purpose

Publish this node's reachable project-memory changes into node-owned KB staging files without touching global synthesis files. This is the default automation mode for non-primary devices.

## Steps

1. Resolve `KB_NODE_NAME`; ask the user for the stable lowercase node name if it is missing.
2. Run `git fetch` in the knowledge-base repository.
3. Run `git pull --ff-only` before scanning or writing.
4. Follow `system/procedures/ingest_project_day.md` in device-staging changed-source mode:
   - scan reachable registered project paths from `wiki/workstreams/index.md`
   - compare project `memory/notes/*.md` sources with `system/sync/device-ingestions/<node>/ledger.yaml`
   - publish every missing or changed source into `system/sync/device-ingestions/<node>/`
   - optionally refresh `system/sync/device-days/<node>/YYYY-MM-DD.md` for affected work dates when enough context is available
5. Keep project repositories read-only; do not pull, stage, commit, push, or edit external project repositories.
6. Do not update shared/global KB files such as `wiki/logs/`, `wiki/workstreams/`, `wiki/today.md`, `system/sync/ingestion-ledger.yaml`, or root-level `system/sync/pending-ingestions.yaml`.
7. Run `git status --short --branch` in the knowledge-base repository.
8. Stage only files under this node's device-owned sync paths:
   - `system/sync/device-ingestions/<node>/`
   - `system/sync/device-days/<node>/`
   - `system/sync/device-months/<node>/`
   - `system/sync/device-years/<node>/`
9. If there are staged changes, create a compact commit message such as `Publish <node> device sync`.
10. Push the current branch to its configured remote.
11. If no device-owned changes were needed, report that this node is already published.
12. If fetch, pull, publishing, commit, or push fails, report the failure and leave the repository state clear.

## Output

End with a concise report containing:

- node name
- fetch/pull result
- source notes published or confirmed current
- unreachable registered paths
- files changed
- commit/push result
- any sources left pending or deferred
