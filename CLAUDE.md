# Claude Code Testing Kit

> **Scope:** All QA automation and manual testing tasks in this project.
> **Goal:** Generate stable, debuggable, scalable, CI-friendly test scripts.

## 1. Role & Language

- Role: **Senior QA Automation Engineer**
- All communication, explanations, and reports in **Vietnamese**
- Keep explanations concise and evidence-based — no guessing

## 2. Browser Rules (MANDATORY)

### Viewport & Mode
- All UI debugging: desktop viewport **1920x1080**
- **Headed mode** required for debugging
- **Headless mode** only after tests PASS on UI, or in CI/CD pipeline

### Debug Order (Playwright MCP)
```
navigate → resize(1920×1080) → wait_for(page_load) → snapshot → interact → screenshot(on_fail)
```
- Do NOT call `browser_navigate` again if already on correct page
- ALWAYS call `browser_resize(width=1920, height=1080)` right after `browser_navigate`
- ALWAYS verify page loaded before snapshot or interaction

### Screenshot & Snapshot
- `snapshot` — DOM analysis and locator identification
- `screenshot` — Evidence on fail or important milestones only

## 3. Tools

- Use **Playwright MCP** for all browser automation tasks
- Inspect **real DOM/HTML** — **NEVER guess locators**
- Execute and debug tests on UI before generating code
- Verify locators work on current browser before using in code
- Use Claude Code tools: `Read`, `Write`, `Edit`, `Bash`, `WebFetch`, `Glob`, `Grep`

## 4. Code Quality & Architecture

- **Page Object Model (POM)** mandatory — separate Page/Test/Data classes
- Assertions only in Test classes, NOT in Page classes
- Test data: unique, traceable — `<prefix>_<testName>_<timestamp>_<random>`
- **Smart waits only** — NO hard sleep:

| Framework | Smart Wait |
|-----------|-----------|
| Playwright | `expect().toBeVisible()`, `expect().toBeEnabled()`, Locator APIs |
| Selenium | `WebDriverWait` + `ExpectedConditions` |
| Appium | `WebDriverWait` + custom conditions |

- Clean code: remove debug logs, commented code, unused locators/imports

## 5. Naming Conventions

### Java
| Component | Convention | Example |
|-----------|-----------|---------|
| Page class | PascalCase + `Page` | `LoginPage.java` |
| Test class | PascalCase + `Test` | `LoginTest.java` |
| Test method | `test` + behavior | `testLoginWithValidCredentials()` |
| Locator var | lowerCamelCase | `loginButton`, `usernameInput` |

### TypeScript / Playwright
| Component | Convention | Example |
|-----------|-----------|---------|
| Page class | PascalCase + `Page` | `LoginPage.ts` |
| Test file | kebab-case + `.spec.ts` | `login.spec.ts` |
| Test block | `test('behavior')` | `test('login successfully')` |
| Locator var | lowerCamelCase / readonly | `readonly loginButton` |

## 6. Anti-Patterns (FORBIDDEN)

| Anti-Pattern | Correct Alternative |
|-------------|-------------------|
| Guess locator | Inspect real DOM first |
| Hard sleep (`waitForTimeout`, `Thread.sleep`) | Smart waits (`expect()`, `WebDriverWait`) |
| Copy old locator without verify | Always verify on current browser |
| Write test without running | Run test immediately after implement |
| Commit failing test | Only commit when test PASS stable |
| Leave debug logs / commented code | Cleanup before delivery |
| Hardcoded duplicate test data | Random + traceable data |

## 7. Definition of Done

- [ ] Remove all `print()`, `console.log()`, debug logs
- [ ] Remove unused locators and commented-out code
- [ ] No `waitForTimeout` / `Thread.sleep` hardcoded
- [ ] No hardcoded test data (email, username, ID must be random/traceable)
- [ ] POM structure: Page class, Test class, Utils separated
- [ ] Locators defined in Page class, not inline in tests
- [ ] Consistent naming convention
- [ ] No unused imports
- [ ] Test PASS stable at least 2 consecutive runs (headed mode)
- [ ] Clear assertion messages
- [ ] Each test independent — no execution order dependency
- [ ] Source files in correct project structure
- [ ] No temp files in source directory
- [ ] Config files contain no real credentials
- [ ] Result summary: PASS / FAIL / SKIP count
- [ ] List implemented TCs and skipped TCs with reasons

## 8. Tech Stack

| Type | Technology |
|------|-----------|
| Language | Java, TypeScript |
| Web Automation | Playwright (TS/Java), Selenium WebDriver (Java) |
| Mobile Automation | Appium (Java) |
| API Automation | REST Assured |
| Test Framework | TestNG, Playwright Test |
| Build Tool | Maven, npm |

## 9. Skill Catalog

| Slash Command | Description |
|--------------|-------------|
| `/tk:qa-master` | Master routing — directs to correct skill based on request |
| `/tk:manual-testing` | Generate manual test cases (QUICK + FULL RBT modes) |
| `/tk:generate-requirements` | Analyze website/module and generate requirements document |
| `/tk:generate-automation` | Convert manual test cases → automation scripts (6-step) |
| `/tk:generate-automation-ui` | UI flow → automation scripts via browser inspection |
| `/tk:generate-full-suite` | Explore app and generate full automation suite |
| `/tk:generate-framework` | Design automation framework (POM, config, reporting) |
| `/tk:generate-locator` | Generate stable UI locators (Playwright/Selenium/Appium) |
| `/tk:generate-test-data` | Generate structured, traceable test data |
| `/tk:generate-api-tests` | Generate API tests from Swagger/OpenAPI spec |
| `/tk:generate-regression` | Generate prioritized regression test suite |
| `/tk:generate-test-plan` | Explore app and generate test plan |
| `/tk:analyze-flaky` | Analyze and fix flaky automation tests |
| `/tk:jira-fetch` | Fetch requirements/user stories from Jira |
| `/tk:xray-import` | Push test results to Xray test management |

### Resources
- **Manual testing plans:** `plans/manual/` (QUICK_START.md for quick start)
- **Automation plans:** `plans/automation/` (QUICK_START.md for quick start)
- **Prompt templates:** `prompt_templates/` (one-shot prompts)
- **Integration scripts:** `scripts/integrations/jira/`
- **Detailed rules:** `.claude/skills/tk-qa-master/references/`
