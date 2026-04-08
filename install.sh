#!/usr/bin/env bash
set -euo pipefail

# Claude Code Testing Kit — Installer (macOS / Linux)
# Usage: curl -fsSL https://raw.githubusercontent.com/bienhoang/claude-code-testing-kit/main/install.sh | bash
# Flags: --global, --local, --full, --skills-only, --uninstall, --help

# Detect piped stdin — handled after parse_args to check if flags were provided

REPO_OWNER="bienhoang"
REPO_NAME="claude-code-testing-kit"
BRANCH="main"
TARBALL_URL="https://github.com/$REPO_OWNER/$REPO_NAME/archive/refs/heads/$BRANCH.tar.gz"
CLAUDE_DIR="$HOME/.claude"
GLOBAL_SKILLS_DIR="$CLAUDE_DIR/skills"
LOCAL_SKILLS_DIR=".claude/skills"
TMPDIR_PATH=""

# Flags (defaults)
TARGET=""       # global | local
MODE=""         # full | skills-only
ACTION="install" # install | uninstall
NONINTERACTIVE=false

# Colors
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; NC='\033[0m'

cleanup() { [[ -n "$TMPDIR_PATH" && -d "$TMPDIR_PATH" ]] && rm -rf "$TMPDIR_PATH"; }
trap cleanup EXIT

print_banner() {
  echo -e "${CYAN}"
  echo "╔══════════════════════��═══════════════════════╗"
  echo "║     Claude Code Testing Kit — Installer      ║"
  echo "║          by Anh Tester Community              ║"
  echo "╚══════════════════════════════════════════════╝"
  echo -e "${NC}"
}

show_help() {
  echo "Usage: install.sh [OPTIONS]"
  echo ""
  echo "Options:"
  echo "  --global       Install skills to ~/.claude/skills/"
  echo "  --local        Install skills to .claude/skills/ in current directory"
  echo "  --full         Install all components (skills + plans + templates + scripts)"
  echo "  --skills-only  Install only skills + CLAUDE.md"
  echo "  --uninstall    Remove installed tk-* skills"
  echo "  --help         Show this help"
  echo ""
  echo "Examples:"
  echo "  curl -fsSL .../install.sh | bash"
  echo "  curl -fsSL .../install.sh | bash -s -- --global --full"
  exit 0
}

parse_args() {
  while [[ $# -gt 0 ]]; do
    case "$1" in
      --global)      TARGET="global"; NONINTERACTIVE=true ;;
      --local)       TARGET="local"; NONINTERACTIVE=true ;;
      --full)        MODE="full"; NONINTERACTIVE=true ;;
      --skills-only) MODE="skills-only"; NONINTERACTIVE=true ;;
      --uninstall)   ACTION="uninstall"; NONINTERACTIVE=true ;;
      --help)        show_help ;;
      *) echo -e "${RED}Unknown option: $1${NC}"; show_help ;;
    esac
    shift
  done
}

check_deps() {
  if command -v curl &>/dev/null; then
    DOWNLOADER="curl"
  elif command -v wget &>/dev/null; then
    DOWNLOADER="wget"
  else
    echo -e "${RED}Error: curl or wget required.${NC}" && exit 1
  fi
  command -v tar &>/dev/null || { echo -e "${RED}Error: tar required.${NC}"; exit 1; }
}

download_and_extract() {
  TMPDIR_PATH=$(mktemp -d)
  echo -e "${CYAN}Downloading Testing Kit...${NC}"
  if [[ "$DOWNLOADER" == "curl" ]]; then
    curl -fsSL "$TARBALL_URL" | tar xz -C "$TMPDIR_PATH"
  else
    wget -qO- "$TARBALL_URL" | tar xz -C "$TMPDIR_PATH"
  fi
  SRC_DIR="$TMPDIR_PATH/$REPO_NAME-$BRANCH"
  [[ -d "$SRC_DIR" ]] || { echo -e "${RED}Error: Download failed.${NC}"; exit 1; }
  echo -e "${GREEN}Downloaded successfully.${NC}"
}

prompt_target() {
  [[ -n "$TARGET" ]] && return
  echo ""
  echo "Cài skills vào đâu?"
  echo "  1) Global (~/.claude/skills/) — dùng cho mọi project"
  echo "  2) Local (.claude/skills/) — chỉ project hiện tại"
  read -rp "Chọn [1/2] (default: 1): " choice
  case "${choice:-1}" in
    1) TARGET="global" ;;
    2) TARGET="local" ;;
    *) TARGET="global" ;;
  esac
}

prompt_mode() {
  [[ -n "$MODE" ]] && return
  echo ""
  echo "Cài những gì?"
  echo "  1) Full kit (skills + plans + templates + scripts)"
  echo "  2) Chỉ skills + CLAUDE.md"
  read -rp "Chọn [1/2] (default: 1): " choice
  case "${choice:-1}" in
    1) MODE="full" ;;
    2) MODE="skills-only" ;;
    *) MODE="full" ;;
  esac
}

get_skills_dir() {
  if [[ "$TARGET" == "global" ]]; then
    echo "$GLOBAL_SKILLS_DIR"
  else
    echo "$LOCAL_SKILLS_DIR"
  fi
}

install_skills() {
  local dest; dest=$(get_skills_dir)
  local count=0
  mkdir -p "$dest"

  for skill_dir in "$SRC_DIR/.claude/skills"/tk-*; do
    local name; name=$(basename "$skill_dir")
    local target_dir="$dest/$name"
    if [[ -d "$target_dir" ]]; then
      if [[ "$NONINTERACTIVE" == true ]]; then
        rm -rf "$target_dir"
      else
        read -rp "  $name đã tồn tại. Ghi đè? [y/N]: " overwrite
        [[ "${overwrite:-n}" =~ ^[Yy]$ ]] || continue
        rm -rf "$target_dir"
      fi
    fi
    cp -r "$skill_dir" "$target_dir"
    count=$((count + 1))
  done
  echo -e "${GREEN}Installed $count skills → $dest${NC}"
}

install_extras() {
  # CLAUDE.md
  if [[ -f "CLAUDE.md" ]]; then
    if [[ "$NONINTERACTIVE" == true ]]; then
      cp "$SRC_DIR/CLAUDE.md" ./CLAUDE.md
    else
      read -rp "CLAUDE.md đã tồn tại. Ghi đè? [y/N]: " overwrite
      [[ "${overwrite:-n}" =~ ^[Yy]$ ]] && cp "$SRC_DIR/CLAUDE.md" ./CLAUDE.md
    fi
  else
    cp "$SRC_DIR/CLAUDE.md" ./CLAUDE.md
    echo -e "${GREEN}Copied CLAUDE.md → ./CLAUDE.md${NC}"
  fi

  [[ "$MODE" != "full" ]] && return

  # Plans
  if [[ -d "$SRC_DIR/plans/manual" ]]; then
    mkdir -p plans
    cp -rn "$SRC_DIR/plans/manual" plans/ 2>/dev/null || cp -r "$SRC_DIR/plans/manual" plans/
    cp -rn "$SRC_DIR/plans/automation" plans/ 2>/dev/null || cp -r "$SRC_DIR/plans/automation" plans/
    echo -e "${GREEN}Copied plans/manual + plans/automation${NC}"
  fi

  # Prompt templates
  if [[ -d "$SRC_DIR/prompt_templates" ]]; then
    cp -rn "$SRC_DIR/prompt_templates" ./ 2>/dev/null || cp -r "$SRC_DIR/prompt_templates" ./
    echo -e "${GREEN}Copied prompt_templates/${NC}"
  fi

  # Scripts
  if [[ -d "$SRC_DIR/scripts" ]]; then
    cp -rn "$SRC_DIR/scripts" ./ 2>/dev/null || cp -r "$SRC_DIR/scripts" ./
    echo -e "${GREEN}Copied scripts/${NC}"
    # Offer npm install if Node exists
    if command -v node &>/dev/null && [[ -f "scripts/integrations/package.json" ]]; then
      local npm_install="y"
      [[ "$NONINTERACTIVE" != true ]] && read -rp "Chạy npm install cho Jira/Xray scripts? [Y/n]: " npm_install
      if [[ "${npm_install:-y}" =~ ^[Yy]$ ]]; then
        (cd scripts/integrations && npm install --silent 2>/dev/null) && echo -e "${GREEN}npm install done.${NC}" || echo -e "${YELLOW}npm install failed — chạy thủ công: cd scripts/integrations && npm install${NC}"
      fi
    fi
  fi
}

uninstall() {
  local count=0
  echo -e "${YELLOW}Uninstalling Claude Code Testing Kit...${NC}"
  # Global skills
  for d in "$GLOBAL_SKILLS_DIR"/tk-*; do
    [[ -d "$d" ]] && rm -rf "$d" && count=$((count + 1))
  done
  # Local skills
  for d in "$LOCAL_SKILLS_DIR"/tk-*; do
    [[ -d "$d" ]] && rm -rf "$d" && count=$((count + 1))
  done
  echo -e "${GREEN}Removed $count skill directories.${NC}"
  echo -e "${YELLOW}Note: CLAUDE.md, plans/, prompt_templates/, scripts/ not removed — delete manually if needed.${NC}"
}

print_summary() {
  echo ""
  echo -e "${GREEN}╔══════════════════════════════════════════════╗${NC}"
  echo -e "${GREEN}║           Installation Complete!              ║${NC}"
  echo -e "${GREEN}╚══════════════════════════════════════════════╝${NC}"
  echo ""
  echo "Quick Start:"
  echo "  Manual testing:  /tk:manual-testing"
  echo "  Automation:      /tk:generate-automation"
  echo "  All skills:      /tk:qa-master"
  echo ""
  echo "Docs: https://github.com/$REPO_OWNER/$REPO_NAME"
}

main() {
  print_banner
  parse_args "$@"

  if [[ "$ACTION" == "uninstall" ]]; then
    uninstall
    exit 0
  fi

  # If piped (curl | bash) and no flags → show helpful instructions
  if [ ! -t 0 ] && [[ "$NONINTERACTIVE" == false ]]; then
    echo -e "${YELLOW}Interactive mode requires a terminal for input.${NC}"
    echo ""
    echo "Use one of these methods:"
    echo ""
    echo "  # Method 1: Download and run (interactive)"
    echo "  curl -fsSL https://raw.githubusercontent.com/$REPO_OWNER/$REPO_NAME/main/install.sh -o /tmp/tk-install.sh && bash /tmp/tk-install.sh"
    echo ""
    echo "  # Method 2: Non-interactive (no prompts)"
    echo "  curl -fsSL https://raw.githubusercontent.com/$REPO_OWNER/$REPO_NAME/main/install.sh | bash -s -- --global --full"
    echo ""
    exit 1
  fi

  check_deps
  download_and_extract
  prompt_target
  prompt_mode
  install_skills
  install_extras
  print_summary
}

main "$@"
