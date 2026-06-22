# Jira Integration

Status: disabled
Provider: jira
Adapter: acli
Capabilities:
- create-ticket
- add-comment
Default publish policy: draft-first
Fallback: draft locally when `acli` is missing, unauthenticated, or unavailable on this node.

## Availability

Required local checks before external actions:

```sh
which acli
acli auth status
```

If either check fails, do not block project memory work. Save the intended ticket/comment under `memory/integrations/jira/drafts/` and mark the publish status as skipped for the current node.

## Linked Issues

| Key | Role | Status | Auto-comment | Local state | Last local update | Last external publish |
|---|---|---|---|---|---|---|

## Current Default Issue

None

## Policy

- Local project memory is canonical; Jira is a visibility surface.
- Create ticket drafts before posting unless the user explicitly asks to create the ticket.
- Add comments only when `add-comment` is enabled for this integration.
- Auto-comment only on active linked issues where `Auto-comment` is `yes`.
- Auto-comments should be one-line public progress logs after meaningful changes.
- Never post raw logs, credentials, secrets, private notes, bulky outputs, or sensitive paths.

## Directives

- Use `memory/integrations/jira/issues/<KEY>.md` for per-issue local mapping and publish ledgers.
- Use `memory/integrations/jira/drafts/` for comments or tickets that could not be posted from the current node.
- When a new Jira issue becomes relevant, add it to `Linked Issues` and create a matching issue file.
- When an issue is no longer active, keep its issue file for history and mark its local state inactive.
