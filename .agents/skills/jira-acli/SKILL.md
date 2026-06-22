---
name: jira-acli
description: Use when a project has a Jira integration configured under memory/integrations/ and Codex needs to draft or publish Jira ticket comments, create Jira work items, inspect linked Jira issues, or handle auto-comment policies through optional acli access.
---

# Jira ACLI

## Overview

Use this skill as the Jira provider adapter for project memory integrations. Local project memory remains canonical; Jira is an optional visibility surface.

## Required Local Context

Before acting, read:

- this repository's `AGENTS.md`
- project `memory/integrations/index.md`
- project `memory/integrations/jira.md`
- the relevant issue file under `memory/integrations/jira/issues/`, when one exists

## Availability Check

Before any external Jira action, run:

```sh
which acli
acli auth status
```

If either check fails:

- Do not block local memory updates.
- Do not try browser or network fallbacks unless the user explicitly asks.
- Save the intended ticket/comment under `memory/integrations/jira/drafts/`.
- Record publish status as skipped for the current node.

## Comment Workflow

Use this when `add-comment` is enabled.

1. Identify the target issue from the user request, the current default issue, or the active linked issue whose `Auto-comment` is `yes`.
2. View the issue before posting:

   ```sh
   acli jira workitem view KEY-123 --json
   ```

3. Convert local memory into a concise stakeholder-safe update.
4. For auto-comment, post only a one-line progress log after meaningful changes.
5. Never post raw logs, secrets, credentials, private notes, bulky output, or sensitive paths.
6. After posting or drafting, update the issue ledger in `memory/integrations/jira/issues/KEY-123.md`.

## Ticket Creation Workflow

Use this when `create-ticket` is enabled.

1. Draft the issue title, background, acceptance criteria, and links to safe local context.
2. Ask before creating unless the user explicitly requested creation.
3. Use `acli jira workitem create ...` only after confirming command shape with `--help` if needed.
4. If creating a subtask, use the parent issue key for `--parent`; do not use numeric issue IDs.
5. After creation, add the new issue to `memory/integrations/jira.md` and create `memory/integrations/jira/issues/KEY.md`.

## ACLI Notes

Prefer JSON for inspection and help output when command shape is unclear:

```sh
acli jira workitem --help
acli jira workitem search --jql "project = KEY" --json
```

If the global `acli` skill is available, follow its exact command guidance for Jira operations.
