---
name: atlassian-rovo-mcp
description: Set up, authenticate, verify, and use the Atlassian Rovo remote MCP server for Jira, Confluence, Bitbucket, Compass, and Teamwork Graph work. Use when Codex or Claude needs Atlassian access, needs the official Rovo MCP server configured, or when replacing former local Atlassian CLI workflows.
---

# Atlassian Rovo MCP

## Overview

Use Atlassian Rovo MCP as the default Atlassian integration for this repository. The former local Atlassian CLI path is no longer the adapter for Jira or Confluence project-memory integrations.

## Server

- MCP server name: `atlassian`
- MCP server URL: `https://mcp.atlassian.com/v1/mcp/authv2`
- Official setup guide: `https://support.atlassian.com/atlassian-rovo-mcp-server/docs/getting-started-with-the-atlassian-remote-mcp-server/`

## Setup

For Codex:

```sh
codex mcp add atlassian --url https://mcp.atlassian.com/v1/mcp/authv2
codex mcp login atlassian
codex mcp get atlassian
```

For Claude Code:

```sh
claude mcp add --transport http atlassian https://mcp.atlassian.com/v1/mcp/authv2
```

Then open a Claude Code session and run `/mcp` to authenticate.

For JSON-based MCP clients:

```json
{
  "mcpServers": {
    "atlassian": {
      "url": "https://mcp.atlassian.com/v1/mcp/authv2"
    }
  }
}
```

If the server already exists, verify the configured URL before changing anything. Remove and re-add the server only when the existing entry points somewhere else.

## Use

- Prefer the `atlassian` MCP server for Jira, Confluence, Bitbucket, Compass, and Teamwork Graph work.
- Inspect the MCP tools exposed by the current harness before acting; do not invent tool names.
- Use `$jira-rovo-mcp` for Jira project-memory integrations and `$confluence-rovo-mcp` for Confluence project-memory integrations.
- Treat local project memory as canonical. Atlassian is a visibility and collaboration surface.
- Ask before creating or updating external Atlassian objects unless the user explicitly requested the action or the project integration policy permits auto-publishing.
- Never publish secrets, credentials, private notes, raw logs, bulky output, or sensitive local paths.
- If MCP is missing, unauthenticated, or unavailable on the current node, save a local draft and record the publish status as skipped for that node.

Do not rely on local Atlassian CLI skills. If MCP is unavailable, follow the relevant project integration policy and keep a local draft.
