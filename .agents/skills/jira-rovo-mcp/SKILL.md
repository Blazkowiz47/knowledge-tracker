---
name: jira-rovo-mcp
description: Use when a project has a Jira integration configured under memory/integrations/ and Codex or Claude needs to inspect linked Jira issues, draft or publish Jira comments, create Jira work items, or handle auto-comment policies through Atlassian Rovo MCP.
---

# Jira Rovo MCP

## Overview

Use this skill as the Jira provider adapter for project memory integrations. Local project memory remains canonical; Jira is an optional visibility surface reached through Atlassian Rovo MCP.

## Required Local Context

Before acting, read:

- this repository's `AGENTS.md`
- project `memory/integrations/index.md`
- project `memory/integrations/jira.md`
- the relevant issue file under `memory/integrations/jira/issues/`, when one exists

## Availability Check

Before any external Jira action, verify that the `atlassian` MCP server is configured and authenticated for the current harness.

For Codex:

```sh
codex mcp get atlassian || codex mcp add atlassian --url https://mcp.atlassian.com/v1/mcp/authv2
codex mcp login atlassian
```

For Claude Code:

```sh
claude mcp add --transport http atlassian https://mcp.atlassian.com/v1/mcp/authv2
```

Then run `/mcp` in Claude Code to authenticate if needed.

If MCP setup or auth is unavailable:

- Do not block local memory updates.
- Do not use browser, CLI, or network fallbacks unless the user explicitly asks or the project policy permits it.
- Save the intended ticket/comment under `memory/integrations/jira/drafts/`.
- Record publish status as skipped for the current node.

## Comment Workflow

Use this when `add-comment` is enabled.

1. Identify the target issue from the user request, the current default issue, or the active linked issue whose `Auto-comment` is `yes`.
2. Use the Atlassian MCP Jira tools exposed by the current harness to view the issue before posting.
3. Convert local memory into a concise stakeholder-safe update.
4. For auto-comment, post only a one-line progress log after meaningful changes.
5. Never post raw logs, secrets, credentials, private notes, bulky output, or sensitive paths.
6. After posting or drafting, update the issue ledger in `memory/integrations/jira/issues/KEY-123.md`.

## Ticket Creation Workflow

Use this when `create-ticket` is enabled.

1. Draft the issue title, background, acceptance criteria, and links to safe local context.
2. Ask before creating unless the user explicitly requested creation.
3. Use Atlassian MCP Jira creation tools exposed by the current harness; inspect available tool names first.
4. If creating a subtask, use the parent issue key rather than a numeric internal issue ID.
5. After creation, add the new issue to `memory/integrations/jira.md` and create `memory/integrations/jira/issues/KEY.md`.

## Safety Rules

- Prefer MCP over former local Atlassian CLI adapters.
- Inspect before editing or commenting.
- Keep local project memory canonical.
- Missing Jira MCP access must never block local project memory updates.
