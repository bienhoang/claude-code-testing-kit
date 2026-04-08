---
name: UI Flow Automation Generator
description: Execute UI steps via browser debugging, inspect DOM, collect locators, and generate Selenium/Playwright automation scripts from UI flows.
---

# UI Flow Automation Generator

## Description

Generate automation scripts directly from UI steps — skip the manual test case step. Opens browser, executes steps, captures locators from real DOM, and generates Page Object + Test class.

## When to Use

- Direct UI flow to automation (no manual TC step)
- User provides URL + list of UI steps to automate
- Quick automation from screen recording or step description

## Process

### 1. Open Target Page
- Use **Playwright MCP** to navigate to target URL
- Set viewport to 1920x1080 (desktop)
- Use headed mode for debugging

### 2. Inspect DOM
- Use `snapshot` to analyze DOM elements
- Identify attributes: `id`, `data-testid`, `name`, `aria-label`, `role`, `placeholder`
- Capture HTML structure of target elements

### 3. Execute UI Steps
- Follow user-provided steps sequentially
- At each step, capture the locator used for interaction
- Verify element state (visible, enabled, text content)
- Take screenshots on failure or important milestones

### 4. Generate Locators
- Apply locator priority from `tk-qa-master/references/locator-strategy.md`
- Playwright: prefer semantic locators (`getByRole`, `getByLabel`...)
- Selenium: prefer `id`, `data-testid`, `name`, then CSS
- Validate locator uniqueness on page

### 5. Generate Code
- `Write` Page Object class with collected locators and interaction methods
- `Write` Test class with steps matching the UI flow
- Follow POM pattern and naming conventions

## Output

- Page Object class (locators + methods)
- Test class (test steps + assertions)

## Fallback

If Playwright MCP unavailable:
- Ask user to provide DOM snippets or screenshots
- Use `WebFetch` to get page HTML
- Generate locators from provided HTML

## Framework Default

- **Java:** Selenium WebDriver + TestNG + POM
- **TypeScript:** Playwright Test + POM

## Rules References

- `tk-qa-master/references/locator-strategy.md` — Locator priority
- `tk-qa-master/references/playwright-rules.md` — Playwright rules
- `tk-qa-master/references/selenium-rules.md` — Selenium rules
