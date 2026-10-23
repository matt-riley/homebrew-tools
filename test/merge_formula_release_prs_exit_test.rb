# frozen_string_literal: true

require "minitest/autorun"
require "open3"

class MergeFormulaReleasePrsExitTest < Minitest::Test
  EARLY_EXIT_LOGIC = <<~'BASH'
    set -euo pipefail
    merged_any="$1"
    shift
    skip=("$@")
    readme_check() { return 0; }
    if [[ "$merged_any" -eq 0 ]] && readme_check; then
      if [[ "${#skip[@]}" -gt 0 ]]; then
        echo "One or more pull request merges failed: ${skip[*]}" >&2
        exit 1
      fi
      echo "No mergeable formula release pull requests and README is current."
      exit 0
    fi
    exit 2
  BASH

  def run_early_exit(merged_any:, skip: [])
    _stdout, stderr, status = Open3.capture3(
      "bash",
      "-c",
      EARLY_EXIT_LOGIC,
      "_",
      merged_any.to_s,
      *skip.map(&:to_s)
    )
    [status.exitstatus, stderr]
  end

  def test_exits_one_when_only_merge_failed_and_readme_current
    status, stderr = run_early_exit(merged_any: 0, skip: [42])

    assert_equal 1, status
    assert_match(/merges failed: 42/, stderr)
  end

  def test_exits_zero_when_nothing_to_do_and_no_skips
    status, = run_early_exit(merged_any: 0, skip: [])

    assert_equal 0, status
  end
end
