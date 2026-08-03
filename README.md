# late-shift

Claude Code skills for people who build after the day job ends.

Not a productivity system. Not a framework. A handful of small, opinionated markdown files that make your
AI assistant behave the way you actually need it to at 11 PM, when you have forty minutes and one shot at
getting something right.

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

This one runs two ways: **always on**, as an import in your `CLAUDE.md`, or **on demand**, where you say the
line when you need it and "okay, boss" when your coffee kicks in.

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

`im-tired-boss` in always-on mode is the one exception: the installer drops the rules file next to your
`CLAUDE.md` and adds a single `@import` line, so your `CLAUDE.md` stays readable and the actual words live
in one file you can edit. Other tools (Cursor, Codex, Copilot) don't support `@import` — paste the contents
of [`skills/im-tired-boss/style.md`](./skills/im-tired-boss/style.md) into your `AGENTS.md` instead.

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
