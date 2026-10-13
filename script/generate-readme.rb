#!/usr/bin/env ruby
# frozen_string_literal: true

# Regenerates README.md from Formula/*.rb.
#
#   script/generate-readme.rb          rewrite README.md
#   script/generate-readme.rb --check  exit 1 if README.md is stale

module ReadmeGenerator
  class ParseError < StandardError; end

  Formula = Struct.new(:name, :desc, :homepage, :version, :license, :binary, :platforms)

  OS_LABELS = { "darwin" => "macOS", "linux" => "Linux" }.freeze
  ARCH_LABELS = {
    "darwin" => { "amd64" => "Intel", "arm64" => "Apple Silicon" },
    "linux" => { "amd64" => "x86_64", "arm64" => "arm64" },
  }.freeze
  OS_ALIASES = { "darwin" => "darwin", "macos" => "darwin", "linux" => "linux" }.freeze
  ARCH_ALIASES = { "amd64" => "amd64", "x86_64" => "amd64", "arm64" => "arm64", "aarch64" => "arm64" }.freeze

  module_function

  def string_field(source, field)
    match = source.match(/^\s*#{field}\s+(["'])(.*?)\1\s*$/)
    match && match[2]
  end

  # Release asset names carry the platform, whichever conditional style the
  # formula uses, e.g. tool_darwin_arm64.tar.gz or tool-x86_64-linux.tar.gz.
  def platforms(source, name)
    targets = source.scan(/^\s*url\s+(["'])(.*?)\1/).map do |(_, url)|
      asset = File.basename(url).downcase
      os = OS_ALIASES[asset[/(?<![a-z])(#{OS_ALIASES.keys.join('|')})(?![a-z])/, 1]]
      arch = ARCH_ALIASES[asset[/(?<![a-z0-9])(#{ARCH_ALIASES.keys.join('|')})(?![a-z0-9])/, 1]]
      raise ParseError, "#{name}: unrecognised platform in #{url}" unless os && arch

      [os, arch]
    end

    OS_LABELS.keys.map do |os|
      archs = ARCH_LABELS[os].keys.select { |arch| targets.include?([os, arch]) }
      next if archs.empty?

      "#{OS_LABELS[os]} (#{archs.map { |arch| ARCH_LABELS[os][arch] }.join(', ')})"
    end.compact.join(", ")
  end

  def parse_formula(source, name)
    fields = %w[desc homepage version].to_h { |field| [field, string_field(source, field)] }
    missing = fields.select { |_, value| value.nil? }.keys
    raise ParseError, "#{name}: missing #{missing.join(', ')}" unless missing.empty?

    binary = source[/bin\.install\s+(["'])(.*?)\1/, 2]
    raise ParseError, "#{name}: missing bin.install" unless binary

    platforms = platforms(source, name)
    raise ParseError, "#{name}: no release urls" if platforms.empty?

    Formula.new(name, fields["desc"], fields["homepage"], fields["version"],
                string_field(source, "license"), binary, platforms)
  end

  def load_formulas(root)
    paths = Dir[File.join(root, "Formula", "*.rb")].sort
    raise ParseError, "no formulas found in #{File.join(root, 'Formula')}" if paths.empty?

    paths.map { |path| parse_formula(File.read(path), File.basename(path, ".rb")) }
  end

  def cell(text)
    text.gsub("|", "\\|")
  end

  def homepage_link(url)
    repo = url[%r{\Ahttps://github\.com/([^/]+/[^/]+?)/?\z}, 1]
    repo ? "[#{repo}](#{url})" : url
  end

  def render(formulas)
    formulas = formulas.sort_by(&:name)
    installs = formulas.map { |f| "brew install matt-riley/tools/#{f.name}" }.join("\n")
    rows = formulas.map do |f|
      "| **#{f.name}** | #{f.version} | #{cell(f.desc)} | #{homepage_link(f.homepage)} | #{f.license || '—'} | #{f.platforms} |"
    end.join("\n")
    highlights = formulas.map do |f|
      binary_note = f.binary == f.name ? "" : " Installs the `#{f.binary}` binary."
      <<~MD
        ### #{f.name} `v#{f.version}`

        > #{f.desc}

        Source: #{homepage_link(f.homepage)}.#{binary_note} Full README: [mattriley.tools](https://mattriley.tools).

        ```bash
        brew install matt-riley/tools/#{f.name}
        ```
      MD
    end.join("\n")

    <<~MD
      # 🍺 matt-riley/tools — Homebrew Tap

      A personal [Homebrew](https://brew.sh) tap containing tools built and maintained by [@matt-riley](https://github.com/matt-riley). Add the tap once and install the formula you need. Browse every tool, with its full README, at [mattriley.tools](https://mattriley.tools).

      <!-- Generated from Formula/*.rb by script/generate-readme.rb. Do not edit by hand. -->

      ---

      ## 🚀 Getting Started

      ```bash
      brew tap matt-riley/tools
      ```

      ---

      ## 🛠️ Tools

      ### Install commands

      ```bash
      #{installs}
      ```

      ### Migration note for existing `hopt` cask users

      If you previously installed `hopt` as a cask, remove the old cask install and install the formula instead:

      ```bash
      brew uninstall --cask hopt
      brew install matt-riley/tools/hopt
      ```

      ### Tools table

      | Tool | Tap Version | Description | Homepage | License | Platform Support |
      |------|-------------|-------------|----------|---------|-----------------|
      #{rows}

      ---

      ## 📦 Per-tool Highlights

      #{highlights}
      ---

      ## ℹ️ Version Policy

      Versions shown in this README reflect the **tap formula version** from `Formula/*.rb` — the version packaged and tested in this tap. They are not necessarily the latest upstream release.
    MD
  end

  def run(root, check:, out: $stdout)
    readme_path = File.join(root, "README.md")
    expected = render(load_formulas(root))
    current = File.exist?(readme_path) ? File.read(readme_path) : ""

    if current == expected
      out.puts "README.md is up to date."
      return true
    end

    if check
      out.puts "README.md is out of date. Run script/generate-readme.rb and commit the result."
      return false
    end

    File.write(readme_path, expected)
    out.puts "README.md updated."
    true
  end
end

if $PROGRAM_NAME == __FILE__
  root = File.expand_path("..", __dir__)
  exit(ReadmeGenerator.run(root, check: ARGV.include?("--check")) ? 0 : 1)
end
