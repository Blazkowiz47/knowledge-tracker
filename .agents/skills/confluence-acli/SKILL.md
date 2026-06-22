---
name: confluence-acli
description: Use when a project has a Confluence integration configured under memory/integrations/ and Codex needs to draft Confluence page updates, inspect linked Confluence spaces/pages/blogs, create Confluence blog posts, or handle Confluence publishing policies through optional acli access.
---

# Confluence ACLI

## Overview

Use this skill as the Confluence provider adapter for project memory integrations. Local project memory remains canonical; Confluence is an optional visibility and documentation surface.

## Required Local Context

Before acting, read:

- this repository's `AGENTS.md`
- project `memory/integrations/index.md`
- project `memory/integrations/confluence.md`
- the relevant linked page/blog file under `memory/integrations/confluence/`, when one exists

## Availability Check

Before any external Confluence action, run:

```sh
which acli
acli auth status
acli confluence --help
```

If any required check fails:

- Do not block local memory updates.
- Do not try browser or network fallbacks unless the user explicitly asks.
- Save the intended page/blog update under `memory/integrations/confluence/drafts/`.
- Record publish status as skipped for the current node.

## Capability Check

Confluence `acli` support may be narrower than Jira support. Inspect help before assuming a command exists:

```sh
acli confluence page --help
acli confluence space --help
acli confluence blog --help
```

Only use commands that are available on the current node. If page create/edit/search is unavailable, draft the update locally instead of pretending it was published.

## Page Update Workflow

Use this when a linked Confluence page exists or the user asks for a page update.

1. Identify the target page from the user request, `memory/integrations/confluence.md`, or a linked page file.
2. View the page by ID when supported:

   ```sh
   acli confluence page view PAGE-ID
   ```

3. Draft a concise stakeholder-safe update from project memory.
4. If page edit/create is unavailable, save the draft locally and mark publishing skipped/manual.
5. Update the relevant local page ledger.

## Blog Workflow

Use this when `create-blog` is enabled and the user asks for a Confluence blog/status update.

1. Draft the title and body from local memory.
2. Ask before publishing unless the user explicitly requested publication.
3. Confirm command shape with `acli confluence blog --help`.
4. After posting or drafting, update the blog ledger or draft file.

## Safety Rules

- Never publish secrets, credentials, private notes, raw logs, bulky outputs, or sensitive paths.
- Prefer concise public summaries over raw project memory.
- Missing Confluence access must never block local project memory updates.
- If the global `acli` skill is available, follow its exact Confluence command guidance.
