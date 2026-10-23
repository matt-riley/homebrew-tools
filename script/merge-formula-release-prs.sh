#!/usr/bin/env bash
# Merges open, trusted formula release pull requests oldest-first, then updates
# README on main and dispatches follow-up workflows. Intended to run under the
# formula-merge concurrency lock with origin/main checked out.

set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

: "${GH_TOKEN:?GH_TOKEN is required}"
: "${GITHUB_REPOSITORY:?GITHUB_REPOSITORY is required}"
: "${FORMULA_RELEASE_PR_AUTHORS:?FORMULA_RELEASE_PR_AUTHORS is required}"

IFS=',' read -r -a author_allowlist <<<"$FORMULA_RELEASE_PR_AUTHORS"

skip=()

skip_contains() {
  local target="$1" entry
  for entry in "${skip[@]}"; do
    [[ "$entry" == "$target" ]] && return 0
  done
  return 1
}

author_allowed() {
  local login="$1"
  local author
  for author in "${author_allowlist[@]}"; do
    author="${author#"${author%%[![:space:]]*}"}"
    author="${author%"${author##*[![:space:]]}"}"
    [[ -z "$author" ]] && continue
    if [[ "$login" == "$author" ]]; then
      return 0
    fi
  done
  return 1
}

check_runs_pass() {
  local sha="$1"
  local required=(qualify validate)
  local name state
  for name in "${required[@]}"; do
    state="$(gh api \
      -H "Accept: application/vnd.github+json" \
      "/repos/${GITHUB_REPOSITORY}/commits/${sha}/check-runs" \
      --jq ".check_runs[] | select(.name == \"${name}\" and .app.slug == \"github-actions\") | .conclusion" \
      | head -n 1)"
    if [[ "$state" != "success" ]]; then
      echo "Check run ${name} is not success on ${sha} (got: ${state:-missing})" >&2
      return 1
    fi
  done
  return 0
}

qualify_pr() {
  local head_ref="$1"
  local head_sha="$2"
  local base_ref="$3"
  local output_file
  output_file="$(mktemp)"
  GITHUB_OUTPUT="$output_file" GITHUB_HEAD_REF="$head_ref" \
    script/formula-release-pr-qualify.sh \
      --event pull_request \
      --base-ref "$base_ref" \
      --head-sha "$head_sha" >&2
  grep -q '^qualified=true$' "$output_file"
}

trust_pr() {
  local number="$1"
  local pr_json
  pr_json="$(gh pr view "$number" --json headRefName,headRefOid,baseRefName,author,headRepository,state)"

  local head_ref head_sha base_ref author_login head_repo state
  head_ref="$(jq -r '.headRefName' <<<"$pr_json")"
  head_sha="$(jq -r '.headRefOid' <<<"$pr_json")"
  base_ref="$(jq -r '.baseRefName' <<<"$pr_json")"
  author_login="$(jq -r '.author.login' <<<"$pr_json")"
  head_repo="$(jq -r '.headRepository.nameWithOwner' <<<"$pr_json")"
  state="$(jq -r '.state' <<<"$pr_json")"

  if [[ "$state" != "OPEN" ]]; then
    return 1
  fi
  if [[ "$head_repo" != "$GITHUB_REPOSITORY" ]]; then
    echo "PR #${number}: head repository ${head_repo} is not ${GITHUB_REPOSITORY}" >&2
    return 1
  fi
  if [[ "$base_ref" != "main" ]]; then
    echo "PR #${number}: base branch is not main" >&2
    return 1
  fi
  if ! author_allowed "$author_login"; then
    echo "PR #${number}: author ${author_login} is not allowed" >&2
    return 1
  fi
  git fetch -q --no-tags origin "$head_sha"
  if ! qualify_pr "$head_ref" "$head_sha" "origin/main"; then
    echo "PR #${number}: does not qualify as a formula release pull request" >&2
    return 1
  fi
  if ! check_runs_pass "$head_sha"; then
    return 1
  fi

  echo "${number} ${head_sha}"
}

merged_any=0
while true; do
  git fetch --no-tags origin main

  mapfile -t open_prs < <(gh pr list --state open --base main --json number,createdAt \
    --jq 'sort_by(.createdAt) | .[] | .number')

  merged_this_round=0
  for number in "${open_prs[@]}"; do
    [[ -z "$number" ]] && continue
    if skip_contains "$number"; then
      continue
    fi
    if ! line="$(trust_pr "$number")"; then
      continue
    fi
    read -r pr_number head_sha <<<"$line"

    echo "Merging formula release PR #${pr_number} at ${head_sha}"
    if ! gh pr merge "$pr_number" --rebase --match-head-commit "$head_sha" --delete-branch; then
      echo "::warning::merge of #${pr_number} failed; skipping" >&2
      skip+=("$pr_number")
      continue
    fi
    merged_this_round=1
    merged_any=1
    break
  done

  [[ "$merged_this_round" -eq 0 ]] && break
done

if [[ "$merged_any" -eq 0 ]] && ruby script/generate-readme.rb --check; then
  echo "No mergeable formula release pull requests and README is current."
  exit 0
fi

git fetch --no-tags origin main
git reset --hard origin/main

script/check-duplicate-package-basenames.sh

git config user.name "github-actions[bot]"
git config user.email "41898282+github-actions[bot]@users.noreply.github.com"

for attempt in 1 2 3 4; do
  git fetch --no-tags origin main
  git reset --hard origin/main
  ruby script/generate-readme.rb

  if git diff --quiet -- README.md; then
    break
  fi

  git add README.md
  git commit -m "docs: regenerate README from formulas"
  if git push origin HEAD:main; then
    break
  fi
  if [[ "$attempt" -eq 4 ]]; then
    echo "README push failed after retries" >&2
    exit 1
  fi
done

gh workflow run sync-readme.yml --ref main

if [[ "${#skip[@]}" -gt 0 ]]; then
  echo "One or more pull request merges failed: ${skip[*]}" >&2
  exit 1
fi
