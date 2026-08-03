#!/bin/sh
# late-shift installer. POSIX sh, no dependencies but curl (only when run
# outside a clone). Safe to re-run.
#
#   sh install.sh                        interactive
#   sh install.sh --all                  every skill
#   sh install.sh poke-holes             named skills
#   sh install.sh --all --scope project  no prompts at all
set -eu

REPO_RAW="https://raw.githubusercontent.com/hartz89/late-shift/main"
MARKER="<!-- im-tired-boss -->"

# Every skill in the library: name<TAB>one-liner. Add a row to ship a new one.
CATALOG='im-tired-boss	Plain, warm, low-jargon answers. For reading at 11 PM.
poke-holes	Stress-tests an idea before you sink a weekend into it.'

fetch() {
  # $1 = path relative to the repo root
  if [ -f "$1" ]; then
    cat "$1"
  else
    curl -fsSL "$REPO_RAW/$1"
  fi
}

prompt() {
  # $1 = prompt text, sets REPLY. Reads from the terminal even when this
  # script itself arrived via `curl | sh`, where stdin is the pipe.
  printf '%s' "$1" >&2
  if [ -r /dev/tty ]; then
    read -r REPLY </dev/tty
  else
    read -r REPLY
  fi
}

known() {
  # $1 = skill name
  echo "$CATALOG" | cut -f1 | grep -qx "$1"
}

SKILLS="${SKILLS:-}"
SCOPE="${SCOPE:-}"
MODE="${MODE:-}"

while [ $# -gt 0 ]; do
  case "$1" in
    --all) SKILLS=$(echo "$CATALOG" | cut -f1 | tr '\n' ' '); shift ;;
    --scope) SCOPE="$2"; shift 2 ;;
    --always-on) MODE="always-on"; shift ;;
    --on-demand) MODE="on-demand"; shift ;;
    -*) echo "Unknown flag: $1" >&2; exit 1 ;;
    *)
      if known "$1"; then
        SKILLS="$SKILLS $1"; shift
      else
        echo "No skill called '$1'. Available:" >&2
        echo "$CATALOG" | cut -f1 | sed 's/^/  /' >&2
        exit 1
      fi
      ;;
  esac
done

if [ -z "$SKILLS" ]; then
  echo "late-shift — which skills do you want?" >&2
  i=1
  echo "$CATALOG" | while IFS="$(printf '\t')" read -r name desc; do
    printf '  %d) %-16s %s\n' "$i" "$name" "$desc" >&2
    i=$((i + 1))
  done
  echo "  a) all of them" >&2
  prompt "Pick by number, space-separated, or 'a': "
  case "$REPLY" in
    a|A|all)
      SKILLS=$(echo "$CATALOG" | cut -f1 | tr '\n' ' ')
      ;;
    *)
      for n in $REPLY; do
        pick=$(echo "$CATALOG" | cut -f1 | sed -n "${n}p" 2>/dev/null || true)
        if [ -n "$pick" ]; then SKILLS="$SKILLS $pick"; fi
      done
      ;;
  esac
fi

if [ -z "$(echo "$SKILLS" | tr -d ' ')" ]; then
  echo "Nothing selected. Run again and pick at least one." >&2
  exit 1
fi

if [ -z "$SCOPE" ]; then
  prompt "Every project, or just this one? [every/this]: "
  case "$REPLY" in
    every*) SCOPE="global" ;;
    this*) SCOPE="project" ;;
    *) echo "Didn't catch that — run again and pick 'every' or 'this'." >&2; exit 1 ;;
  esac
fi

if [ "$SCOPE" = "global" ]; then
  SKILL_ROOT="$HOME/.claude/skills"
else
  SKILL_ROOT="./.claude/skills"
fi

# im-tired-boss is the one skill that can also run always-on, since it's a
# standing style preference rather than something you reach for.
wants_tired_boss=no
for s in $SKILLS; do
  [ "$s" = "im-tired-boss" ] && wants_tired_boss=yes
done

if [ "$wants_tired_boss" = yes ] && [ -z "$MODE" ]; then
  echo "im-tired-boss can run two ways:" >&2
  echo "  1) On demand  — say \"I'm tired, boss\" whenever you need it" >&2
  echo "  2) Always on  — plain, warm answers in every response, from now on" >&2
  prompt "Pick one [1/2]: "
  case "$REPLY" in
    1) MODE="on-demand" ;;
    2) MODE="always-on" ;;
    *) echo "Didn't catch that — run again and pick 1 or 2." >&2; exit 1 ;;
  esac
fi

install_skill() {
  # $1 = skill name. Copies SKILL.md plus any bundled files it needs.
  dest="$SKILL_ROOT/$1"
  if [ -f "$dest/SKILL.md" ]; then
    echo "  $1 — already at $dest, skipped" >&2
    return 0
  fi
  mkdir -p "$dest"
  fetch "skills/$1/SKILL.md" > "$dest/SKILL.md"
  if [ "$1" = "im-tired-boss" ]; then
    fetch "skills/im-tired-boss/style.md" > "$dest/style.md"
  fi
  echo "  $1 — installed at $dest" >&2
}

install_always_on() {
  if [ "$SCOPE" = "global" ]; then
    target="$HOME/.claude/CLAUDE.md"
    style="$HOME/.claude/im-tired-boss-style.md"
    import="@im-tired-boss-style.md"
  else
    target="./CLAUDE.md"
    style="./.claude/im-tired-boss-style.md"
    import="@.claude/im-tired-boss-style.md"
  fi
  mkdir -p "$(dirname "$target")" "$(dirname "$style")"
  if [ -f "$target" ] && grep -qF "$MARKER" "$target" 2>/dev/null; then
    echo "  im-tired-boss — already imported into $target, skipped" >&2
    return 0
  fi
  fetch "skills/im-tired-boss/style.md" > "$style"
  { echo ""; echo "$MARKER"; echo "$import"; } >> "$target"
  echo "  im-tired-boss — rules at $style, imported into $target" >&2
}

for s in $SKILLS; do
  if [ "$s" = "im-tired-boss" ] && [ "$MODE" = "always-on" ]; then
    install_always_on
  else
    install_skill "$s"
  fi
done

echo "" >&2
echo "Done." >&2
for s in $SKILLS; do
  case "$s" in
    im-tired-boss)
      if [ "$MODE" = "always-on" ]; then
        echo "  Using Cursor/Codex/Copilot too? Paste the style file into AGENTS.md — no @import there." >&2
      else
        echo "  Say \"I'm tired, boss\" when you need it. \"okay, boss\" turns it back off." >&2
      fi
      ;;
    poke-holes)
      echo "  Say \"poke holes in this\" or \"is this a bad idea?\" to stress-test something." >&2
      ;;
  esac
done
