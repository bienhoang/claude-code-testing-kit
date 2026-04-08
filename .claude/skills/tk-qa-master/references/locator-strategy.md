# Locator Strategy (All Frameworks)

> Locator stability and readability determine the health of an automation framework.
> Core principle: NEVER select elements based on styling-bound DOM structure. Build locators from semantic attributes.

## 1. Master Priority Map

Priority order (highest → lowest):

1. Accessibility / Aria attributes (semantic, screen reader friendly)
2. Test-specific attributes (`data-testid`, `data-test`, `data-qa`)
3. Identifier attributes (`id`, `resource-id`, `name`)
4. Framework-specific semantic functions (Playwright: `getByRole`, `getByLabel`...)
5. CSS Selector
6. XPath (last resort)

## 2. Stability Rules

Every locator must ensure:
- Matches **exactly 1 element** on the page (unique in scope)
- Survives UI changes — unaffected by layout changes (added/removed div wrappers, flexbox changes)

**FORBIDDEN:**
- Dynamic / hashed CSS class names (e.g., `css-1n2xyz-btn`)
- `nth-child`, `nth-of-type` chains when better options exist
- Auto-generated IDs by frameworks
- Absolute positional XPath (e.g., `//div[3]/div[2]/form/button`)

## 3. Locator Verification Process

Before using a locator in code, verify:

1. Does the locator match **exactly 1 element** in DOM?
2. Is the matched element the one users interact with? (not a shadow DOM overlay)
3. After reload/navigation — does the locator still work?
4. Across page states (loading, loaded, with data, empty) — is it stable?

## 4. Framework-Specific Locators

### Playwright
1. `getByRole()` — Best for semantic elements (button, link, heading...)
2. `getByLabel()` — Best for form fields with label
3. `getByPlaceholder()` — Best for inputs with placeholder text
4. `getByText()` — Best for text content
5. `getByTestId()` — Best when `data-testid` available
6. `locator("css")` — Fallback when no better option

### Selenium
1. `id` — Fastest, most unique
2. `data-testid` / `data-test` / `data-qa` — Test-specific attributes
3. `name` — Standard HTML attribute
4. `cssSelector` — Flexible, fast
5. `xpath` — Last resort

### Appium
1. `accessibility id` — Cross-platform, most stable
2. `resource-id` (Android) — Native Android attribute
3. `id` — General ID
4. `iOS predicate string` (iOS) — Fast, iOS-specific
5. `iOS class chain` (iOS) — iOS structure query
6. `xpath` — Last resort (slowest)

See framework-specific rules files for detailed examples.
