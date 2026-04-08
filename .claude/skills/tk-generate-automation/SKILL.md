---
name: Automation Script Generator
description: Convert manual test cases into automation scripts autonomously. 6-step process with POM architecture, real DOM inspection, and auto-healing loop. Supports Playwright TS and Selenium Java.
---

# Automation Script Generator

## Description

Autonomous 6-step automation generation from manual test cases. Inspects real DOM, builds POM architecture, generates scripts, and self-heals on failure.

## When to Use

- Convert manual test cases to automation scripts
- Generate Selenium/Playwright automation from test case files
- Automate existing test scenarios

## Prerequisites

- Test cases file provided by user
- Target framework specified: **Playwright TypeScript** or **Selenium Java**
- Application URL accessible

## Process (6 Steps)

### Step 1: Context & Analysis
- `Read` the test cases file provided by user
- Identify pages/screens the tests will navigate through
- Create task tracking via `TaskCreate` for the 6-step process

### Step 2: Autonomous UI Recon
- Use **Playwright MCP** to open browser, navigate to app URL
- Set viewport to 1920x1080
- Use `snapshot` to inspect DOM and collect locators at each page
- **NEVER guess selectors** — all locators from real DOM inspection
- Fallback: if Playwright MCP unavailable, ask user for DOM snippets/screenshots

### Step 3: POM Architecture Design
- `Write` Page Object classes with locators collected from Step 2
- Follow naming conventions from `tk-qa-master/references/automation-rules.md`
- Locators as class properties, interaction methods as class methods

### Step 4: Test Data Strategy
- `Write` DataGenerator utility (Faker/random)
- Unique, traceable format: `auto_<testName>_<timestamp>@test.com`
- Separate test data from test logic

### Step 5: Script Generation
- `Write` Test classes importing POM and Utils
- 3-part structure per test: **Setup (Arrange) → Execution (Act) → Verification (Assert)**
- Every test must have assertions checking success/failure states

### Step 6: Execute & Auto-Heal (RULE E3)
- `Bash` to run tests (`mvn test` or `npx playwright test`)
- If **PASS**: Clean up logs, update task tracking (Done)
- If **FAIL**: Enter auto-heal loop:

```
while test fails:
  1. Read error log (Bash output)
  2. Analyze root cause (locator? timing? data? logic?)
  3. If locator issue: re-inspect DOM via Playwright MCP
  4. Edit fix in relevant file
  5. Re-run test (Bash)
```

**RULE E3:** Do NOT ask user during fix loop. Only ask if business logic contradiction found.

## Output

- Page Object classes (in `pages/` directory)
- Test classes (in `tests/` directory)
- DataGenerator utility (in `utils/` directory)
- Task tracking updates via `TaskUpdate`

## Rules References

- `tk-qa-master/references/automation-rules.md` — Naming, POM structure
- `tk-qa-master/references/playwright-rules.md` — Playwright-specific rules
- `tk-qa-master/references/selenium-rules.md` — Selenium-specific rules
- `tk-qa-master/references/self-check.md` — Quality checklist before completion
