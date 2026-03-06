---
name: Monthly README refresh
description: Refresh README.md from Homebrew formula metadata on a monthly schedule.
on:
  workflow_dispatch:
  schedule:
    - cron: "0 7 1 * *"
permissions:
  contents: read
tools:
  github:
    read-only: true
    toolsets: [repos]
  edit: {}
  bash:
    - "ls"
    - "cat"
    - "grep *"
    - "sed *"
    - "awk *"
    - "date *"
safe-outputs:
  create-pull-request:
    title-prefix: "[readme-sync] "
    draft: false
    if-no-changes: ignore
    fallback-as-issue: false
---

# Objective

Update `README.md` so it accurately reflects this Homebrew tap's current formulas.

## Source-of-truth and data collection

1. Read **all** formula files matching `Formula/*.rb`.
2. Treat formula files as the source of truth for:
   - tool/formula name
   - tap version
   - description
   - homepage
   - license
   - platform support (OS + architecture support inferred from formula conditions)
3. Version policy is **tap-version-only**:
   - use formula `version` values only
   - do **not** look up or claim upstream latest versions
4. For richer feature summaries, read each source repository README using the GitHub tool:
   - infer `owner/repo` from each formula homepage when it is a GitHub URL
   - read `README.md` (and common README filename variants if needed)
   - summarize features conservatively from repository README content only
   - if upstream README cannot be read, fall back to formula description without guessing

## README rewrite requirements

Rewrite `README.md` in a concise, scannable structure that includes:

- Be positive, encouraging and helpful
- Use emojiis moderately for engagement
- a short tap overview
- install instructions for adding the tap
  - `brew tap matt-riley/tools`
- per-tool install commands for every formula in the tap
  - `brew install matt-riley/tools/<formula-name>`
- a tools table with at least:
  - tool
  - tap version
  - description
  - homepage
  - license
  - platform support
- short per-tool highlights (derived from upstream READMEs when available)
- a clear note that versions come from tap formulas (tap-version-only policy)
- `Last updated: YYYY-MM-DD (UTC)`

Keep wording factual.

## Change safety and PR behavior

- Only modify `README.md`.
- Avoid noisy PRs:
  - If there is no **substantive** README change, do not create a PR.
  - Treat date-only updates (`Last updated`) and non-meaningful formatting churn as non-substantive.
- If there are substantive changes, request exactly one `create-pull-request` output with:
  - clear title indicating monthly README refresh
  - body summary of what changed
  - explicit list of formula versions used
