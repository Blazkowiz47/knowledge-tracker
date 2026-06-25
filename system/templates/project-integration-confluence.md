# Confluence Integration

Status: disabled
Provider: confluence
Adapter: atlassian-rovo-mcp
Capabilities:
- view-page
- list-spaces
- create-blog
- draft-page-update
Default publish policy: draft-first
Fallback: draft locally when Atlassian Rovo MCP is missing, unauthenticated, unavailable on this node, or lacks the needed Confluence tool.

## Availability

Required MCP setup/authentication before external actions:

Codex:

```sh
codex mcp get atlassian || codex mcp add atlassian --url https://mcp.atlassian.com/v1/mcp/authv2
codex mcp login atlassian
```

Claude Code:

```sh
claude mcp add --transport http atlassian https://mcp.atlassian.com/v1/mcp/authv2
```

Then run `/mcp` in Claude Code to authenticate if needed.

If MCP setup/auth fails or the current harness does not expose the needed Confluence tools, do not block project memory work. Save the intended page/blog update under `memory/integrations/confluence/drafts/` and mark the publish status as skipped for the current node.

## Tool Surface

Inspect the Atlassian MCP tools exposed by the current harness before acting. Do not assume exact tool names or page/blog capabilities; if the needed action is unavailable, keep a local draft and mark publishing as manual or skipped.

## Linked Spaces

| Space key | Name | Role | Status | Notes |
|---|---|---|---|---|

## Linked Pages

| Page ID | Title | Role | Status | Local state | Last local update | Last external publish |
|---|---|---|---|---|---|---|

## Linked Blogs

| Blog ID | Title | Role | Status | Last local update | Last external publish |
|---|---|---|---|---|---|

## Policy

- Local project memory is canonical; Confluence is a visibility and documentation surface.
- Draft page updates locally before publishing unless the user explicitly asks to publish.
- Blog posts may be published only when `create-blog` is enabled and the current Atlassian MCP tool surface supports the action.
- Never publish raw logs, credentials, secrets, private notes, bulky outputs, or sensitive paths.

## Directives

- Use `$confluence-rovo-mcp` as the agent adapter for Confluence actions.
- Use `memory/integrations/confluence/pages/<PAGE-ID>.md` for per-page local mapping and publish ledgers.
- Use `memory/integrations/confluence/blogs/<BLOG-ID-or-slug>.md` for per-blog local mapping and publish ledgers.
- Use `memory/integrations/confluence/drafts/` for page or blog updates that could not be posted from the current node.
- When a new Confluence page or blog becomes relevant, add it to the matching table and create a local mapping file.
