# Procedure: Plan Tomorrow

Follow this procedure when the user asks to plan tomorrow, plan the next day, or decide what to work on after syncing project memories.

## Goal

Use the current state of workstreams and recent project memories to produce a realistic next-day plan.

## Inputs

- `wiki/logs/index.md`
- `wiki/today.md`
- `wiki/workstreams/index.md`
- Relevant `wiki/workstreams/<workstream>/index.md` pages
- Recently ingested project memory notes

## Steps

1. Follow `system/procedures/maintain_daily_log.md` so summaries and today's detailed log are current.
2. Review `wiki/logs/index.md` and open dated logs only when their summaries are relevant.
3. Review active workstreams and their context cards.
4. Identify:
   - Running experiments that need checking
   - Blockers that need action
   - Promising next experiments
   - Development tasks that unblock experiments
   - Meetings, reports, papers, or deliverables implied by the notes
5. Separate the plan into:
   - Must do
   - Should do
   - Opportunistic
6. Keep the plan small enough to execute.
7. Update `wiki/today.md` for the next day if the user asks for the plan to be written.
8. Append a planning entry to today's detailed log at `wiki/logs/YYYY/MM/DD.md` if files were changed.

## Rules

- Prefer continuing useful unfinished work over starting new threads.
- Prioritize actions that unblock multiple workstreams.
- Keep each task tied to a workstream or explicit outcome.
- Do not invent deadlines or commitments.
- Do not append detailed entries to `wiki/log.md`; it is only a pointer to `wiki/logs/index.md`.
