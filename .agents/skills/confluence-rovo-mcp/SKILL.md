---
name: confluence-rovo-mcp
description: Use when a project has a Confluence integration configured under memory/integrations/ and Codex or Claude needs to inspect linked Confluence spaces/pages/blogs, draft or publish page updates, create blog posts, or handle Confluence publishing policies through Atlassian Rovo MCP.
---

# Confluence Rovo MCP

## Overview

Use this skill as the Confluence provider adapter for project memory integrations. Local project memory remains canonical; Confluence is an optional visibility and documentation surface reached through Atlassian Rovo MCP.

## Required Local Context

Before acting, read:

- this repository's `AGENTS.md`
- project `memory/integrations/index.md`
- project `memory/integrations/confluence.md`
- the relevant linked page/blog file under `memory/integrations/confluence/`, when one exists

## Availability Check

Before any external Confluence action, verify that the `atlassian` MCP server is configured and authenticated for the current harness.

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
- Save the intended page/blog update under `memory/integrations/confluence/drafts/`.
- Record publish status as skipped for the current node.

## Page Update Workflow

Use this when a linked Confluence page exists or the user asks for a page update.

1. Identify the target page from the user request, `memory/integrations/confluence.md`, or a linked page file.
2. Use the Atlassian MCP Confluence tools exposed by the current harness to inspect the page before updating it.
3. Draft a concise stakeholder-safe update from project memory.
4. Ask before publishing unless the user explicitly requested publication or the integration policy allows it.
5. Update the relevant local page ledger after posting or drafting.

## Blog Workflow

Use this when `create-blog` is enabled and the user asks for a Confluence blog/status update.

1. Draft the title and body from local memory.
2. Ask before publishing unless the user explicitly requested publication.
3. Use Atlassian MCP Confluence tools exposed by the current harness; inspect available tool names first.
4. After posting or drafting, update the blog ledger or draft file.

## Safety Rules

- Prefer MCP over former local Atlassian CLI adapters.
- Never publish secrets, credentials, private notes, raw logs, bulky outputs, or sensitive paths.
- Prefer concise public summaries over raw project memory.
- Missing Confluence MCP access must never block local project memory updates.
