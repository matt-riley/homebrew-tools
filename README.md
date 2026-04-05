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
brew install matt-riley/tools/hopt
brew install matt-riley/tools/newbrew
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
| **hopt** | 0.2.2 | A TUI to interact with The Hoptimist store | [matt-riley/hopcli](https://github.com/matt-riley/hopcli) | — | macOS (Intel, Apple Silicon), Linux (x86_64, arm64) |
| **newbrew** | 0.1.2 | Browse and inspect new Homebrew formulae from your terminal | [matt-riley/newbrew](https://github.com/matt-riley/newbrew) | — | macOS (Intel, Apple Silicon), Linux (x86_64, arm64) |
| **tui** | 0.4.2 | Workv2 terminal UI | [matt-riley/workv2](https://github.com/matt-riley/workv2) | MIT | macOS (Intel, Apple Silicon), Linux (x86_64, arm64) |

---

## 📦 Per-tool Highlights

### hopt `v0.2.2`

> A TUI to interact with The Hoptimist store

A terminal user interface application for browsing and interacting with [The Hoptimist](https://thehoptimist.co.uk) store. Built for speed and convenience so you can stay in your terminal. Source: [matt-riley/hopcli](https://github.com/matt-riley/hopcli).

```bash
brew install matt-riley/tools/hopt
```

### newbrew `v0.1.2`

> Browse and inspect new Homebrew formulae from your terminal

`newbrew` is a cheerful terminal companion for browsing freshly merged Homebrew formulae without leaving your shell. Source: [matt-riley/newbrew](https://github.com/matt-riley/newbrew).

```bash
brew install matt-riley/tools/newbrew
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

_Last updated: 2026-04-05 (UTC)_
