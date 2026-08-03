<p align="center">
  <img src="./assets/banner.svg" alt="late-shift — Claude Code skills for the after-hours build" width="600">
</p>

# late-shift

Claude Code skills for people who build after the day job ends.

A handful of small, opinionated markdown files that make your AI assistant behave the way you actually need
it to at 11 PM, when you have forty minutes and one shot at getting something right.

## Who this is for

- You have a full-time job, and this is not it.
- You code after the kids are asleep, before they wake up, or in the 40 minutes between.
- You're a weekend warrior with a side project that's 80% done (it has been 80% done for a year).
- You are technically strong. Your reading comprehension is fine. You're just tired.

  > *"I'm tired, boss."* — where this whole thing started.

## The skills

| Skill | What it does | Say |
| :--- | :--- | :--- |
| [`im-tired-boss`](./skills/im-tired-boss/) | Plain, warm, low-jargon answers. Short sentences, a bottom line on the long ones. | "I'm tired, boss." |
| [`poke-holes`](./skills/poke-holes/) | Stress-tests an idea before you sink a weekend into it. | "Poke holes in this." |
| [`im-feeling-lazy`](./skills/im-feeling-lazy/) | Does the work instead of handing you a to-do list. Exhausts every route before asking. | "I'm feeling lazy." |
| [`fact-sheet`](./skills/fact-sheet/) | A one-page fact sheet of your stack, and why each piece is there. | "What's this built on?" |
| [`paper-trail`](./skills/paper-trail/) | A decision log, so you can find out why your own code is like this. | "Why is this like this?" |

The last two are a pair — same problem from two angles, described together
[below](#the-two-documentation-ones). Install either, both, or neither.

### im-tired-boss

The problem isn't that AI assistants are wrong. It's that they answer every question like they're defending
a thesis — dense paragraphs, five qualifications per sentence, jargon stacked on jargon. At 9 AM with coffee,
you can parse it. At 11 PM after bedtime negotiations with a toddler? You read the same paragraph three
times and give up.

**Before:**

> The deliverable is an opinionated generalization architecture plus a skill that executes it —
> the capability-equivalence mapping is researched fresh per-invocation rather than maintained as
> a curated cross-harness index, which sidesteps the freshness burden empirically measured by the
> claims-register retraction rate, while detection routes through the existing proposal-class
> mechanism, keeping execution explicitly user-invoked and deferring the extraction question until
> demand independent of the observe-and-propose loop materializes.

That is one sentence. It has a *retraction rate* in it.

**After:**

> Don't build the encyclopedia — look things up fresh each time, because facts like this go stale
> in days. Keep it inside the existing project until it earns its own home. Build it the first
> time you actually need it, not before.
>
> **Bottom line:** file it as a backlog item and move on.

Same information. One of them you can read with a sleeping baby on your arm.

Say the line when you need it, and "okay, boss" when your coffee kicks in.

### poke-holes

You have an idea. You are alone, it is late, and you are extremely enthusiastic — historically your worst
combination. Ask, and it will genuinely try to break the idea before you spend a weekend on it.

> **You:** I want to refactor this React app to signals, I hear it's faster. Bad idea?
>
> **It:** Faster than what, measured how? Signals fix a rendering bottleneck. Nothing you've said suggests
> rendering is your bottleneck — and a whole-app state refactor is the most expensive way to find out you
> were wrong about that.
>
> **TLDR: Not yet.** Profile one slow page first. If re-renders aren't the top cost, you just saved a month.

It searches when the idea rests on a claim about the world — prior art, benchmarks, whether someone already
built this and died on it — and tells you when it didn't bother. It'll ask you a question or two where the
answer would actually change its mind.

Crucially, **it will pass good ideas fast.** A skeptic who never approves anything is exactly as useless as
a yes-man, just ruder. When it says *"couldn't talk you out of it,"* that's worth something.

> ⚠️ **Not for the easily offended.** It is blunt, occasionally crass, and calibrates its bedside manner to
> how bad the idea is. It attacks the idea, never you — but it does not soften the landing. If you want
> encouragement, this is the wrong file.

### im-feeling-lazy

You asked for a thing. You got a numbered list of things *you* now have to go do. Eighty percent of the
work is done and the remaining twenty is sitting in your lap, which is roughly where it was before you
asked.

> **You:** Go read what people are actually complaining about on Reddit. Be resourceful.
>
> **Before:** Reddit's public JSON is blocked, so here's what I'd need from you: (1) create an API app at
> reddit.com/prefs/apps, (2) paste me the client ID and secret, (3) decide whether you also want Threads
> and LinkedIn, and (4) let me know how you'd like to proceed.
>
> **After:** Public JSON is blocked and the fetch tool refuses the domain, so I drove your browser instead
> — you were already logged in. Two agents running now, Reddit and Hacker News, both on the cheap tier so
> this doesn't cost a fortune. Quotes are landing in `.local/research/`. Nothing needed from you.

It works down the list before it bothers you: tool blocked, try the CLI, try the API, try the browser,
*then* ask. When it genuinely needs you — a password, a payment, a call that's actually yours — it asks
once, batches it, and keeps working on everything else in the meantime.

It also spends money on your behalf, deliberately. Independent work gets fanned out to parallel subagents,
mechanical grunt work goes to a cheaper model, and bulk reading happens somewhere other than your main
context window. That's the trade: more tokens, less of your evening.

> ⚠️ **Lazy is about effort, not consent.** It still stops before anything irreversible or outward-facing —
> deleting things it didn't create, publishing, pushing to a shared branch, spending your money. And it
> tells you when something failed. "Just do it" doesn't mean "and tell me it went fine."

## The two documentation ones

Three months in, you can't explain your own codebase — and unlike on a team, nobody ever asked you to.

Not because you forgot. Because you never knew. The model considered the alternatives, picked one, and threw
the reasoning away for free:

> *"AI writes my code now. I have no idea why half of it is the way it is."* — r/cursor, May 2026

These two write it down instead. Both produce files in a git-committed `docs/` directory, both are written
**by the model, for you** — never for another agent to read — and neither one ever asks you to write
anything. They're separate skills because they go stale in different ways, and "maintained" means a
different job for each.

| | Writes | Goes stale by | So it's maintained by |
| :--- | :--- | :--- | :--- |
| [`fact-sheet`](./skills/fact-sheet/) | `docs/stack.md` | Drifting from the manifests | Regenerating and diffing. Never hand-edited. |
| [`paper-trail`](./skills/paper-trail/) | `docs/decisions.md` | Nothing — it's a record | Appending only. Old entries are never corrected. |

Each one also proposes a few lines for your project's `CLAUDE.md` (or `AGENTS.md`) and shows you the diff,
so the upkeep happens during normal work instead of waiting for you to remember a trigger phrase. It never
writes to your always-on config for you.

### paper-trail

The model weighed three approaches, picked one, and dropped the other two on the floor. It knew why at the
time. It just had no reason to say so, and you had no reason to ask, because the thing worked.

So this writes it down while it's still true. Three lines per entry: what changed, why this way, and what it
costs whoever hits it later.

> **Swapped Zustand for signals in the editor**
>
> Zustand re-rendered the whole canvas on every keystroke. Signals scope updates to the node that changed.
>
> Cost: editor state no longer shows up in the devtools panel, and anything reading it has to subscribe
> rather than select. Rejected memoizing the canvas — it fixed the symptom and made the tree worse.

That third paragraph is what makes an entry worth more than a commit message.

The bar is deliberately high: **would undoing this be expensive?** Architecture, a major dependency, a key
abstraction, a shortcut you took on purpose. Most work earns nothing. A good week might produce two entries.

**It starts from today.** It won't reconstruct the reasoning behind code you've already forgotten — that
would mean filing guesses next to things you actually decided, and one invented "why" makes every other
entry in the file harder to trust. You don't get the old answers back. You stop losing the new ones.

### fact-sheet

You know the big pieces. You've lost the middle — the state library, the date library, the thing doing auth,
and above all why each one is there instead of the obvious alternative.

> **Dates**
>
> **date-fns**, not Day.js or Luxon. No stated reason; likely just what got reached for first.

That second line is the whole point. It reads the manifests and the actual imports, so it's checkable — and
because it's checkable, it'll tell you things like *"your fact sheet says Zustand, nothing imports Zustand
anymore."* That's a dependency you're still paying for and no longer using.

> ⚠️ **These don't fix the volume problem.** If your actual complaint is that you just generated 600 lines
> you can't review, a fact sheet doesn't make the diff smaller. That's a different problem and it needs a
> different fix — smaller changes, review checkpoints. These two fix *provenance*, not volume.

## Install

```sh
curl -fsSL https://raw.githubusercontent.com/hartz89/late-shift/main/install.sh | sh
```

Asks which skills you want, whether they apply to every project or just this one, and puts them where Claude
Code will find them. Re-running is safe — it skips anything already installed.

Non-interactive, if you'd rather:

```sh
sh install.sh --all --scope global          # everything, everywhere
sh install.sh poke-holes --scope project    # one skill, this repo only
```

Or by hand: copy any folder from [`skills/`](./skills/) into `~/.claude/skills/` (every project) or
`.claude/skills/` (just this one). That's the whole mechanism — there's no build step and nothing to
compile.

**Want one of these on all the time?** Skills are opt-in by design, which is usually what you want — but
`im-tired-boss` is a standing preference for some people. Paste
[`skills/im-tired-boss/style.md`](./skills/im-tired-boss/style.md) into your `~/.claude/CLAUDE.md` (or
`AGENTS.md` for Cursor, Codex, Copilot) and it applies to every response, everywhere. The installer doesn't
do this for you on purpose: editing your own always-on config should be a thing you decide to do, not
something a `curl | sh` did while you weren't looking.

## Tuning them

Everything is plain markdown. Open the `SKILL.md`, change the words until it sounds like the coworker *you*
want, done. That's not a workaround — it's the point. These are short on purpose so you can actually read
one while tired and decide whether you agree with it.

## Contributing

PRs welcome, especially:

- New skills, if they fit the brief: small, opinionated, solve one real late-night problem
- Your own before/after examples (anonymize your shame)
- Evidence of what wording works better, if you actually tested it

## License

MIT. Take it, remix it, ship it. Go to bed.
