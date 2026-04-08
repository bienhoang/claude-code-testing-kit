---
name: QA Testing Kit Master
description: Master routing skill for QA testing tasks. Routes to appropriate tk:* skills based on user request. Supports Playwright, Selenium, Appium, REST Assured.
---

# QA Testing Kit Master

## Description

Master skill for QA automation and manual testing. Routes user requests to the correct `tk:*` skill based on intent.

Capabilities:
- Manual test case generation (QUICK + FULL RBT)
- Automation script generation from test cases or UI flows
- API test generation from Swagger/OpenAPI
- App exploration and test planning
- Framework design, test data, locator generation
- Flaky test analysis
- Jira/Xray integration

## When to Use

Use this skill when the user asks about test automation, manual testing, automation frameworks, API testing, UI testing, test data, flaky tests, locators, requirements analysis, Jira integration, or Xray test management.

## Routing Table

| User Intent | Route To |
|-------------|----------|
| "generate test cases" / "manual testing" | `/tk:manual-testing` |
| "generate automation from test cases" | `/tk:generate-automation` |
| "generate automation from UI" / "automate UI flow" | `/tk:generate-automation-ui` |
| "generate requirements from website" | `/tk:generate-requirements` |
| "generate API tests" / "Swagger" | `/tk:generate-api-tests` |
| "generate locator" / "find stable selector" | `/tk:generate-locator` |
| "generate test data" | `/tk:generate-test-data` |
| "analyze flaky tests" | `/tk:analyze-flaky` |
| "generate framework" / "design framework" | `/tk:generate-framework` |
| "generate full suite" / "bootstrap automation" | `/tk:generate-full-suite` |
| "generate regression suite" | `/tk:generate-regression` |
| "generate test plan" / "explore application" | `/tk:generate-test-plan` |
| "fetch Jira requirements" / "get Jira ticket" | `/tk:jira-fetch` |
| "push results to Xray" / "import test execution" | `/tk:xray-import` |

## Framework Defaults

- **Language:** Java or TypeScript
- **UI Automation:** Selenium WebDriver (Java) or Playwright (TypeScript)
- **Test Framework:** TestNG (Java) or Playwright Test (TypeScript)
- **API Automation:** REST Assured (Java)
- **Mobile Automation:** Appium (Java)
- **Design Pattern:** Page Object Model (POM)

## Locator Strategy Summary

Priority order (high → low):
1. Accessibility / Aria attributes
2. Test-specific attributes (`data-testid`, `data-test`, `data-qa`)
3. Identifier attributes (`id`, `resource-id`, `name`)
4. Framework semantic locators (Playwright: `getByRole`, `getByLabel`...)
5. CSS Selector
6. XPath (last resort)

**FORBIDDEN:** dynamic class names, `nth-child`, auto-generated IDs, absolute XPath.

See `references/locator-strategy.md` for detailed rules per framework.

## Rules References

Detailed rules in `references/` folder:
- `automation-rules.md` — POM, test data, naming, assertions
- `locator-strategy.md` — Locator priority per framework
- `playwright-rules.md` — Browser setup, semantic locators, wait strategy
- `selenium-rules.md` — WebDriverWait, TestNG structure
- `appium-rules.md` — Mobile locators, scroll, permissions
- `project-context.md` — Project domain template
- `repository-map.md` — Repository structure guide
- `test-strategy.md` — Testing scope and execution plan
- `self-check.md` — Quality checklist before task completion
- `prompt-templates.md` — Reusable prompt templates
