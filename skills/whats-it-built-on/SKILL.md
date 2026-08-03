---
name: whats-it-built-on
description: Write and maintain a one-page fact sheet of what the project is built on and why. Invoke when the user asks what their stack is, or asks to write it down — "what's this built on", "what stack is this", "what am I using here", "what are my dependencies", "make a fact sheet", "write down the stack", "what did I pick for state management". Generates docs/stack.md from package manifests and imports, and regenerates rather than hand-edits.
---

# whats-it-built-on

The user generated a lot of code fast, and somewhere in there they acquired a stack they can't fully list.
They know the big pieces. They've lost the middle — the state library, the date library, the thing doing
auth, and above all *why each one is there instead of the obvious alternative*.

The artifact is `docs/stack.md`. One page. Written by you **for a human** who is either explaining this
project to someone or trying to remember what past-them chose. Never for agent consumption.

## This one is derived, so treat it like build output

Everything in it has ground truth on disk: `package.json`, lockfiles, `pyproject.toml`, `go.mod`, `Gemfile`,
config files, CI workflows, actual import statements.

That has three consequences, and they're the whole reason this module is easy:

- **Never hand-edit it.** Regenerate.
- **Regenerating is diffing.** Read the current file, rebuild it from the manifests, and show what changed.
  Drift is a *detectable bug*, not a judgment call.
- **A mismatch is worth reporting out loud.** "Your fact sheet says Zustand, nothing imports Zustand
  anymore" is a real finding — a dependency the user is still paying for and no longer using.

Read the manifests, then check the imports. A package in `package.json` that nothing imports is dead weight,
and saying so is more useful than listing it.

## What goes in it

Group by what the thing *does*, not by which file declares it. Nobody thinks in devDependencies.

For each pick: **one line of what, one line of why.** The why is the part they lost. Where the reason isn't
recoverable from the code or the commits, say so plainly rather than inventing something plausible.

```markdown
## State

**Zustand** for app state, **signals** in the editor.
Two stores because they broke differently — Zustand re-rendered the whole canvas on every keystroke.

## Dates

**date-fns**, not Day.js or Luxon. No stated reason; likely just what got reached for first.
```

Cover: runtime and language version, framework, state, data layer, styling, build tooling, testing, hosting
and deploy, and anything non-obvious the project would break without. Skip the transitive dependency tree —
that's what the lockfile is for, and reproducing it is the fastest way to make this page unreadable.

Two short sections earn their place at the end:

- **Versions worth knowing** — only where the major version changes how you'd write code (React 19, not
  `lodash@4.17.21`).
- **Deliberately not used** — the thing someone would reasonably assume is here and isn't. "No ORM, raw SQL
  through a query builder" saves a real conversation.

## The cap

One screen. If it doesn't fit, you're listing dependencies instead of describing a stack. Cut the ones a
reader could guess.

Write it the way you'd catch up a colleague who just joined — plain words, short sentences, no jargon
stacking. Read `style.md` next to this file for the register.

## Keeping it current

This is the one artifact that can be checked mechanically, so the instruction is short. When the user sets
this up, **propose** these lines for the project's `CLAUDE.md` (or `AGENTS.md`) and show them the diff.
Never write to their always-on config silently:

```markdown
## Stack fact sheet

When a dependency is added, removed, or swapped for something else, update `docs/stack.md` — one line of
what, one line of why that one. Regenerate from the manifests rather than hand-editing. Skip patch bumps.
```

Nothing points an agent at this file to *read* it. Adding three docs to every turn's context is a real cost,
and an artifact written to be read by a model stops being readable by a person.

## Don't oversell it

If the user's actual problem is that they just generated six hundred lines they can't review, a fact sheet
doesn't help. That's volume, not provenance, and the honest answer is smaller diffs — not a document. Say so
rather than handing them a page that looks like a fix.
