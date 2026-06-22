# Confluence Integration

Status: disabled
Provider: confluence
Adapter: acli
Capabilities:
- view-page
- list-spaces
- create-blog
- draft-page-update
Default publish policy: draft-first
Fallback: draft locally when `acli` is missing, unauthenticated, unavailable on this node, or lacks the needed Confluence command.

## Availability

Required local checks before external actions:

```sh
which acli
acli auth status
acli confluence --help
```

If any required check fails, do not block project memory work. Save the intended page/blog update under `memory/integrations/confluence/drafts/` and mark the publish status as skipped for the current node.

## Command Surface

Confirm command support before acting:

```sh
acli confluence page --help
acli confluence space --help
acli confluence blog --help
```

Do not assume page search, page create, or page edit exist. If the installed `acli` cannot perform the requested Confluence action, keep a local draft and mark publishing as manual or skipped.

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
- Blog posts may be published only when `create-blog` is enabled and `acli` supports the command on the current node.
- Never publish raw logs, credentials, secrets, private notes, bulky outputs, or sensitive paths.

## Directives

- Use `memory/integrations/confluence/pages/<PAGE-ID>.md` for per-page local mapping and publish ledgers.
- Use `memory/integrations/confluence/blogs/<BLOG-ID-or-slug>.md` for per-blog local mapping and publish ledgers.
- Use `memory/integrations/confluence/drafts/` for page or blog updates that could not be posted from the current node.
- When a new Confluence page or blog becomes relevant, add it to the matching table and create a local mapping file.
