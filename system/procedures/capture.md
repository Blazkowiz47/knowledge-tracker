# Procedure: Capture Knowledge

Use this procedure for `/capture` and natural-language requests to record knowledge in this repository.

## Classification

| Kind | Destination |
|---|---|
| `learning` | `wiki/workstreams/<slug>/learnings.md` |
| `decision` | `wiki/workstreams/<slug>/decisions.md` |
| `run` | `wiki/workstreams/<slug>/runs.md` |
| `status` | Workstream frontmatter and Context Card |
| `activity` | `wiki/workstreams/<slug>/logs.md` under the work date |
| `daily` | Current human log |
| `uncertain` or cross-project | One file under `wiki/scratch/` |

If workstream or kind is ambiguous, prefer the inbox. Use compact frontmatter with `captured_at`, optional `workstream`, `kind`, and `status: inbox`.

Read `system/registry/projects.yaml`, keep external projects read-only, write information once, and use a short log link only for a meaningful structural change. For status captures, update state and Context Card only when evidence supports it. For runs, require enough identity for recovery. Do not create a human log for a trivial inbox capture.

An explicit project-memory write from this repository is a boundary override: identify the exact project and files, edit only project memory, and do not stage or push that external repository unless separately authorized.
