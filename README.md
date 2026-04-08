# Claude Code Testing Kit

Chào mừng bạn đến với **Claude Code Testing Kit**!

Đây là bộ Kit làm lại từ **Antigravity Testing Kit** được xây dựng và phát triển bởi **Anh Tester**, dành riêng cho **Cộng đồng Tester Việt Nam**. 

Mục tiêu: cung cấp sẵn các thiết lập, quy tắc, kỹ năng (Skills), và quy trình chuẩn để hỗ trợ sử dụng AI Agent trên **Claude Code** (CLI / Desktop / VS Code / JetBrains).

## Tính Năng

- **15 `tk:*` skills** — Manual testing, automation, integration
- **Playwright MCP** integration cho browser automation
- **Multi-framework:** Playwright TS, Selenium Java, Appium, REST Assured
- **Output Tiếng Việt** — Mọi test cases, reports, giải thích bằng Tiếng Việt
- **Plan templates** — Quy trình manual testing (QUICK + FULL RBT) và automation (6 bước)
- **Prompt templates** — One-shot prompts cho các tác vụ phổ biến
- **Jira/Xray integration** — Lấy requirements, đẩy test results

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

<details>
<summary>Xem hướng dẫn cài thủ công</summary>

1. Clone repo: `git clone https://github.com/anhtester/claude-code-testing-kit.git`
2. Copy skills: `cp -r .claude/skills/tk-* ~/.claude/skills/`
3. Copy CLAUDE.md vào project: `cp CLAUDE.md /path/to/your/project/`
4. (Tùy chọn) Copy plans, templates, scripts vào project
5. (Tùy chọn) Cấu hình Playwright MCP trong Claude Code settings
6. (Tùy chọn) Cấu hình Jira/Xray: `cd scripts/integrations && npm install && cp .env.example .env`

</details>

## Skill Catalog

| Slash Command | Mô tả |
|--------------|-------|
| `/tk:qa-master` | Master routing — điều hướng đến skill phù hợp |
| `/tk:manual-testing` | Sinh manual test cases (QUICK + FULL RBT) |
| `/tk:generate-requirements` | Phân tích website, sinh tài liệu requirements |
| `/tk:generate-automation` | Chuyển manual TC → automation scripts (6 bước) |
| `/tk:generate-automation-ui` | UI flow → automation scripts qua browser |
| `/tk:generate-full-suite` | Khám phá app, sinh full automation suite |
| `/tk:generate-framework` | Thiết kế automation framework |
| `/tk:generate-locator` | Sinh locator ổn định (Playwright/Selenium/Appium) |
| `/tk:generate-test-data` | Sinh test data có cấu trúc, traceable |
| `/tk:generate-api-tests` | Sinh API tests từ Swagger/OpenAPI |
| `/tk:generate-regression` | Sinh regression test suite theo priority |
| `/tk:generate-test-plan` | Khám phá app, sinh test plan |
| `/tk:analyze-flaky` | Phân tích và fix flaky tests |
| `/tk:jira-fetch` | Lấy requirements/user stories từ Jira |
| `/tk:xray-import` | Đẩy kết quả test lên Xray |

## Quick Start

### Manual Testing
- **Nhanh:** Gõ `/tk:manual-testing` trong Claude Code
- **Chi tiết:** Xem `plans/manual/QUICK_START.md`

### Automation
- **Nhanh:** Gõ `/tk:generate-automation` trong Claude Code
- **Chi tiết:** Xem `plans/automation/QUICK_START.md`

### Prompt Templates
- Xem `prompt_templates/` — Copy nội dung prompt → paste vào Claude Code chat

## Cấu Trúc Thư Mục

```
claude-code-testing-kit/
├── CLAUDE.md                    # Project rules cho Claude Code
├── .claude/
│   └── skills/
│       ├── tk-qa-master/        # Master skill + references/
│       ├── tk-manual-testing/   # Manual test case generation
│       ├── tk-generate-requirements/
│       ├── tk-generate-automation/
│       ├── tk-generate-automation-ui/
│       ├── tk-generate-full-suite/
│       ├── tk-generate-framework/
│       ├── tk-generate-locator/
│       ├── tk-generate-test-data/
│       ├── tk-generate-api-tests/
│       ├── tk-generate-regression/
│       ├── tk-generate-test-plan/
│       ├── tk-analyze-flaky/
│       ├── tk-jira-fetch/
│       └── tk-xray-import/
├── plans/
│   ├── manual/                  # Quy trình manual testing (6 bước)
│   └── automation/              # Quy trình automation (6 bước)
├── prompt_templates/            # One-shot prompts
└── scripts/
    └── integrations/jira/       # Jira/Xray integration scripts
```

## Tech Stack Hỗ Trợ

| Loại | Công nghệ |
|------|-----------|
| Ngôn ngữ | Java, TypeScript |
| Web Automation | Playwright (TS/Java), Selenium WebDriver (Java) |
| Mobile Automation | Appium (Java) |
| API Automation | REST Assured |
| Test Framework | TestNG, Playwright Test |
| Build Tool | Maven, npm |

## Cộng Đồng & Hỗ Trợ

- **Website:** [anhtester.com](https://anhtester.com)
- **Facebook Group:** [Cộng Đồng Tester Việt Nam](https://www.facebook.com/groups/anhtester)
- **Telegram:** [Anh Tester Community](https://t.me/anhtester)

## License

MIT License — Xem file [LICENSE](LICENSE) để biết chi tiết.
