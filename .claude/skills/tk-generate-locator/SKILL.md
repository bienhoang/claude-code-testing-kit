---
name: Locator Generator
description: Generate stable UI locators for automation testing. Inspects real DOM, applies priority strategy, provides primary + fallback locators. Supports Playwright, Selenium, Appium.
---

# Locator Generator

## Description

Generate stable, maintainable locators for UI automation. Inspects real DOM, identifies stable attributes, and provides primary + fallback locators with reasoning.

## When to Use

- Generate locators for new UI elements
- Review existing locators for stability
- Migrate locators between frameworks (Playwright ↔ Selenium ↔ Appium)

## Locator Priority (7-tier)

1. **Accessibility attributes** (aria-label, role)
2. **Test-specific attributes** (`data-testid`, `data-test`, `data-qa`)
3. **`id`**
4. **`name`**
5. **Framework semantic locators** (Playwright: `getByRole`, `getByLabel`...)
6. **CSS Selector**
7. **XPath** (last resort)

## Framework-Specific Locators

### Playwright
```typescript
page.getByRole('button', { name: 'Submit' })
page.getByLabel('Email')
page.getByPlaceholder('Enter your password')
page.getByTestId('submit-btn')
```

### Selenium
```java
driver.findElement(By.id("login-button"));
driver.findElement(By.cssSelector("button[data-testid='submit-btn']"));
driver.findElement(By.name("username"));
```

### Appium
```java
driver.findElement(AppiumBy.accessibilityId("login_button"));
driver.findElement(AppiumBy.id("com.app:id/login_button"));
driver.findElement(AppiumBy.iOSNsPredicateString("label == 'Login'"));
```

## Process

1. **Inspect DOM** — Use Playwright MCP `snapshot` or user-provided HTML
2. **Identify stable attributes** — Check id, data-testid, name, aria-label, role, placeholder
3. **Generate primary locator** — Best, most stable option
4. **Generate fallback locator** — Alternative if primary breaks
5. **Validate** — Verify uniqueness and stability

## Validation Checklist

- [ ] Matches exactly one element
- [ ] Element is visible and interactable
- [ ] Stable across page reloads
- [ ] Survives cosmetic DOM changes (layout, styling)
- [ ] Does NOT use dynamic class names or positional xpath

## Forbidden

- Dynamic/hashed CSS class names (`css-1n2xyz-btn`)
- `nth-child` chains when better options exist
- Auto-generated IDs
- Absolute positional XPath (`//div[3]/div[2]/form/button`)

## Output Format

1. **Primary locator** — The best, most stable option
2. **Fallback locator** — Alternative if primary breaks
3. **Reasoning** — Why this locator was chosen

## References

- `tk-qa-master/references/locator-strategy.md` — Master priority map
- `tk-qa-master/references/playwright-rules.md` — Playwright locators
- `tk-qa-master/references/selenium-rules.md` — Selenium locators
- `tk-qa-master/references/appium-rules.md` — Appium locators
