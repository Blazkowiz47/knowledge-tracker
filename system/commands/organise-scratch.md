# Command: /organise-scratch

Sweep `wiki/scratch/` and route each captured note to its proper home.

## Inputs

- Optional: a single file name inside `wiki/scratch/` to scope the sweep to just that capture.

## Steps

1. Follow `system/procedures/organise_scratch.md`.
2. Stage and commit only knowledge-base files changed by the routing.
3. Do not stage, commit, or push any external project repository, even if the routing edited files inside its `memory/` folder.
4. Push the current branch to the configured remote.
5. Report a short summary: per scratch file, where it was routed (project path, target file) or that it was deleted or left in place.
