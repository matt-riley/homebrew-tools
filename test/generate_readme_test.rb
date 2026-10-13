# frozen_string_literal: true

require "minitest/autorun"
require "stringio"
require "tmpdir"
require_relative "../script/generate-readme"

class GenerateReadmeTest < Minitest::Test
  REPO_ROOT = File.expand_path("..", __dir__)

  # Release-please style: on_intel/on_arm blocks, single quotes.
  BLOCK_STYLE = <<~'RUBY'
    class Crap < Formula
      desc 'Change Risk Anti-Patterns (CRAP) scoring'
      homepage 'https://github.com/matt-riley/crap'
      version '0.1.5'
      license 'MIT'
      on_macos do
        on_intel do
          url 'https://github.com/matt-riley/crap/releases/download/v0.1.5/crap_darwin_amd64.tar.gz'
        end
        on_arm do
          url 'https://github.com/matt-riley/crap/releases/download/v0.1.5/crap_darwin_arm64.tar.gz'
        end
      end
      on_linux do
        on_intel do
          url 'https://github.com/matt-riley/crap/releases/download/v0.1.5/crap_linux_amd64.tar.gz'
        end
        on_arm do
          url 'https://github.com/matt-riley/crap/releases/download/v0.1.5/crap_linux_arm64.tar.gz'
        end
      end
      def install
        bin.install 'crap'
      end
    end
  RUBY

  # GoReleaser style: no license, binary name differs from formula name.
  GORELEASER_STYLE = <<~'RUBY'
    class Tui < Formula
      desc "Workv2 terminal UI"
      homepage "https://github.com/matt-riley/workv2"
      version "0.4.4"

      on_macos do
        if Hardware::CPU.arm?
          url "https://github.com/matt-riley/workv2/releases/download/v0.4.4/tui_0.4.4_darwin_arm64.tar.gz"
          define_method(:install) do
            bin.install "mattriley"
          end
        end
      end
    end
  RUBY

  # Rust release style: macos/aarch64/x86_64 naming.
  RUST_STYLE = <<~'RUBY'
    class Agit < Formula
      desc "AI-agent version control"
      homepage "https://github.com/matt-riley/agengit"
      version "1.26.2"
      license "GPL-3.0-only"
      on_linux do
        if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
          url "https://github.com/matt-riley/agengit/releases/download/v1.26.2/agit-aarch64-linux.tar.gz"
        else
          url "https://github.com/matt-riley/agengit/releases/download/v1.26.2/agit-x86_64-linux.tar.gz"
        end
      end
      def install
        bin.install "agit"
      end
    end
  RUBY

  def parse(source, name)
    ReadmeGenerator.parse_formula(source, name)
  end

  def test_parses_block_style_formula
    formula = parse(BLOCK_STYLE, "crap")

    assert_equal "crap", formula.name
    assert_equal "Change Risk Anti-Patterns (CRAP) scoring", formula.desc
    assert_equal "https://github.com/matt-riley/crap", formula.homepage
    assert_equal "0.1.5", formula.version
    assert_equal "MIT", formula.license
    assert_equal "crap", formula.binary
    assert_equal "macOS (Intel, Apple Silicon), Linux (x86_64, arm64)", formula.platforms
  end

  def test_parses_goreleaser_formula_without_license
    formula = parse(GORELEASER_STYLE, "tui")

    assert_nil formula.license
    assert_equal "mattriley", formula.binary
    assert_equal "macOS (Apple Silicon)", formula.platforms
  end

  def test_parses_rust_release_asset_names
    assert_equal "Linux (x86_64, arm64)", parse(RUST_STYLE, "agit").platforms
  end

  def test_rejects_formula_missing_required_fields
    error = assert_raises(ReadmeGenerator::ParseError) { parse("class X < Formula\nend\n", "x") }
    assert_match(/x: missing desc/, error.message)
  end

  def test_rejects_formula_with_unrecognised_release_asset
    source = BLOCK_STYLE.sub("crap_linux_arm64", "crap_plan9_mips")
    error = assert_raises(ReadmeGenerator::ParseError) { parse(source, "crap") }
    assert_match(/crap: unrecognised platform/, error.message)
  end

  def test_renders_every_formula_sorted_by_name
    readme = ReadmeGenerator.render([parse(GORELEASER_STYLE, "tui"), parse(BLOCK_STYLE, "crap")])

    assert_operator readme.index("brew install matt-riley/tools/crap"), :<, readme.index("brew install matt-riley/tools/tui")
    assert_includes readme, "| **crap** | 0.1.5 | Change Risk Anti-Patterns (CRAP) scoring | [matt-riley/crap](https://github.com/matt-riley/crap) | MIT |"
    assert_includes readme, "| **tui** | 0.4.4 | Workv2 terminal UI | [matt-riley/workv2](https://github.com/matt-riley/workv2) | — |"
    assert_includes readme, "Installs the `mattriley` binary."
    assert_includes readme, "https://mattriley.tools"
    refute_match(/Last updated/, readme)
  end

  def test_escapes_pipes_in_table_cells
    formula = parse(BLOCK_STYLE.sub("scoring", "scoring | ranking"), "crap")
    assert_includes ReadmeGenerator.render([formula]), "scoring \\| ranking"
  end

  def test_check_mode_reports_stale_readme
    Dir.mktmpdir do |dir|
      Dir.mkdir(File.join(dir, "Formula"))
      File.write(File.join(dir, "Formula", "crap.rb"), BLOCK_STYLE)
      File.write(File.join(dir, "README.md"), "stale\n")

      refute ReadmeGenerator.run(dir, check: true, out: StringIO.new)
      assert ReadmeGenerator.run(dir, check: false, out: StringIO.new)
      assert ReadmeGenerator.run(dir, check: true, out: StringIO.new)
    end
  end

  def test_refuses_to_render_an_empty_tap
    Dir.mktmpdir do |dir|
      Dir.mkdir(File.join(dir, "Formula"))
      assert_raises(ReadmeGenerator::ParseError) { ReadmeGenerator.load_formulas(dir) }
    end
  end

  # Guards against a parser that silently matches nothing in the real tap.
  def test_parses_every_formula_in_this_tap
    files = Dir[File.join(REPO_ROOT, "Formula", "*.rb")]
    formulas = ReadmeGenerator.load_formulas(REPO_ROOT)

    refute_empty files
    assert_equal files.map { |f| File.basename(f, ".rb") }.sort, formulas.map(&:name)
    formulas.each do |formula|
      refute_empty formula.platforms, "#{formula.name} has no platforms"
    end
  end
end
