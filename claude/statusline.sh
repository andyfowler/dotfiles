#!/bin/bash
# Claude Code status line: two lines, one jq call, one git call.
#   repo/subdir · ⎇ branch · #PR state
#   model · effort · context bar

US=$'\x1f'
IFS="$US" read -r model effort pct size cwd host owner name pr_num pr_url pr_state < <(
  jq -r '[
    .model.display_name, .effort.level,
    (.context_window.used_percentage // 0 | floor), .context_window.context_window_size,
    (.workspace.current_dir // .cwd),
    .workspace.repo.host, .workspace.repo.owner, .workspace.repo.name,
    .pr.number, .pr.url, .pr.review_state
  ] | map(. // "" | tostring) | join("")'
)

R=$'\e[0m' DIM=$'\e[2m' BOLD=$'\e[1m'
RED=$'\e[31m' GRN=$'\e[32m' YEL=$'\e[33m' BLU=$'\e[34m' MAG=$'\e[35m' CYN=$'\e[36m'
SEP=" ${DIM}·${R} "

# OSC 8 hyperlink: link URL TEXT
link() { [ -n "$1" ] && printf '\e]8;;%s\a%s\e]8;;\a' "$1" "$2" || printf '%s' "$2"; }

# --- line 1: project, branch, PR ---------------------------------------------
{ read -r top; read -r branch; } < <(git -C "$cwd" --no-optional-locks rev-parse --show-toplevel --abbrev-ref HEAD 2>/dev/null)

repo_url=""
[ -n "$owner" ] && repo_url="https://$host/$owner/$name"

# Full local path with ~; the repo root dir is bold and links to the remote.
tilde() { case $1 in "$HOME"*) printf '~%s' "${1#"$HOME"}" ;; *) printf '%s' "$1" ;; esac; }
if [ -n "$top" ]; then
  parent=$(tilde "${top%/*}")
  project="${DIM}${parent}/${R}$(link "$repo_url" "${BOLD}${CYN}${top##*/}${R}")"
  sub=${cwd#"$top"}
  [ -n "$sub" ] && project+="${DIM}${sub}${R}"
else
  project="${BOLD}${CYN}$(tilde "$cwd")${R}"
fi
line1=$project

if [ -n "$branch" ]; then
  [ "$branch" = HEAD ] && branch=detached
  branch_url=""
  [ -n "$repo_url" ] && [ "$branch" != detached ] && branch_url="$repo_url/tree/$branch"
  line1+="${SEP}${MAG}⎇ $(link "$branch_url" "$branch")${R}"
fi

if [ -n "$pr_num" ]; then
  case $pr_state in
    approved)          st="${GRN}✓ approved" ;;
    changes_requested) st="${RED}✗ changes" ;;
    pending)           st="${YEL}● review" ;;
    draft)             st="${DIM}◌ draft" ;;
    *)                 st="" ;;
  esac
  line1+="${SEP}${BLU}$(link "$pr_url" "#$pr_num")${R}"
  [ -n "$st" ] && line1+=" ${st}${R}"
fi

# --- line 2: model, effort, context ------------------------------------------
line2="${BOLD}${model}${R}"
[ -n "$effort" ] && line2+="${SEP}${DIM}effort${R} ${effort}"

if   [ "$pct" -ge 80 ]; then c=$RED
elif [ "$pct" -ge 50 ]; then c=$YEL
else c=$GRN; fi
filled=$(( (pct + 5) / 10 )); [ $filled -gt 10 ] && filled=10
bar=""
for ((i = 0; i < 10; i++)); do [ $i -lt $filled ] && bar+="▰" || bar+="▱"; done
case $size in
  1000000) sz=1M ;; 200000) sz=200k ;; "") sz="" ;; *) sz="$((size / 1000))k" ;;
esac
line2+="${SEP}${c}${bar}${R} ${pct}%${sz:+${DIM} of ${sz}${R}}"

printf '%s\n%s\n' "$line1" "$line2"
