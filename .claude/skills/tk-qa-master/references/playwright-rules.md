# Playwright-Specific Rules

> Applies when setting up and running automation with Playwright (TypeScript or Java).

## 1. Browser Setup (MANDATORY)

- **Debug viewport:** All UI debugging must use desktop viewport: **1920x1080**.
- **Playwright MCP — Resize mandatory:** When using Playwright MCP for UI debugging, **ALWAYS** call `browser_resize(width=1920, height=1080)` **immediately after opening browser** (after first `browser_navigate`).
  ```
  Mandatory order:
  1. browser_navigate(url) → open page
  2. browser_resize(width=1920, height=1080) → set viewport
  3. browser_snapshot() or browser_take_screenshot() → start inspect
  ```
- **Headed mode:** Required during setup and debugging.
- **Headless mode:** Only when test has PASSED 100% on headed mode, or in CI/CD pipeline.

## 2. Development Workflow & Element Discovery

- Use **Playwright MCP** to open browser and interact with target page.
- **Inspect real DOM:** Verify and capture selectors directly from browser DOM.
- **ABSOLUTELY FORBIDDEN:**
  - Guessing locators
  - Blindly copying old locators without verification
  - Relying on URLs / documentation without confirming existence on actual UI

## 3. Locator Priority

Playwright provides user-facing semantic locators. Prefer these over CSS/XPath:

1. `getByRole()` — Best for semantic elements (button, link, heading...)
2. `getByLabel()` — Best for form fields with label
3. `getByPlaceholder()` — Best for inputs with placeholder text
4. `getByText()` — Best for text content
5. `getByTestId()` — Best when element has `data-testid`
6. `locator("css")` — Fallback when no better option

Example:
```typescript
// Correct — Semantic locator
page.getByRole('button', { name: 'Login' })
page.getByLabel('Email')
page.getByPlaceholder('Enter password')

// Wrong — Raw XPath/CSS when semantic alternative exists
page.locator('//button[@class="btn-login"]')
page.locator('.form-input:nth-child(2)')
```

## 4. Wait Strategy

**FORBIDDEN:**
- `page.waitForTimeout()` — hard sleep
- `await new Promise(r => setTimeout(r, N))` — custom delay
- Any fixed-time wait

**USE:**
- Playwright's default auto-waiting
- Web-First Assertions:
  ```typescript
  await expect(locator).toBeVisible();
  await expect(locator).toBeEnabled();
  await expect(locator).toHaveText('Success');
  await expect(page).toHaveURL(/dashboard/);
  ```
- Use `waitForSelector()` only when `expect()` cannot meet special requirements

## 5. Test Structure

```typescript
test.describe('Module Name', () => {
  test.beforeEach(async ({ page }) => {
    // Setup: navigate, login...
  });

  test('behavior to test', async ({ page }) => {
    // Arrange: initialize page objects, data
    // Act: perform action
    // Assert: verify result
  });
});
```

- Every test block must have **clear assertions**
- Use `test.describe` to group tests by module
- Use `beforeEach` / `afterEach` for setup / teardown
