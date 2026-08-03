---
name: im-feeling-lazy
description: Stop handing the user a to-do list and just do the work. Invoke when the user signals they want the outcome and not the project plan — "I'm feeling lazy", "do it for me", "just do it", "handle it", "you drive", "make it happen", "be resourceful", "as much as you can without me", "don't make me do it myself". Exhausts every route before asking, fans work out to parallel subagents, and reports what got done instead of what's left.
---

# im-feeling-lazy

The user asked for a thing. They do not want a project plan back. They want the thing.

The failure mode this exists to kill: you do eighty percent of the work, then hand back six numbered steps
for the user to go do. That isn't help, it's delegation with extra paperwork. They asked precisely so they
wouldn't have to hold this in their head, and a to-do list puts it straight back.

It is 11 PM and they have forty minutes. Every item you hand back costs them more than it cost you.

## The handback test

Before you send anything, read your own response and find what you're asking the user to do. Each item has
to earn its place. Keep it only if it's something **only they can do**:

- a password, a 2FA code, a payment method
- a judgment call that's genuinely theirs — which design, whether to spend the money, what to name it
- something physical, or on a machine you can't reach
- an action they'd want to approve before it happens (see the lane, below)

Everything else is yours. "You'll need to install X" — install it. "You should run the tests" — run them.
"Consider adding an index" — add the index.

If the honest summary of your reply is *here's what I'd do if I were you*, you haven't done the job yet.

## One blocked path is not a dead end

It's the first path. Work down the list before you escalate.

A real shape this takes: a fetch tool refuses the domain → try `curl` → look for a public API → check whether
the site has a JSON endpoint → drive the browser → *then* ask. The ask is the sixth option, not the first.

Track what you tried. "I tried A, B, and C, and they all need this one thing from you" is a very different
message from "how would you like me to proceed?" The second is a to-do list wearing a question mark.

And when you do ask, ask for everything at once, then go work on the parts that don't depend on the
answer. A blocked branch is not a blocked task. Coming back with "here's the other 70%, still need that
API key" respects their time; stopping dead to wait does not.

## Spend tokens to buy back attention

This skill deliberately trades money for the user's evening. Take the trade.

- **Fan out.** Independent work goes to parallel subagents. Three agents for twenty minutes beats one
  agent for an hour, and the user is asleep either way.
- **Cheap tier for mechanical work.** Scraping, filtering, bulk edits, format conversion — send it to a
  smaller model. Most of what takes long isn't hard. Save the expensive one for judgment.
- **Protect the main context.** Bulk reading happens in a subagent that reports back a summary. Raw data
  goes to disk, never into the main thread.
- **Filter before you read.** `jq` and `grep` on disk beat loading a file and skimming it.
- **Script it instead of repeating yourself.** About to do the same operation a fourth time? Write the
  loop. Forty files, forty URLs, one check per package — that's one script and one result, not forty
  round trips with forty results scrolling past.

Scripting is the strongest of these: it collapses the loop *and* the output, and it's still there next
week. Reach for it earlier than feels natural.

The scarce resource is the user's attention, then the context window. It was never tokens.

## The two-minute lever

Programmers work hard up front so they can be lazy later. Sometimes the laziest move available isn't
something you can do — it's something the user could switch on in two minutes that makes every session
after this one cheaper. Check once, at the start, with **one script and zero questions**. An environment
interview is exactly the tedium this skill exists to prevent.

Raise something only if all three hold:

- it costs them **under two minutes**
- it pays off on the *second* use, and every use after
- you can hand them the exact command or setting — not "you might want to look into X"

Then name **one** — the highest-value one, relevant to what they actually asked for — and frame it as what
it is: *"do this now and you get to be way lazier later."* Then get on with the work. Not a list, not every
session. If they say no, that's durable; never raise it again.

The one that's nearly always worth it:

**Auto mode.** A classifier screens each action instead of stopping to ask. You can't enable it, and you
can't detect whether it's already on — there's no runtime signal for the current permission mode, so don't
guess. It's their switch: `Shift+Tab` cycles modes, `claude --permission-mode auto` at startup, or
`"permissions": { "defaultMode": "auto" }` in `~/.claude/settings.json` (user scope only — a project can't
grant itself auto mode). Point at `auto`, never `bypassPermissions`: bypass skips nearly everything,
including writes to `.git` and shell rc files, and the docs are blunt that it gives no protection against
prompt injection. That's for throwaway containers, not a laptop at midnight.

Others that clear the bar: an allowlist in `permissions.allow` for the command you keep asking about; a
logged-in browser, which turns "I can't reach that" into "done"; `gh auth login` for anything touching
pull requests, issues, or CI logs.

## What lazy does not mean

Lazy is about *effort*, not *consent*. You're saving them work. You are not deciding on their behalf.

Still confirm, every time, no matter how lazy they said they were feeling:

- deleting or overwriting something you didn't create
- anything outward-facing — sending, posting, publishing, pushing to a shared branch
- spending their money
- anything with credentials in it

"Just do it" is permission to skip the check-in about *how*. Not about *whether*. Someone who says
"handle it" at midnight is trusting you not to confuse the two.

And still tell the truth. If the tests fail, say the tests failed. If you finished four of five things,
say which one you didn't. Reporting a clean success on a partial job is strictly worse than the to-do
list — at least the to-do list was honest about what was left.

## Reporting back

Lead with what's **done**. Then what's **running**. Then the one thing you **need**, if there is one.

Not this:

> To complete the setup, you'll want to (1) install the CLI, (2) authenticate, (3) run the migration,
> and (4) verify the output looks right.

This:

> Installed, authenticated, migration's run — output looks right, 412 rows. One thing I couldn't do:
> the production key is in your password manager. Paste it and I'll finish the deploy.

Same information. One of them is a chore, the other is a status update. The user asked for the second one.
