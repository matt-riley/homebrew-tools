#!/usr/bin/env bash
# Decides whether a pull request is an automated GoReleaser (or equivalent)
# formula release that may be validated and merged without human review.
#
# Usage (GitHub Actions):
#   formula-release-pr-qualify.sh --event pull_request --base-ref origin/main
#
# Writes github actions outputs when GITHUB_OUTPUT is set:
#   qualified=true|false
#   reason=<short explanation>

set -euo pipefail

write_output() {
  local qualified="$1"
  local reason="$2"
  if [[ -n "${GITHUB_OUTPUT:-}" ]]; then
    {
      echo "qualified=$qualified"
      echo "reason=$reason"
    } >>"$GITHUB_OUTPUT"
  fi
  echo "formula-release-pr: $reason (qualified=$qualified)"
}

event=""
base_ref="origin/main"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --event)
      event="$2"
      shift 2
      ;;
    --base-ref)
      base_ref="$2"
      shift 2
      ;;
    *)
      echo "Unknown argument: $1" >&2
      exit 2
      ;;
  esac
done

if [[ "$event" != "pull_request" ]]; then
  write_output false "not a pull_request event"
  exit 0
fi

head_ref="${GITHUB_HEAD_REF:-}"
if [[ -z "$head_ref" ]]; then
  write_output false "missing GITHUB_HEAD_REF"
  exit 0
fi

if [[ ! "$head_ref" =~ ^[a-z0-9]+([._-][a-z0-9]+)*-[0-9]+\.[0-9]+\.[0-9]+(-[0-9A-Za-z.-]+)?$ ]]; then
  write_output false "head branch does not match release-branch pattern"
  exit 0
fi

mapfile -t changed < <(git diff --name-only "${base_ref}...HEAD" | sort -u)
if [[ "${#changed[@]}" -eq 0 ]]; then
  write_output false "no changed files"
  exit 0
fi

formula_changes=0
for path in "${changed[@]}"; do
  case "$path" in
    Formula/*.rb)
      formula_changes=$((formula_changes + 1))
      ;;
    README.md)
      ;;
    *)
      write_output false "disallowed path in pull request: $path"
      exit 0
      ;;
  esac
done

if [[ "$formula_changes" -lt 1 ]]; then
  write_output false "pull request must change at least one Formula/*.rb file"
  exit 0
fi

write_output true "qualified formula release pull request"
