# 🍺 matt-riley/tools — Homebrew Tap

A personal [Homebrew](https://brew.sh) tap containing tools built and maintained by [@matt-riley](https://github.com/matt-riley). Add the tap once and install the formula you need.

---

## 🚀 Getting Started

```bash
brew tap matt-riley/tools
```

This tap is currently formula-only. README versions and package metadata are refreshed from `Formula/*.rb`.

---

## 🛠️ Tools

### Install commands

```bash
brew install matt-riley/tools/agit
brew install matt-riley/tools/hopt
brew install matt-riley/tools/liner
brew install matt-riley/tools/newbrew
brew install matt-riley/tools/skill-eval
brew install matt-riley/tools/tui
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
| **agit** | 1.24.0 | AI-agent version control | [matt-riley/agengit](https://github.com/matt-riley/agengit) | GPL-3.0-only | macOS (Intel, Apple Silicon), Linux (x86_64, arm64) |
| **hopt** | 0.2.2 | A TUI to interact with The Hoptimist store | [matt-riley/hopcli](https://github.com/matt-riley/hopcli) | — | macOS (Intel, Apple Silicon), Linux (x86_64, arm64) |
| **liner** | 1.0.0 | Publish Markdown blog posts to mattriley.work via lexi's write API | [matt-riley/liner](https://github.com/matt-riley/liner) | — | macOS (Intel, Apple Silicon), Linux (x86_64, arm64) |
| **newbrew** | 0.1.6 | Browse and inspect new Homebrew formulae from your terminal | [matt-riley/newbrew](https://github.com/matt-riley/newbrew) | — | macOS (Intel, Apple Silicon), Linux (x86_64, arm64) |
| **skill-eval** | 1.0.0 | Automated CLI for evaluating AI agent skills | [matt-riley/skill-evaluator](https://github.com/matt-riley/skill-evaluator) | — | macOS (Intel, Apple Silicon), Linux (x86_64, arm64) |
| **tui** | 0.4.2 | Workv2 terminal UI | [matt-riley/workv2](https://github.com/matt-riley/workv2) | MIT | macOS (Intel, Apple Silicon), Linux (x86_64, arm64) |

---

## 📦 Per-tool Highlights

### agit `v1.24.0`

> AI-agent version control

`agit` is an AI-agent powered version control tool. Source: [matt-riley/agengit](https://github.com/matt-riley/agengit).

```bash
brew install matt-riley/tools/agit
```

### hopt `v0.2.2`

> A TUI to interact with The Hoptimist store

A terminal user interface application for browsing and interacting with [The Hoptimist](https://thehoptimist.co.uk) store. Built for speed and convenience so you can stay in your terminal. Source: [matt-riley/hopcli](https://github.com/matt-riley/hopcli).

```bash
brew install matt-riley/tools/hopt
```

### liner `v1.0.0`

> Publish Markdown blog posts to mattriley.work via lexi's write API

`liner` is a tool for publishing Markdown blog posts to mattriley.work using the lexi write API. Source: [matt-riley/liner](https://github.com/matt-riley/liner).

```bash
brew install matt-riley/tools/liner
```

### newbrew `v0.1.6`

> Browse and inspect new Homebrew formulae from your terminal

`newbrew` is a cheerful terminal companion for browsing freshly merged Homebrew formulae without leaving your shell. Source: [matt-riley/newbrew](https://github.com/matt-riley/newbrew).

```bash
brew install matt-riley/tools/newbrew
```

### skill-eval `v1.0.0`

> Automated CLI for evaluating AI agent skills

`skill-eval` is a command-line tool for automated evaluation of AI agent capabilities. Source: [matt-riley/skill-evaluator](https://github.com/matt-riley/skill-evaluator).

```bash
brew install matt-riley/tools/skill-eval
```

### tui `v0.4.2`

> Workv2 terminal UI

A terminal UI companion for the `workv2` project. Installed as the `mattriley` binary. Source: [matt-riley/workv2](https://github.com/matt-riley/workv2).

```bash
brew install matt-riley/tools/tui
```

---

## ℹ️ Version Policy

Versions shown in this README reflect the **tap formula version** from `Formula/*.rb` — the version packaged and tested in this tap. They are not necessarily the latest upstream release.

---

_Last updated: 2026-06-25 (UTC)_
