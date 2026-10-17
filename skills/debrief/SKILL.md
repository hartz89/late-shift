---
name: debrief
description: Close out a session where agents did the work. What shipped, what didn't, what was decided, and what it cost, with one ledger row per shipped item so the user can tell whether running this way is worth it. Invoke when the user asks how it went or wants to wrap up — "debrief", "debrief me", "how did it go", "what did we ship", "what happened while I was gone", "wrap it up", "after-action report", "was that worth it". Also at the end of any session where subagents did the work.
---

# debrief

The agents ran all evening. The user wants two answers: what happened, and whether it was worth it.
Every tool answers the first with a scroll of activity. Nobody answers the second, so the honest answer
to "is this working?" is a feeling. Feelings don't survive a bad week.

**Report the outcome, then write the receipt.** The report is for tonight. The ledger is for the question
in a month.

## The report

Same order every time. Drop a line when it's zero, and say so first if nothing shipped. A quiet night is
three lines.

```
Shipped: 3. Layers panel (#212), calibration nudges (#209), the Sentry digest (#214).
Not shipped: 1. Account deletion. Blocked on the vendor's export API; nothing for you.
Decided for you: 2. Bumped the date library. Kept the beta free. Veto either.
Still open: 1. The payment processor. Needs you, about a minute.
Cost: 4.1 agent-hours, about 1.2M tokens. 3 minutes of yours per shipped item.
Gate: 3 asks. You waved 2 through unchanged, both about copy. That's a rule now.
```

One line per item, with the number or the link. The sentence after a number says why it's that number,
not what the agents did to get there.

- **"Shipped" means merged.** An open PR isn't shipped. A deploy that rolled back isn't either, and it
  counts against the night it happened.
- **A number you don't have is blank, not guessed.** A blank is honest. A guess poisons the column.
- **"Still open" hands off to rapid-fire.** Don't stack the questions under the report.

## The ledger

One row per shipped item, appended to a CSV the project keeps (`docs/ledger.csv`, or wherever it already
has one). Append at the bottom. Never edit a row.

```
date,item,pr,agent_minutes,agent_tokens,asks,outcome
2026-10-16,layers-panel,212,96,410000,1,shipped
2026-10-19,layers-panel,212,,,,rolled back
```

- **Agent minutes and tokens come free.** Every subagent hand-back reports its duration and tokens. Write
  them down then, while you have them. Don't reconstruct them later.
- **Asks** is how many times that item needed the user. It's the column that shrinks as the rules grow.
- **A rollback is a new row**, not an edit. The record says what was true when it was written.
- **The number that matters is cost per shipped item, over weeks.** One night proves nothing. Six weeks
  of rows is the only evidence that running this way beats not running it.

This rates the agents, not the user. Nobody wants a credit rating for their side project. They do want
to know whether the thing that burns tokens all night is paying for itself.

## The gate measures itself

Two counts, both in the report:

- **Waved through.** Asks where the user took the recommendation unchanged. Three of the same kind means
  the ask was a rule waiting to be written. Write it where the project keeps its standing rules, and stop
  asking.
- **Overridden.** Asks where they picked something else. That's the recommendation being wrong. Say so,
  plainly. Trust is earned on the record, and the record includes the misses.

A gate that's working gets quieter every week. The same question coming back is a bug.

## Ceremony, rarely

One line when something ships. One line, once, when something genuinely hard lands: the first night with
zero asks, the hundredth merge. Never for effort, never for showing up, and never after a failure, where
it reads as sarcasm. The win is the number. Let it sit there.

## Making it automatic

A report nobody asks for doesn't get written. So propose this for the project's `CLAUDE.md` and show it
to the user. Never add it silently.

```markdown
## Debrief

At the end of a session where agents did the work, report what shipped, what didn't, what was decided,
and what it cost, in that order. Append one row per shipped item to `docs/ledger.csv`: date, item, PR,
agent minutes, agent tokens, asks, outcome. A rollback is a new row.
```

## Don't

- Don't narrate. "Three agents ran, two finished" is activity. "Shipped 2" is an outcome.
- Don't round a failure into progress. "Nearly shipped" is "not shipped".
- Don't block work to write the report, and never ask the user to fill in the ledger.
- Don't invent a number. Blank beats plausible.
