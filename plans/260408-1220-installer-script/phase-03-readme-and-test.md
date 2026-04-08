# Phase 3: Update README + Test

## Priority: P1 | Status: pending | Effort: 0.5h

## Overview

Update README.md install section with one-liner commands. Test both scripts.

## Implementation Steps

### 1. Update README.md

Replace the manual "Cài Đặt" section with:

```markdown
## Cài Đặt

### Cài nhanh (1 lệnh)

**macOS / Linux:**
```bash
curl -fsSL https://raw.githubusercontent.com/anhtester/claude-code-testing-kit/main/install.sh | bash
```

**Windows (PowerShell):**
```powershell
irm https://raw.githubusercontent.com/anhtester/claude-code-testing-kit/main/install.ps1 | iex
```

### Tùy chọn nâng cao

```bash
# Cài global, full kit (không hỏi)
curl -fsSL .../install.sh | bash -s -- --global --full

# Chỉ cài skills
curl -fsSL .../install.sh | bash -s -- --global --skills-only

# Gỡ cài đặt
curl -fsSL .../install.sh | bash -s -- --uninstall
```

### Cài thủ công
(keep existing manual steps as fallback)
```

### 2. Test install.sh

- [ ] Test on macOS: interactive mode
- [ ] Test on macOS: `--global --full`
- [ ] Test on macOS: `--uninstall`
- [ ] Test: Ctrl+C cleanup
- [ ] Test: overwrite prompt when skills already exist

### 3. Test install.ps1

- [ ] Test on PowerShell: interactive mode (if Windows available)
- [ ] Verify syntax with `pwsh -Command "& { Get-Content install.ps1 | Out-Null }"` on macOS

## Related Files

| Action | File |
|--------|------|
| Modify | `README.md` |

## Success Criteria

- [ ] README shows one-liner install as primary method
- [ ] Manual install kept as fallback section
- [ ] install.sh tested and working on macOS
- [ ] install.ps1 syntax validated
