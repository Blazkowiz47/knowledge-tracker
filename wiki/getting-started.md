# Getting Started

Use this vault as a scaffold for your own tracker.

## First Setup

1. Rename the repository or vault if you want a personal name.
2. Add the device and coordinator to `system/registry/nodes.yaml`, then set `KB_NODE_NAME` to that canonical slug.
3. Run `/day start` to generate the first daily brief.
4. Add the first project with `/initialise-project`; this updates `system/registry/projects.yaml`.
5. Use `/capture` for notes whose destination may or may not be clear.

## Daily Loop

1. Run `/sync`, then `/day start`.
2. Work in project repositories and keep project-specific detail in project `memory/`.
3. Use `/capture` for meaningful knowledge during the day.
4. Use `/review` when focus or workstream lifecycle needs attention.
5. Run `/day close` for inbox cleanup, synthesis, and carry-forward.

## What Belongs Here

- Cross-project synthesis.
- Workstream context cards.
- Decisions and reusable learnings.
- Daily, monthly, and yearly summaries.
- Links to evidence stored elsewhere.

## What Does Not Belong Here

- Secrets, credentials, tokens, or private keys.
- Raw datasets or bulky experiment output.
- Full transcripts, giant logs, or generated artifacts.
- Private project details that should stay in the project repository.
