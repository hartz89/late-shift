# What late-shift is built on

Short page, because the answer is nearly nothing. That's deliberate — see below.

## Language

**POSIX `sh`**, for the one script in the repo. Not bash, not zsh. The installer has to run under whatever
`sh` is on the machine, including Debian's dash, and nothing it does needs more than POSIX gives you.

## Content

**Plain markdown.** Each skill is a `SKILL.md` with YAML frontmatter — `name` and `description`. The
`description` field is the entire invocation mechanism: Claude Code matches the user's phrasing against it
to decide whether the skill fires. Vague descriptions mean the skill never triggers.

## Dependencies

**None.** No package manager, no lockfile, no build step.

The installer shells out to `curl` — but only when it's run outside a clone, where it has to fetch files
from GitHub. Inside a clone it reads from disk and `curl` is never called.

## Hosting

**GitHub**, as a public repo. `raw.githubusercontent.com` is the delivery mechanism for `curl | sh` installs.
No CI, no releases, no published package anywhere.

## Deliberately not used

- **No package manager.** Not published to npm. Installing is copying a folder; a package would add a
  toolchain to a project whose whole pitch is that you can read it in ten minutes.
- **No CI.** The test is running `install.sh` against a `mktemp -d` sandbox by hand.
- **No test framework.** There's nothing to unit test. The skills are prose; the check is reading them.
