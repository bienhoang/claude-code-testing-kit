#Requires -Version 5.1
# Claude Code Testing Kit — Installer (Windows PowerShell)
# Usage:
#   Interactive:  irm https://raw.githubusercontent.com/bienhoang/claude-code-testing-kit/main/install.ps1 | iex
#   With flags:   & ([scriptblock]::Create((irm https://raw.githubusercontent.com/bienhoang/claude-code-testing-kit/main/install.ps1))) -Global -Full
#   Local file:   .\install.ps1 -Global -Full

param(
    [switch]$Global,
    [switch]$Local,
    [switch]$Full,
    [switch]$SkillsOnly,
    [switch]$Uninstall,
    [switch]$Help
)

$ErrorActionPreference = "Stop"
$RepoOwner = "bienhoang"
$RepoName = "claude-code-testing-kit"
$Branch = "main"
$ZipUrl = "https://github.com/$RepoOwner/$RepoName/archive/refs/heads/$Branch.zip"
$ClaudeDir = Join-Path $env:USERPROFILE ".claude"
$GlobalSkillsDir = Join-Path $ClaudeDir "skills"
$LocalSkillsDir = Join-Path "." ".claude" "skills"

function Write-Banner {
    Write-Host ""
    Write-Host "==================================================" -ForegroundColor Cyan
    Write-Host "     Claude Code Testing Kit - Installer           " -ForegroundColor Cyan
    Write-Host "          by Anh Tester Community                  " -ForegroundColor Cyan
    Write-Host "==================================================" -ForegroundColor Cyan
    Write-Host ""
}

function Show-Help {
    Write-Host "Usage: install.ps1 [OPTIONS]"
    Write-Host ""
    Write-Host "Options:"
    Write-Host "  -Global       Install skills to ~/.claude/skills/"
    Write-Host "  -Local        Install skills to .claude/skills/ in current directory"
    Write-Host "  -Full         Install all components (skills + plans + templates + scripts)"
    Write-Host "  -SkillsOnly   Install only skills + CLAUDE.md"
    Write-Host "  -Uninstall    Remove installed tk-* skills"
    Write-Host "  -Help         Show this help"
    Write-Host ""
    Write-Host "Interactive (no flags needed):"
    Write-Host "  irm .../install.ps1 | iex"
    Write-Host ""
    Write-Host "With flags (use scriptblock pattern):"
    Write-Host "  & ([scriptblock]::Create((irm .../install.ps1))) -Global -Full"
    exit 0
}

function Get-AndExtract {
    $tmpDir = Join-Path ([System.IO.Path]::GetTempPath()) "claude-code-tk-$(Get-Random)"
    New-Item -ItemType Directory -Path $tmpDir -Force | Out-Null
    $zipFile = Join-Path $tmpDir "kit.zip"

    Write-Host "Downloading Testing Kit..." -ForegroundColor Cyan
    try {
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        Invoke-WebRequest -Uri $ZipUrl -OutFile $zipFile -UseBasicParsing
    } catch {
        Write-Host "Error: Download failed. $_" -ForegroundColor Red
        Remove-Item -Recurse -Force $tmpDir -ErrorAction SilentlyContinue
        exit 1
    }

    Expand-Archive -Path $zipFile -DestinationPath $tmpDir -Force
    $script:SrcDir = Join-Path $tmpDir "$RepoName-$Branch"
    $script:TmpDir = $tmpDir

    if (-not (Test-Path $script:SrcDir)) {
        Write-Host "Error: Extraction failed." -ForegroundColor Red
        Remove-Item -Recurse -Force $tmpDir -ErrorAction SilentlyContinue
        exit 1
    }
    Write-Host "Downloaded successfully." -ForegroundColor Green
}

function Read-InstallTarget {
    if ($Global) { return "global" }
    if ($Local) { return "local" }
    Write-Host ""
    Write-Host "Cai skills vao dau?"
    Write-Host "  1) Global (~/.claude/skills/) - dung cho moi project"
    Write-Host "  2) Local (.claude/skills/) - chi project hien tai"
    $choice = Read-Host "Chon [1/2] (default: 1)"
    if ($choice -eq "2") { return "local" }
    return "global"
}

function Read-InstallMode {
    if ($Full) { return "full" }
    if ($SkillsOnly) { return "skills-only" }
    Write-Host ""
    Write-Host "Cai nhung gi?"
    Write-Host "  1) Full kit (skills + plans + templates + scripts)"
    Write-Host "  2) Chi skills + CLAUDE.md"
    $choice = Read-Host "Chon [1/2] (default: 1)"
    if ($choice -eq "2") { return "skills-only" }
    return "full"
}

function Install-Skills {
    param([string]$Target)
    $dest = if ($Target -eq "global") { $GlobalSkillsDir } else { $LocalSkillsDir }
    New-Item -ItemType Directory -Path $dest -Force | Out-Null

    $srcSkills = Join-Path $script:SrcDir ".claude" "skills"
    $count = 0

    Get-ChildItem -Path $srcSkills -Directory -Filter "tk-*" | ForEach-Object {
        $targetDir = Join-Path $dest $_.Name
        if (Test-Path $targetDir) {
            $overwrite = Read-Host "  $($_.Name) da ton tai. Ghi de? [y/N]"
            if ($overwrite -ne "y" -and $overwrite -ne "Y") { return }
            Remove-Item -Recurse -Force $targetDir
        }
        Copy-Item -Recurse -Path $_.FullName -Destination $targetDir
        $count++
    }
    Write-Host "Installed $count skills -> $dest" -ForegroundColor Green
}

function Install-Extras {
    param([string]$InstallMode)
    # CLAUDE.md
    $claudeMd = Join-Path $script:SrcDir "CLAUDE.md"
    if (Test-Path "CLAUDE.md") {
        $overwrite = Read-Host "CLAUDE.md da ton tai. Ghi de? [y/N]"
        if ($overwrite -eq "y" -or $overwrite -eq "Y") {
            Copy-Item -Path $claudeMd -Destination "CLAUDE.md" -Force
        }
    } else {
        Copy-Item -Path $claudeMd -Destination "CLAUDE.md"
        Write-Host "Copied CLAUDE.md -> ./CLAUDE.md" -ForegroundColor Green
    }

    if ($InstallMode -ne "full") { return }

    # Plans
    $srcPlans = Join-Path $script:SrcDir "plans"
    if (Test-Path $srcPlans) {
        New-Item -ItemType Directory -Path "plans" -Force | Out-Null
        @("manual", "automation") | ForEach-Object {
            $src = Join-Path $srcPlans $_
            if (Test-Path $src) {
                Copy-Item -Recurse -Path $src -Destination (Join-Path "plans" $_) -Force
            }
        }
        Write-Host "Copied plans/manual + plans/automation" -ForegroundColor Green
    }

    # Prompt templates
    $srcTemplates = Join-Path $script:SrcDir "prompt_templates"
    if (Test-Path $srcTemplates) {
        Copy-Item -Recurse -Path $srcTemplates -Destination ".\" -Force
        Write-Host "Copied prompt_templates/" -ForegroundColor Green
    }

    # Scripts
    $srcScripts = Join-Path $script:SrcDir "scripts"
    if (Test-Path $srcScripts) {
        Copy-Item -Recurse -Path $srcScripts -Destination ".\" -Force
        Write-Host "Copied scripts/" -ForegroundColor Green
    }
}

function Uninstall-Kit {
    Write-Host "Uninstalling Claude Code Testing Kit..." -ForegroundColor Yellow
    $count = 0
    @($GlobalSkillsDir, $LocalSkillsDir) | ForEach-Object {
        if (Test-Path $_) {
            Get-ChildItem -Path $_ -Directory -Filter "tk-*" | ForEach-Object {
                Remove-Item -Recurse -Force $_.FullName
                $count++
            }
        }
    }
    Write-Host "Removed $count skill directories." -ForegroundColor Green
    Write-Host "Note: CLAUDE.md, plans/, prompt_templates/, scripts/ not removed." -ForegroundColor Yellow
}

function Write-Summary {
    Write-Host ""
    Write-Host "==================================================" -ForegroundColor Green
    Write-Host "           Installation Complete!                  " -ForegroundColor Green
    Write-Host "==================================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "Quick Start:"
    Write-Host "  Manual testing:  /tk:manual-testing"
    Write-Host "  Automation:      /tk:generate-automation"
    Write-Host "  All skills:      /tk:qa-master"
    Write-Host ""
    Write-Host "Docs: https://github.com/$RepoOwner/$RepoName"
}

# Main
function Main {
    Write-Banner

    if ($Help) { Show-Help }

    if ($Uninstall) {
        Uninstall-Kit
        return
    }

    Get-AndExtract
    try {
        $target = Read-InstallTarget
        $mode = Read-InstallMode
        Install-Skills -Target $target
        Install-Extras -InstallMode $mode
        Write-Summary
    } finally {
        if ($script:TmpDir -and (Test-Path $script:TmpDir)) {
            Remove-Item -Recurse -Force $script:TmpDir -ErrorAction SilentlyContinue
        }
    }
}

Main
