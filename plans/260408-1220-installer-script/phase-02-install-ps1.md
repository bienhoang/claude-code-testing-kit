# Phase 2: install.ps1 (Windows PowerShell)

## Priority: P1 | Status: pending | Effort: 0.5h

## Overview

Port install.sh logic to PowerShell for native Windows support. Same flow, same flags, PowerShell idioms.

## Implementation Steps

### 1. Script structure

```powershell
#Requires -Version 5.1
$ErrorActionPreference = "Stop"
```

### 2. Key differences from bash version

| Bash | PowerShell |
|------|-----------|
| `mktemp -d` | `New-TemporaryFile` + convert to dir |
| `curl -fsSL \| tar xz` | `Invoke-WebRequest` + `Expand-Archive` (zip, not tar) |
| `trap EXIT` | `try/finally` block |
| `read -p` | `Read-Host` |
| `cp -r` | `Copy-Item -Recurse` |
| `~/.claude/` | `$env:USERPROFILE\.claude\` |

### 3. Download approach

GitHub provides zip archives too:
```
https://github.com/$REPO_OWNER/$REPO_NAME/archive/refs/heads/$BRANCH.zip
```
Use zip instead of tar.gz for native PowerShell support (no tar needed).

### 4. Functions — mirror bash version

- `Write-Banner` → Vietnamese welcome
- `Test-Dependencies` → Check PowerShell version
- `Get-AndExtract` → Download zip, extract with `Expand-Archive`
- `Read-InstallTarget` → Prompt global vs local
- `Read-Components` → Prompt full vs skills-only
- `Install-Skills` → Copy tk-* dirs
- `Install-Extras` → Copy plans, templates, scripts, CLAUDE.md
- `Uninstall-Kit` → Remove installed files
- `Write-Summary` → Print success + quick start

### 5. Flag parsing

```powershell
param(
    [switch]$Global,
    [switch]$Local,
    [switch]$Full,
    [switch]$SkillsOnly,
    [switch]$Uninstall,
    [switch]$Help
)
```

## Related Files

| Action | File |
|--------|------|
| Create | `install.ps1` (project root) |

## Success Criteria

- [ ] `irm .../install.ps1 | iex` works on Windows PowerShell 5.1+
- [ ] `irm .../install.ps1 | iex` works on PowerShell 7+ (cross-platform)
- [ ] Interactive prompts work
- [ ] Flag combos work (`-Global -Full`)
- [ ] `-Uninstall` removes all tk-* skills
- [ ] Temp files cleaned up on error
- [ ] Script under 200 lines
