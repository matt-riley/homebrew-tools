#!/usr/bin/env bash

set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

list_basenames() {
  local dir="$1"

  if [[ ! -d "$dir" ]]; then
    return 0
  fi

  find "$dir" -maxdepth 1 -type f -name "*.rb" -printf "%f\n" | sort -u
}

mapfile -t duplicate_names < <(
  comm -12 \
    <(list_basenames "$repo_root/Formula") \
    <(list_basenames "$repo_root/Casks")
)

if [[ "${#duplicate_names[@]}" -gt 0 ]]; then
  echo "Duplicate package basenames found in Formula/ and Casks/:"
  printf ' - %s\n' "${duplicate_names[@]}"
  exit 1
fi

echo "No duplicate package basenames found between Formula/ and Casks/."
