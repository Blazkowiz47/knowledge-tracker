# Command: /organise-scratch

Internal compatibility primitive. Prefer `/day close` for the normal end-of-day inbox sweep.

Sweep `wiki/scratch/` and route each captured note to its proper home.

## Inputs

- Optional: a single file name inside `wiki/scratch/` to scope the sweep to just that capture.

## Steps

1. Follow `system/procedures/organise_scratch.md`.
2. Keep external project repositories unchanged. Leave captures with proposed destinations when project-local writing would be required.
3. Stage and commit only knowledge-base files changed by routing.
4. Push the current branch.
5. Report where each capture was routed, deleted, or left.
