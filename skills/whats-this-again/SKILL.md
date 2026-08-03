---
name: whats-this-again
description: Write and maintain a short elevator pitch for the project that never grows into an essay. Invoke when the user needs to describe what they built, or asks for a pitch — "what is this project again", "explain this to someone", "I need to describe this", "write the elevator pitch", "what would I tell someone about this", "how do I explain what I'm building". Writes docs/pitch.md, rewrites it in place against a hard cap, and never appends.
---

# whats-this-again

Someone asks the user what they're building, and they can't answer in under two minutes. Not because it's
complicated — because they've been inside it for four months and every sentence has a caveat attached.

The artifact is `docs/pitch.md`. It is written by you **for a human** to read cold: the user, in a
conversation, borrowing words they don't have time to invent. Never for agent consumption.

## The cap is the entire skill

**200 words. One screen. No exceptions.**

The other two artifacts in this family have ground truth to keep them honest. This one has none. Left alone
it becomes a twelve-page essay in about six months — every session adds a sentence, nothing ever removes
one, and by the end nobody can read it, including the person it's about.

So the cap does the work that ground truth does elsewhere. It is a real constraint, not a suggestion:

- **Rewrite in place. Never append.** New information means something else comes out.
- **Count the words.** If it's over, cut — don't negotiate the limit down to "roughly 200."
- **The cut is the value.** Deciding what doesn't make the page is the thinking. A pitch that includes
  everything communicates nothing, which is exactly the state the user is already in.

## What's on the page

Four questions, a short paragraph each. No headers, no bullets — the point is that it reads like a person
talking.

1. **What is it?** One sentence a stranger could repeat. No metaphors, no "platform for."
2. **Who's it for, and what were they doing before?** The alternative is what makes the thing legible.
3. **What's the interesting part?** The one decision or capability that isn't obvious. Every project has
   one; this is the sentence that makes someone lean in.
4. **Where is it actually?** Honestly. Shipped, half-built, three users, nights and weekends.

Then optionally one line: **what it deliberately isn't.** Cheapest way to stop the wrong question.

That fourth one matters more than it looks. A pitch that quietly implies the project is further along than
it is will embarrass the user in a real conversation, which is the exact situation this exists to prevent.
Write the state plainly. "Works for me and two friends" is a fine thing to say out loud.

## How it should sound

Spoken, not written. Short sentences, plain words, no jargon stacking. Read `style.md` next to this file.

The test: **could the user read this aloud without editing it?** If a sentence has a parenthetical, a
semicolon, or three qualifications, they can't, and it fails. Read it back to yourself before you save it.

Avoid the words that make a pitch sound generated — *leverage, seamless, robust, powerful, comprehensive,
solution.* If a sentence would survive being pasted into a different project's README, it says nothing about
this one.

## Keeping it current

The pitch changes rarely — on a pivot, a launch, a shift in who it's for. Not on a normal Tuesday. When the
user sets this up, **propose** these lines for the project's `CLAUDE.md` (or `AGENTS.md`) and show them the
diff. Never write to their always-on config silently:

```markdown
## Elevator pitch

When what the project is or who it's for changes materially, rewrite `docs/pitch.md` in place. Hard cap 200
words — something comes out for anything that goes in. Don't touch it for ordinary feature work.
```

Nothing points an agent at this file to *read* it. It's context tax on every turn, and a page written for a
model to consume stops being a page a person can read aloud.

## Don't nag

Never block work to update the pitch. Never ask the user to write it — you write it, they correct it if
they want. If they say skip it, skip it and don't raise it again that session.

If the pitch is already under the cap and still accurate, say so in one line and get out of the way. "Still
reads right" is a complete answer.
