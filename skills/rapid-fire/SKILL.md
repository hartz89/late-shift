---
name: rapid-fire
description: Run the user through the decisions that piled up while they were away, one at a time, about 30 seconds each, and act on every answer straight away. Invoke when the user comes back and wants to clear what's waiting on them — "what needs me", "what do you need from me", "rip through the decisions", "rapid fire", "let's do decisions", "what's waiting on me", "catch me up on what needs a call". Also covers keeping the running list while they're gone, so it's ready when they are.
---

# rapid-fire

The agent worked all evening while you were out. Now you're back with twenty minutes, and it hands you
fifteen questions in one wall of text. Half were settled last week. The rest assume you remember a
conversation from Tuesday. You answer three and give up, and everything stays blocked.

**Your job is to protect the user's attention.** Only the calls that are truly theirs reach them. Each one
comes alone, with enough context to answer cold, and a pick they can just say yes to.

## While they're away: sort as you go

Every call that comes up goes into one of four buckets, the moment it comes up. Never stop work to ask.

| Bucket | What goes in it | What you do |
| :--- | :--- | :--- |
| **Just decide** | Routine, or cheap to undo | Make the call. Don't list it. |
| **Decide and list** | Theirs to weigh, but cheap to undo | Go with your pick, keep working, note it in one line. |
| **Ask** | Hard to undo: money, vendors, new dependencies, legal terms, branding, product direction, security | List it with a pick. Work on something else meanwhile. |
| **Hands** | Things only they can do: sign in, pay, sign, text someone | List it with how long it takes and any deadline. |

Keep the list in a file in the repo (`decisions.md`, or wherever the project already keeps one), not only in
chat. Chat gets summarised away. The file survives.

## When they're back: triage first

Before asking anything, cut the list down hard. If you can, hand the triage to a fresh subagent that didn't
make the calls. It's easier to see what's really urgent with no stake in your own earlier work.

An item reaches the user as **Ask** only if all three hold:

1. It's consequential.
2. It's hard to reverse.
3. Answering now unblocks work or heads off a problem.

If it can safely wait weeks, it's **Later**. Write down the trigger that brings it back ("when phase 3
starts", "before the first paid user"). If you can make the call yourself, it's **Just decide**.

Order the Asks by how much work each answer unblocks. A good session has two to five. Fifteen means the
triage didn't happen.

## Asking: one at a time

Open with the count and the calls you're making yourself, one line each, so they can veto any of them:
"2 decisions. I'll also do X, Y and Z unless you object." Then the first question, in this shape:

```
Decision 1 of 2: does the feature freeze stand? (30s)

Context: two or three short sentences for someone who remembers nothing.
What it is, why it matters now, what it unblocks.

Options: A. ...  B. ...  C. ...
Recommend B. One sentence on why.
Reversible: one phrase.
```

- **Assume they remember nothing.** No "as we discussed", no item numbers without a name.
- **About 30 seconds each.** If one truly needs longer, say so in the heading and why.
- **Always recommend.** A question with no pick hands the thinking back to them.
- **One question per message.** Don't stack the next one underneath.

## Answers

- **Act on each answer right away**, in the background: start the agent, write the file, take it off the
  list. Then ask the next one.
- **Record who decided and when**, in the place the work lives, not only in the list.
- **"Not now" or "bring it back when X" is an answer.** Park it with that trigger and move on.
- **Don't re-ask** anything an earlier answer settles, this session or a past one.
- **They'll interrupt.** A bug, a new idea, a "wait, also". Handle it, then put the pending question back
  in one line: "Still open: A, B (my pick) or C?" Don't re-send the whole brief.

## Finish with the hands list

After the last decision, give the **Hands** list: most urgent first, with how long each takes and any
deadline. Put the ones that start a clock (paperwork, approvals, shipping) at the top, since waiting costs
days there.

## Don't

- Don't ask anything you could have decided yourself. Every extra question costs them more than a wrong
  call you can undo.
- Don't pad the count to look thorough, or hide a hard question to look tidy.
- Never soften a real risk to keep it at 30 seconds. If it needs the long version, take the long version.
- Don't ask for secrets in chat. Name where the secret lives and which setting it goes in.
