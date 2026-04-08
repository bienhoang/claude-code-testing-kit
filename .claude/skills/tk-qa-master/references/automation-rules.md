# General Automation Rules

> Applies to all automation testing tasks, regardless of framework (Playwright, Selenium, Appium).

## 1. Architecture & Framework

- **Page Object Model (POM)** is mandatory.
- Clear separation:
  - **Page classes:** Declare locators + UI interaction methods
  - **Test classes:** Test logic + assertions
  - **Test data:** Separate from functional code (JSON, DataProvider, Utils)
- Assertions belong in Test classes only, NOT in Page classes.

## 2. Test Data Generation

- All unique fields (Email, Username, Customer Code) **must be dynamically generated**, not hardcoded.
- Use UUID, Timestamp, or Faker library.
- Data must be **traceable** — looking at DB, you can identify which test created it:
  ```
  Format: [prefix]_[testName]_[timestamp]_[random]
  Example: auto_createCustomer_20260402_A3F2@test.com
  ```
- Support parallel execution: each test method has its own isolated data.

## 3. Code Quality

- No duplicated logic — create helper methods for repeated actions.
- Code must be simple, readable, maintainable.
- Before delivery:
  - Remove all `console.log`, `System.out.println`, `print()` from debugging
  - Remove commented-out code (`//`, `/* */`)
  - Remove unused locators / variables

## 4. File & Directory Management

- Do NOT auto-delete source files without user confirmation.
- Check existing directory structure before creating new files — avoid duplicates.
- Place files in correct directories per project architecture.

## 5. Naming Conventions

### Java

| Component | Convention | Example |
|-----------|-----------|---------|
| Page class | PascalCase + `Page` suffix | `LoginPage.java`, `CartPage.java` |
| Test class | PascalCase + `Test` suffix | `LoginTest.java`, `CartTest.java` |
| Test method | Start with `test` + behavior | `testLoginWithValidCredentials()` |
| Locator var | lowerCamelCase + element descriptor | `loginButton`, `usernameInput` |
| Utils class | PascalCase + function descriptor | `DataGenerator.java`, `WaitHelper.java` |

### TypeScript / Playwright

| Component | Convention | Example |
|-----------|-----------|---------|
| Page class | PascalCase + `Page` suffix | `LoginPage.ts`, `CartPage.ts` |
| Test file | kebab-case + `.spec.ts` | `login.spec.ts`, `cart.spec.ts` |
| Test block | `test('behavior description')` | `test('login successfully')` |
| Locator var | lowerCamelCase or readonly | `readonly loginButton` |
| Utils | PascalCase or kebab-case | `DataGenerator.ts`, `data-generator.ts` |

## 6. Assertions

- Every test case **MUST** have at least 1 assertion at the end.
- Add assertions at important intermediate steps.
- Assert must describe expected behavior clearly:
  ```java
  // Java/TestNG
  Assert.assertTrue(dashboardPage.isDisplayed(), "Dashboard should display after login");
  ```
  ```typescript
  // Playwright
  await expect(page.getByText('Login successful')).toBeVisible();
  ```

## 7. Test Independence

- Each test case must be **independent** — no dependency on other test results.
- Clear setup/teardown (`@BeforeMethod/@AfterMethod` or `beforeEach/afterEach`).
- No shared mutable state between test methods.
