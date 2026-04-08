---
title: "Installer Script for Claude Code Testing Kit"
description: "One-liner install scripts (bash + PowerShell) for automated setup of tk:* skills, plans, templates, and scripts"
status: completed
priority: P1
effort: 2h
tags: [installer, devx, cross-platform]
blockedBy: []
blocks: []
created: 2026-04-08
---

# Installer Script for Claude Code Testing Kit

## Overview

Create 2 installer scripts (install.sh + install.ps1) that automate the full setup of Claude Code Testing Kit via one-liner curl/irm commands. Supports interactive and non-interactive modes.

## Context

- Brainstorm report: `plans/reports/brainstorm-260408-1220-installer-script.md`
- Current manual install: 5+ copy commands in README.md
- Target: single curl command

## Dependencies

- None (standalone scripts, no build step)

## Phases

| # | Phase | Status | Effort | File |
|---|-------|--------|--------|------|
| 1 | install.sh (macOS/Linux) | pending | 1h | `phase-01-install-sh.md` |
| 2 | install.ps1 (Windows) | pending | 0.5h | `phase-02-install-ps1.md` |
| 3 | Update README + test | pending | 0.5h | `phase-03-readme-and-test.md` |

## Key Decisions

- Source: GitHub tarball download (no git dependency)
- Interactive prompts with flag overrides (--global, --local, --full, --skills-only, --uninstall)
- Ask before overwriting existing files
- Trap signals for clean cleanup on Ctrl+C
