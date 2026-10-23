#!/usr/bin/env bash
# Waits for the checks that must pass before a qualified formula release PR
# is merged. Intentionally excludes this repository's merge workflow so the
# waiter does not deadlock on its own in-progress check.

set -euo pipefail

pr="${1:?pull request number required}"

required_checks=(
  "Formula release PR / qualify"
  "Formula release PR / validate"
  "Formula release PR / sync-readme"
  "Duplicate package guard / duplicate-package-guard"
)

for attempt in $(seq 1 90); do
  pending=0
  for name in "${required_checks[@]}"; do
    state="$(gh pr checks "$pr" --json name,state --jq ".[] | select(.name == \"${name}\") | .state" | head -n 1)"
    case "$state" in
      SUCCESS|SKIPPED)
        ;;
      FAILURE|CANCELLED|TIMED_OUT|ACTION_REQUIRED)
        echo "Required check failed: $name ($state)" >&2
        gh pr checks "$pr" >&2 || true
        exit 1
      "")
        echo "Missing required check: $name" >&2
        pending=1
        ;;
      *)
        pending=1
        ;;
    esac
  done

  if [[ "$pending" -eq 0 ]]; then
    echo "All required formula release checks passed."
    exit 0
  fi

  sleep 15
done

echo "Timed out waiting for required formula release checks." >&2
gh pr checks "$pr" >&2 || true
exit 1
