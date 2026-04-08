# Phase 1: install.sh (macOS / Linux)

## Priority: P1 | Status: pending | Effort: 1h

## Overview

Create bash installer script supporting macOS and Linux. Interactive mode with flag overrides.

## Implementation Steps

### 1. Script structure

```bash
#!/usr/bin/env bash
set -euo pipefail
```

### 2. Constants & config

- `REPO_OWNER="anhtester"`
- `REPO_NAME="claude-code-testing-kit"`
- `BRANCH="main"`
- `TARBALL_URL="https://github.com/$REPO_OWNER/$REPO_NAME/archive/refs/heads/$BRANCH.tar.gz"`
- `SKILLS_LIST` — array of 15 tk-* skill directory names

### 3. Parse flags

| Flag | Effect |
|------|--------|
| `--global` | Install skills to `~/.claude/skills/` |
| `--local` | Install skills to `.claude/skills/` in CWD |
| `--full` | Install all components |
| `--skills-only` | Install only skills + CLAUDE.md |
| `--uninstall` | Remove installed tk-* skills |
| `--help` | Show usage |

If no flags → interactive mode (prompt user).

### 4. Functions to implement

#### `print_banner()`
- Vietnamese welcome message
- Kit name, version info

#### `check_deps()`
- Check `curl` exists (fallback to `wget`)
- Check `tar` exists
- Check write permissions

#### `download_and_extract()`
- Create temp dir: `TMPDIR=$(mktemp -d)`
- Trap EXIT to cleanup: `trap 'rm -rf "$TMPDIR"' EXIT`
- Download tarball: `curl -fsSL "$TARBALL_URL" | tar xz -C "$TMPDIR"`
- Set `SRC_DIR="$TMPDIR/$REPO_NAME-$BRANCH"`

#### `prompt_install_target()`
- If no flag, ask: "Cài global hay local?"
- Options: 1) Global (~/.claude/skills/) 2) Local (.claude/skills/)
- Set `INSTALL_DIR` accordingly

#### `prompt_components()`
- If no flag, ask: "Cài full kit hay chỉ skills?"
- Options: 1) Full kit 2) Skills + CLAUDE.md only

#### `install_skills()`
- For each tk-* dir in `SRC_DIR/.claude/skills/`:
  - Check if target exists → ask overwrite if interactive
  - `cp -r` to `INSTALL_DIR`
- Count installed skills

#### `install_extras()`
- Copy CLAUDE.md to CWD (if local mode) or print instruction (if global)
- Copy plans/ to CWD
- Copy prompt_templates/ to CWD
- Copy scripts/ to CWD
- If Node.js detected: offer to run `npm install` in scripts/integrations/

#### `uninstall()`
- Remove tk-* dirs from `~/.claude/skills/` and/or `.claude/skills/`
- Remove CLAUDE.md from CWD if present
- Print what was removed

#### `print_summary()`
- Number of skills installed
- Location installed to
- Quick start: "Gõ /tk:manual-testing để bắt đầu"
- Link to README for more info

### 5. Main flow

```bash
main() {
  print_banner
  parse_args "$@"
  
  if [[ "$ACTION" == "uninstall" ]]; then
    uninstall
    exit 0
  fi
  
  check_deps
  download_and_extract
  prompt_install_target  # skip if flag set
  prompt_components      # skip if flag set
  install_skills
  [[ "$INSTALL_MODE" == "full" ]] && install_extras
  print_summary
}
```

## Related Files

| Action | File |
|--------|------|
| Create | `install.sh` (project root) |

## Success Criteria

- [ ] `curl -fsSL .../install.sh | bash` works on macOS
- [ ] `curl -fsSL .../install.sh | bash` works on Linux (Ubuntu)
- [ ] Interactive prompts work correctly
- [ ] `--global --full` flag combo works (non-interactive)
- [ ] `--uninstall` removes all tk-* skills
- [ ] Ctrl+C cleans up temp dir
- [ ] Existing files prompt for overwrite
- [ ] Script under 200 lines
