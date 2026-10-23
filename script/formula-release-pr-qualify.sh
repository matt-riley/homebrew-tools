#!/usr/bin/env bash
# Decides whether a pull request is an automated GoReleaser (or equivalent)
# formula release that may be validated and merged without human review.
#
# Usage:
#   formula-release-pr-qualify.sh --event pull_request --base-ref origin/main --head-sha <sha>
#
# Environment:
#   GITHUB_HEAD_REF  release branch name (e.g. hopt-0.2.14)
#
# Writes GitHub Actions outputs when GITHUB_OUTPUT is set:
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
  echo "formula-release-pr: $reason (qualified=$qualified)" >&2
}

event=""
base_ref="origin/main"
head_sha=""

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
    --head-sha)
      head_sha="$2"
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

if [[ -z "$head_sha" ]]; then
  head_sha="HEAD"
fi

if [[ ! "$head_ref" =~ ^[a-z0-9]+([._-][a-z0-9]+)*-[0-9]+\.[0-9]+\.[0-9]+(-[0-9A-Za-z.-]+)?$ ]]; then
  write_output false "head branch does not match release-branch pattern"
  exit 0
fi

if [[ "$head_ref" =~ ^(.+)-[0-9]+\.[0-9]+\.[0-9]+(-[0-9A-Za-z.-]+)?$ ]]; then
  prefix="${BASH_REMATCH[1]}"
else
  write_output false "could not derive formula prefix from branch name"
  exit 0
fi

expected_path="Formula/${prefix}.rb"

statuses=()
paths=()
while IFS= read -r -d '' status; do
  IFS= read -r -d '' path || true
  [[ -z "$status" || -z "$path" ]] && continue
  statuses+=("$status")
  paths+=("$path")
done < <(git diff --name-status --no-renames -z "${base_ref}...${head_sha}")

if [[ "${#paths[@]}" -eq 0 ]]; then
  write_output false "no changed files"
  exit 0
fi

if [[ "${#paths[@]}" -ne 1 ]]; then
  write_output false "pull request must change exactly one formula file"
  exit 0
fi

path="${paths[0]}"
status="${statuses[0]}"

case "$status" in
  M|A) ;;
  *)
    write_output false "disallowed change type ${status} for ${path}"
    exit 0
    ;;
esac

if [[ "$path" != "$expected_path" ]]; then
  write_output false "expected only ${expected_path}, got ${path}"
  exit 0
fi

if [[ ! "$path" =~ ^Formula/[^/]+\.rb$ ]]; then
  write_output false "disallowed path in pull request: ${path}"
  exit 0
fi

commit_count="$(git rev-list --count "${base_ref}..${head_sha}")"
if [[ "$commit_count" != "1" ]]; then
  write_output false "pull request must contain exactly one commit since the merge base"
  exit 0
fi

raw_line="$(git diff --raw --no-renames "${base_ref}...${head_sha}" -- "$path" || true)"
if [[ -z "$raw_line" ]]; then
  write_output false "could not determine file mode for ${path}"
  exit 0
fi

new_mode="$(awk '{print $2}' <<<"$raw_line")"
case "$new_mode" in
  100644|100755) ;;
  *)
    write_output false "disallowed file mode ${new_mode} for ${path}"
    exit 0
    ;;
esac

write_output true "qualified formula release pull request"
