# Procedure: Maintain Daily Log

Follow this procedure at the start of a knowledge-base session and before writing any knowledge-base log entry.

## Goal

Keep recent memory cheap to load by reading summaries first and detailed logs only when needed. The canonical log overview is:

```text
wiki/logs/index.md
```

Detailed daily logs live at:

```text
wiki/logs/YYYY/MM/DD.md
```

## Structure

- `wiki/logs/index.md` is the default startup surface.
- `wiki/logs/YYYY/MM/index.md` tracks daily summaries for that month.
- `wiki/logs/YYYY/MM/DD.md` contains detailed entries for one day.
- `wiki/logs/YYYY/MM/summary.md` contains month-level synthesis.
- `wiki/logs/YYYY/summary.md` contains year-level synthesis.
- `wiki/log.md` is only a compatibility pointer to `wiki/logs/index.md`.

## Startup Steps

1. Read `wiki/logs/index.md`.
2. Determine the current local date.
3. If today's daily log does not exist, create `wiki/logs/YYYY/MM/DD.md` with:
   - `# YYYY-MM-DD`
   - `## Summary`
   - `Pending`
   - `## Entries`
4. Ensure `wiki/logs/YYYY/MM/index.md` exists and has a row for today with summary `Pending`.
5. Ensure `wiki/logs/YYYY/MM/summary.md` exists. Use `Pending` while the month is active.
6. Ensure `wiki/logs/YYYY/summary.md` exists. Use `Pending` while the year is active.

## Rollover Rules

- If the current local date is newer than the latest daily log, finalize older `Pending` daily summaries before creating today's log.
- To finalize a daily summary, read the day's detailed log and write a brief, concise synthesis into both:
  - the `## Summary` section of `wiki/logs/YYYY/MM/DD.md`
  - that day's row in `wiki/logs/YYYY/MM/index.md`
- Daily summaries are not limited to one line. Prefer one compact sentence or a short phrase; use a short multi-sentence summary when the day was substantial.
- If a new month has started, create or update the previous month's `summary.md` from the month index and relevant daily logs.
- If a new year has started, create or update the previous year's `summary.md` from monthly summaries.
- If multiple older days are still `Pending`, summarize each in chronological order before adding today's row.

## Daily Logging Rules

- Append detailed curation, ingestion, planning, and structural-change entries to today's `wiki/logs/YYYY/MM/DD.md` under `## Entries`.
- Leave the active day's summary as `Pending` unless the user explicitly asks for an end-of-day summary or the day is being finalized during rollover.
- Keep entries compact. Link to evidence and workstream pages instead of pasting bulky logs or outputs.
- Keep `wiki/logs/index.md` compact. It should point to useful monthly and yearly summaries, not duplicate daily details.

## Compatibility

- Do not append detailed entries to `wiki/log.md`.
- Keep `wiki/log.md` as a short pointer to `wiki/logs/index.md`.
