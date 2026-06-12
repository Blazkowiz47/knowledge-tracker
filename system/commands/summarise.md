# Command: /summarise

Dispatch to the appropriate summary command.

## Behavior

- Follow `system/procedures/device_aware_summaries.md` for source selection and device-aware scope.
- If the user names a day or date, follow `summarise-day.md`.
- If the user names a month, follow `summarise-month.md`.
- If the user names a year, follow `summarise-year.md`.
- If no period is specified, summarize the oldest `Pending` day first. If there are no pending days, summarize the current month.
- If the user asks for "this device", "current node", or a device summary, resolve `KB_NODE_NAME`; ask for the stable node name if it is missing.

Keep summaries brief and useful for future startup context. Open detailed logs only as needed.
