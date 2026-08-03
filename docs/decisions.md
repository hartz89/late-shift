# Decision log

Consequential decisions only — the ones that would be expensive to undo. Newest at the bottom.
Dates come from `git log docs/decisions.md`, not from this file.

Entries above the line marked *backfilled* were reconstructed after the fact and are less reliable than
the ones written as the work happened.

---

## Skills only — dropped the always-on install path

*Backfilled.*

The installer used to be able to write style rules into the user's `CLAUDE.md`. It now copies skill folders
and nothing else.

A `curl | sh` that edits always-on config is editing something the user will be living with in every session,
in every project, without having read it. That's a decision they should make, not one a one-liner makes
while they aren't looking.

Cost: the skills are opt-in, so they only fire when someone remembers a trigger phrase. `im-tired-boss` in
particular is a standing preference for some people and now needs a manual paste. The README documents that
paste rather than automating it. This constraint is load-bearing for anything added later — the three
documentation modules propose `CLAUDE.md` lines and show a diff instead of writing them.

## No dependencies, POSIX sh only

*Backfilled.*

No package manager, no build step, no test framework, no CI. The installer is one POSIX `sh` script.

The pitch is that you can read the entire repo in ten minutes and copy a folder by hand if you don't trust
the script. A toolchain breaks that immediately — the moment there's a `package.json`, "read it yourself"
stops being a real offer.

Cost: no automated tests. The installer is verified by hand against a `mktemp -d` sandbox before every
commit that touches it, and that discipline is the only thing standing between a typo and a broken
`curl | sh` for everyone. Rejected publishing to npm for the same reason.

## The frontmatter `description` is the whole invocation mechanism

*Backfilled.*

Trigger phrases live in each skill's frontmatter `description`, spelled out as things a person would
actually type — not as keywords.

There is no other way to make a skill fire. Claude Code matches user phrasing against that field and nothing
else, so a description that reads like a summary produces a skill that never runs.

Cost: every new skill needs its triggers guessed in advance, and a wrong guess is silent — the skill just
never activates and nobody finds out. Practical implication: write the triggers as overheard sentences, and
put more of them in than feels necessary.

## Research and scratch notes are gitignored, not published

*Backfilled.*

`.local/` and `CLAUDE.local.md` are ignored. They hold social research, drafts, roadmap thinking, and
verbatim quotes gathered from public forums.

The research exists to pick what to build next. Publishing it would mean publishing other people's posts,
collected and re-hosted, plus half-formed opinions about a roadmap that keeps changing.

Cost: claims in the README that rest on that research have no visible source, so anything load-bearing has
to be re-sourced publicly before it's stated. The repo's own rule is that being confidently wrong in a repo
about honesty is the worst available outcome.

## Three documentation modules, not one

The comprehension-debt problem produced three artifacts — a pitch, a fact sheet, and a decision log —
shipped as three separate skills rather than one.

They decay in completely different ways. The fact sheet is *derived*: it has ground truth in the manifests,
so it gets regenerated and diffed. The decision log is *historical*: append-only, never corrected, because
an entry records what was true when it was written. The pitch is *curated*: no ground truth at all, so a
hard word cap is the only thing keeping it honest. One skill trying to hold all three maintenance rules
would either state them vaguely or run long enough that nobody reads it.

Cost: three folders, three `CATALOG` rows, three README sections, and three copies of `style.md` — because
no dependencies means no shared file. Someone who wants all three installs all three. That's the trade for
being able to install exactly the one you needed.
