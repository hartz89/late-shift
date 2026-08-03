# late-shift

A small library of Claude Code skills for people who build after the day job ends. Each one is a markdown
file that fixes one real problem you hit at 11 PM.

## Who we're writing for

Open-source maintainers, weekend warriors, and night owls. Full-time job elsewhere, kids possibly asleep in
the next room, forty minutes of runway. **Technically strong, just tired** — never write down to them. The
constraint is attention and time, not ability.

They are also, importantly, *alone*. No reviewer, no pair, nobody to sanity-check the idea at midnight.
Several of these skills exist to fill a seat that a team would normally fill.

## The bar for a new skill

A skill ships only if all four are true.

1. **It solves a real problem someone actually has.** Not a clever prompt. A specific, recurring annoyance
   you can name in one sentence. If the honest description is "makes the AI a bit better," it isn't ready.
2. **You can read it while tired.** Under ~120 lines. If someone can't skim it and decide whether they agree,
   they'll install it on faith, and faith is how you end up with config you can't explain.
3. **It's opinionated.** These are not configurable frameworks. They make a call. Someone who disagrees can
   edit the markdown in thirty seconds — that's the escape hatch, not a settings file.
4. **It stays in its lane.** One problem per skill. When a skill starts growing a second job, that's a second
   skill — the whole point is that you can install exactly the one thing you needed.

## Voice

The rule of thumb: **it should land in a work Slack.** A senior engineer sharing it with their team should
not have to add "ignore the tone."

- Punch at situations and ideas — never at the user, and never at their competence.
- Blunt is fine. Crass in small doses is fine. Cruelty and profanity-as-personality are not.
- Calibrate intensity to the situation. Everything at maximum volume stops meaning anything.
- Warm underneath. The premise is that we've all been there, not that the reader is a fool.
- Skills that are blunt by design need an explicit warning in the README so nobody is ambushed.

Read the **The style** section of `skills/im-tired-boss/SKILL.md` before writing prose anywhere in this repo
— README included. It's the house style, and shipping docs that violate the skill we're selling is the
obvious own-goal.

## Non-negotiables

- **Never trade honesty for tone.** Plain language and complete information aren't in tension. A skill may
  simplify *how* something is said; it must never soften, omit, or hedge a real caveat to keep things light.
- **Never refuse the user's work.** These skills advise. If the user says "I hear you, do it anyway," the
  answer is yes, and it doesn't get relitigated three messages later.
- **The installer doesn't touch always-on config.** It copies skill folders and nothing else. Editing
  someone's `CLAUDE.md` is a decision they make, not something a `curl | sh` does while they aren't looking.
- **No dependencies.** POSIX `sh`, plain markdown, no build step, no package manager. Someone should be able
  to read the whole repo in ten minutes and copy a folder by hand if they don't trust the script.

## Layout

| Path | Holds |
| :--- | :--- |
| `skills/<name>/SKILL.md` | The whole skill, one file. Frontmatter `name` + `description`; the description is what triggers it |
| `install.sh` | The only script. Add a row to `CATALOG` to ship a new skill |
| `README.md` | Per-skill pitch with a concrete before/after or sample exchange |
| `.local/` | Gitignored scratch — research, drafts, notes. Never published |

## Conventions

- Trigger phrases go in the frontmatter `description`, spelled out as things a person would actually type.
  That field is the whole invocation mechanism — vague descriptions mean the skill never fires.
- Adding a skill means four edits: the folder, the `CATALOG` row, the README table row, and a README section
  with a real example. A skill nobody can see in the README doesn't get installed.
- Test the installer in a `mktemp -d` sandbox with `SKILLS=`/`SCOPE=` env overrides before committing.
  Never test against your real `~/.claude/`.
- Commit with explicit pathspecs. Never `git add -A`.
- Claims about what other tools do, or numbers about developer behavior, need a source. Being confidently
  wrong in a repo whose whole pitch is honesty is the worst available outcome.
