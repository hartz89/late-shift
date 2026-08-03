---
name: paper-trail
description: Keep a decision log so the user can find out why their own code is the way it is. Invoke when the user asks why something was built a certain way, or asks to start keeping track — "why is this like this", "why did I do it this way", "I don't remember writing this", "why did we pick X", "start a decision log", "keep a paper trail", "how did we end up here". Writes docs/decisions.md and appends only consequential decisions, as a byproduct of work already happening.
---

# paper-trail

Three months in, the user can't say why their own code is the way it is. Not because they forgot — because
they never knew. The model considered the alternatives, picked one, and threw the reasoning away for free.

**You are the only party that ever held it.** This isn't "write documentation." It's "stop discarding the
one thing nobody else can reconstruct."

The artifact is `docs/decisions.md`. It is written by you, **for a human** — the user, months from now,
trying to work out how they got here. Never for agent consumption.

## What earns an entry

A **consequential** decision. Not a confusing one, not a clever one. Log it when the decision:

- steers the project's architecture
- meaningfully limits or expands what the project can do
- borrows a large amount of technical debt to buy short-term progress
- constitutes a major strategic pivot
- adds a major new dependency
- makes a major simplification
- establishes a key abstraction

**For anything the list doesn't name, the test is: would undoing this be expensive?** Every item above shares
that property — the decision closed off other options. If reversing it is cheap, it isn't an entry.

Note this is a *consequence* bar, not a legibility one. "The code doesn't explain it" is a much lower bar and
would bury the log. Most work needs no entry. A week of honest sessions might produce two.

## The format

Three lines. What changed, why this way, and — the part that matters — **what it means for whoever hits it
later.** That last line is what makes an entry worth more than a commit message.

```markdown
## Swapped Zustand for signals in the editor

Zustand re-rendered the whole canvas on every keystroke. Signals scope updates to the node that changed.

Cost: editor state no longer shows up in the Redux devtools panel, and anything reading editor state has to
subscribe rather than select. Rejected memoizing the canvas — it fixed the symptom and made the tree worse.
```

Rules that keep it usable:

- **Append at the bottom.** Always the same end. Solo it barely matters; with a second contributor, two
  people appending to opposite ends is a merge conflict every single time.
- **Append-only.** An entry records what was true when it was written. If it later turns out wrong, that's a
  new entry, not an edit. Delete an entry only when the code it describes is gone.
- **Greppable.** Backtracking is search, not reading. Use the words someone would actually type when lost —
  the library name, the file name, the symptom.
- **No timestamps.** `git log docs/decisions.md` already dates every entry, for free.

## How it should sound

Engineers who don't have the time or the interest to read all the code and the full conversation log. Plain
words, short sentences, no jargon stacking. An entry someone has to read twice is worse than no entry.

## Making it automatic

The log only works if it's written as a byproduct of work you were already doing. **Never ask the user to
write an entry.** But a skill only fires when invoked, and nobody invokes a documentation skill at 11 PM.

So the durable version is five lines in the project's `CLAUDE.md` (or `AGENTS.md`). When the user sets this
up, **propose** this and show it to them — never write to their always-on config silently:

```markdown
## Decision log

When a decision would be expensive to undo — architecture, a major dependency, a key abstraction, a
deliberate shortcut, a pivot — append three lines to `docs/decisions.md`: what changed, why this way, and
what it costs whoever hits it later. Append at the bottom. Never edit old entries. Skip anything the code
already explains.
```

Ask once, at setup, whether anything specific to this project should always earn an entry — a payments repo
might want every rounding decision, a game every performance tradeoff. If they answer, write it into that
paragraph as a sentence. **It is not configuration.** No schema, no config key, no defaults file. It's a
sentence in a markdown file they can edit in thirty seconds.

## The log starts today

On an existing project, do not try to reconstruct decisions that were already made. It's tempting — the code
is right there and you could produce a plausible reason for most of it. Don't.

A reconstructed reason is a guess. Filed in the same list as decisions that were actually recorded, it makes
every entry less trustworthy, because a reader can no longer tell which is which. One invented "why" poisons
the file for the entries that were real.

If the user asks for a backfill anyway, that's their call — do it, but keep it in a separate section under a
heading that says it was reconstructed after the fact, and never in the main list.

Say the honest thing instead: this starts from here. You don't get the old answers back, but you stop losing
the new ones.

## Don't become the thing this repo exists to remove

- Never block work to write an entry. The log is a byproduct, not a gate.
- Never ask the user to write one.
- No scores, no debt metrics, no coverage percentage. Nobody wants a credit rating for their side project.
- If they say skip it, skip it, and don't bring it up again that session.
