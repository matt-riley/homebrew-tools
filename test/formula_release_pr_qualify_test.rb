# frozen_string_literal: true

require "minitest/autorun"
require "open3"
require "tmpdir"
require "fileutils"

class FormulaReleasePrQualifyTest < Minitest::Test
  SCRIPT = File.expand_path("../script/formula-release-pr-qualify.sh", __dir__)

  def run_qualify(head_ref:, head_sha: nil, files: nil, delete_paths: [], base_files: nil, extra_commits: 0, executable: nil)
    base_files = { "Formula/placeholder.rb" => "class Placeholder < Formula\nend\n" } if base_files.nil?
    files ||= {}

    Dir.mktmpdir do |dir|
      base_files.each do |path, content|
        full = File.join(dir, path)
        FileUtils.mkdir_p(File.dirname(full))
        File.write(full, content)
      end

      system("git", "-C", dir, "init", "-q")
      system("git", "-C", dir, "config", "user.email", "test@example.com")
      system("git", "-C", dir, "config", "user.name", "Test")
      system("git", "-C", dir, "add", ".")
      system("git", "-C", dir, "commit", "-qm", "base")
      system("git", "-C", dir, "branch", "-M", "main")

      system("git", "-C", dir, "checkout", "-qb", head_ref)

      delete_paths.each do |path|
        system("git", "-C", dir, "rm", path)
      end

      files.each do |path, content|
        full = File.join(dir, path)
        FileUtils.mkdir_p(File.dirname(full))
        File.write(full, content)
        File.chmod(0o755, full) if executable == path
        system("git", "-C", dir, "add", path)
      end

      if files.any? || delete_paths.any?
        system("git", "-C", dir, "commit", "-qm", "change")
        extra_commits.times do |index|
          path = files.keys.first
          File.write(File.join(dir, path), "rev #{index}\n")
          system("git", "-C", dir, "add", path)
          system("git", "-C", dir, "commit", "-qm", "extra #{index}")
        end
      end

      head_sha ||= `git -C #{dir} rev-parse HEAD`.strip

      stdout, stderr, status = Open3.capture3(
        {
          "GITHUB_HEAD_REF" => head_ref,
          "GITHUB_OUTPUT" => File.join(dir, "output.txt"),
        },
        SCRIPT,
        "--event", "pull_request",
        "--base-ref", "main",
        "--head-sha", head_sha,
        chdir: dir
      )

      output = File.read(File.join(dir, "output.txt"))
      qualified = output[/^qualified=(\w+)/, 1]
      reason = output[/^reason=(.*)/, 1]

      [status.success?, qualified, reason, stdout, stderr]
    end
  end

  def test_accepts_single_formula_change_matching_branch_prefix
    ok, qualified, reason, = run_qualify(
      head_ref: "hopt-0.2.14",
      base_files: { "Formula/hopt.rb" => "old\n" },
      files: { "Formula/hopt.rb" => "new\n" }
    )

    assert ok
    assert_equal "true", qualified
    assert_match(/qualified formula release/, reason)
  end

  def test_rejects_branch_without_version_suffix
    ok, qualified, reason, = run_qualify(
      head_ref: "readme-sync/example",
      files: { "Formula/hopt.rb" => "new\n" }
    )

    assert ok
    assert_equal "false", qualified
    assert_match(/release-branch pattern/, reason)
  end

  def test_rejects_readme_changes
    ok, qualified, reason, = run_qualify(
      head_ref: "newbrew-0.1.0",
      base_files: { "Formula/newbrew.rb" => "old\n" },
      files: {
        "Formula/newbrew.rb" => "new\n",
        "README.md" => "readme\n",
      }
    )

    assert ok
    assert_equal "false", qualified
    assert_match(/exactly one formula file/, reason)
  end

  def test_rejects_formula_deletion
    ok, qualified, reason, = run_qualify(
      head_ref: "crap-0.1.5",
      base_files: {
        "Formula/crap.rb" => "old\n",
        "Formula/other.rb" => "keep\n",
      },
      delete_paths: ["Formula/crap.rb"]
    )

    assert ok
    assert_equal "false", qualified
    assert_match(/disallowed change type/, reason)
  end

  def test_rejects_rename_into_formula
    ok, qualified, reason, = run_qualify_rename(
      head_ref: "evil-1.0.0",
      from: "script/evil.sh",
      to: "Formula/evil.rb",
      base_files: { "script/evil.sh" => "#!/bin/sh\n" }
    )

    assert ok
    assert_equal "false", qualified
    assert_match(/exactly one formula file|expected only/, reason)
  end

  def run_qualify_rename(head_ref:, from:, to:, base_files:)
    Dir.mktmpdir do |dir|
      base_files.each do |path, content|
        full = File.join(dir, path)
        FileUtils.mkdir_p(File.dirname(full))
        File.write(full, content)
      end

      system("git", "-C", dir, "init", "-q")
      system("git", "-C", dir, "config", "user.email", "test@example.com")
      system("git", "-C", dir, "config", "user.name", "Test")
      system("git", "-C", dir, "add", ".")
      system("git", "-C", dir, "commit", "-qm", "base")
      system("git", "-C", dir, "branch", "-M", "main")
      system("git", "-C", dir, "checkout", "-qb", head_ref)
      FileUtils.mkdir_p(File.dirname(File.join(dir, to)))
      system("git", "-C", dir, "mv", from, to)
      File.write(File.join(dir, to), "class Evil < Formula\nend\n")
      system("git", "-C", dir, "add", to)
      system("git", "-C", dir, "commit", "-qm", "rename")

      head_sha = `git -C #{dir} rev-parse HEAD`.strip
      stdout, stderr, status = Open3.capture3(
        {
          "GITHUB_HEAD_REF" => head_ref,
          "GITHUB_OUTPUT" => File.join(dir, "output.txt"),
        },
        SCRIPT,
        "--event", "pull_request",
        "--base-ref", "main",
        "--head-sha", head_sha,
        chdir: dir
      )

      output = File.read(File.join(dir, "output.txt"))
      [status.success?, output[/^qualified=(\w+)/, 1], output[/^reason=(.*)/, 1], stdout, stderr]
    end
  end

  def test_rejects_nested_formula_path
    ok, qualified, reason, = run_qualify(
      head_ref: "nested-1.0.0",
      files: { "Formula/nested/extra.rb" => "class Extra < Formula\nend\n" }
    )

    assert ok
    assert_equal "false", qualified
    assert_match(/expected only|disallowed path/, reason)
  end

  def test_rejects_prefix_mismatch
    ok, qualified, reason, = run_qualify(
      head_ref: "hopt-0.2.14",
      base_files: { "Formula/skill-eval.rb" => "old\n" },
      files: { "Formula/skill-eval.rb" => "new\n" }
    )

    assert ok
    assert_equal "false", qualified
    assert_match(/expected only Formula\/hopt.rb/, reason)
  end

  def test_qualify_logs_to_stderr_not_stdout
    ok, _qualified, _reason, stdout, stderr = run_qualify(
      head_ref: "hopt-0.2.14",
      base_files: { "Formula/hopt.rb" => "old\n" },
      files: { "Formula/hopt.rb" => "new\n" }
    )

    assert ok
    assert_empty stdout.strip
    assert_match(/qualified=true/, stderr)
  end

  def test_trust_pr_style_capture_reads_number_and_sha
    script = <<~'BASH'
      set -euo pipefail
      qualify() {
        echo "formula-release-pr: ok (qualified=true)" >&2
        echo "99 abcdef0123456789"
      }
      line="$(qualify)"
      read -r number sha <<<"$line"
      test "$number" = "99" -a "$sha" = "abcdef0123456789"
    BASH

    assert system("bash", "-c", script)
  end

  def test_rejects_multiple_commits_on_branch
    ok, qualified, reason, = run_qualify(
      head_ref: "hopt-0.2.14",
      base_files: { "Formula/hopt.rb" => "old\n" },
      files: { "Formula/hopt.rb" => "new\n" },
      extra_commits: 1
    )

    assert ok
    assert_equal "false", qualified
    assert_match(/exactly one commit/, reason)
  end

  def test_rejects_symlink_formula
    ok, qualified, reason, = run_qualify_symlink(
      head_ref: "hopt-0.2.14",
      formula: "Formula/hopt.rb"
    )

    assert ok
    assert_equal "false", qualified
    assert_match(/disallowed file mode/, reason)
  end

  def test_accepts_executable_formula_mode
    ok, qualified, = run_qualify(
      head_ref: "hopt-0.2.14",
      base_files: { "Formula/hopt.rb" => "old\n" },
      files: { "Formula/hopt.rb" => "#!/bin/bash\n" },
      executable: "Formula/hopt.rb"
    )

    assert ok
    assert_equal "true", qualified
  end

  def run_qualify_symlink(head_ref:, formula:)
    Dir.mktmpdir do |dir|
      FileUtils.mkdir_p(File.join(dir, "Formula"))
      File.write(File.join(dir, "target.rb"), "class T < Formula\nend\n")
      system("git", "-C", dir, "init", "-q")
      system("git", "-C", dir, "config", "user.email", "test@example.com")
      system("git", "-C", dir, "config", "user.name", "Test")
      system("git", "-C", dir, "add", ".")
      system("git", "-C", dir, "commit", "-qm", "base")
      system("git", "-C", dir, "branch", "-M", "main")
      system("git", "-C", dir, "checkout", "-qb", head_ref)
      FileUtils.ln_s("target.rb", File.join(dir, formula))
      system("git", "-C", dir, "add", formula)
      system("git", "-C", dir, "commit", "-qm", "symlink")

      head_sha = `git -C #{dir} rev-parse HEAD`.strip
      _stdout, _stderr, status = Open3.capture3(
        { "GITHUB_HEAD_REF" => head_ref, "GITHUB_OUTPUT" => File.join(dir, "output.txt") },
        SCRIPT, "--event", "pull_request", "--base-ref", "main", "--head-sha", head_sha,
        chdir: dir
      )
      output = File.read(File.join(dir, "output.txt"))
      [status.success?, output[/^qualified=(\w+)/, 1], output[/^reason=(.*)/, 1]]
    end
  end

  def test_rejects_multiple_formula_files
    ok, qualified, reason, = run_qualify(
      head_ref: "hopt-0.2.14",
      base_files: {
        "Formula/hopt.rb" => "old\n",
        "Formula/other.rb" => "old\n",
      },
      files: {
        "Formula/hopt.rb" => "new\n",
        "Formula/other.rb" => "also\n",
      }
    )

    assert ok
    assert_equal "false", qualified
    assert_match(/exactly one formula file/, reason)
  end
end
