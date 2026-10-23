# frozen_string_literal: true

require "minitest/autorun"
require "open3"
require "tmpdir"
require "fileutils"

class FormulaReleasePrQualifyTest < Minitest::Test
  SCRIPT = File.expand_path("../script/formula-release-pr-qualify.sh", __dir__)

  def run_qualify(head_ref:, files:, base_files: nil)
    base_files = { "Formula/placeholder.rb" => "class Placeholder < Formula\nend\n" } if base_files.nil?
    Dir.mktmpdir do |dir|
      Dir.mkdir(File.join(dir, "Formula"))
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

      files.each do |path, content|
        full = File.join(dir, path)
        FileUtils.mkdir_p(File.dirname(full))
        File.write(full, content)
        system("git", "-C", dir, "add", path)
      end
      system("git", "-C", dir, "commit", "-qm", "change") if files.any?

      stdout, stderr, status = Open3.capture3(
        {
          "GITHUB_HEAD_REF" => head_ref,
          "GITHUB_OUTPUT" => File.join(dir, "output.txt"),
        },
        SCRIPT,
        "--event", "pull_request",
        "--base-ref", "main",
        chdir: dir
      )

      output = File.read(File.join(dir, "output.txt"))
      qualified = output[/^qualified=(\w+)/, 1]
      reason = output[/^reason=(.*)/, 1]

      [status.success?, qualified, reason, stdout, stderr]
    end
  end

  def test_accepts_goreleaser_release_branch_with_formula_change
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

  def test_rejects_disallowed_paths
    ok, qualified, reason, = run_qualify(
      head_ref: "skill-eval-1.2.3",
      base_files: { "Formula/skill-eval.rb" => "old\n" },
      files: {
        "Formula/skill-eval.rb" => "new\n",
        ".github/workflows/evil.yml" => "on: push\n",
      }
    )

    assert ok
    assert_equal "false", qualified
    assert_match(/disallowed path/, reason)
  end

  def test_allows_readme_with_formula
    ok, qualified, = run_qualify(
      head_ref: "newbrew-0.1.0",
      base_files: { "Formula/newbrew.rb" => "old\n" },
      files: {
        "Formula/newbrew.rb" => "new\n",
        "README.md" => "readme\n",
      }
    )

    assert ok
    assert_equal "true", qualified
  end
end
