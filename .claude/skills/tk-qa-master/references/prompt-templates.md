# Prompt Templates

Reusable prompt templates for common QA automation tasks. Reference these when formatting output or when user provides unclear requirements.

---

## 1. Test Case Generation

```
Analyze the following requirement and generate test cases:

**Requirement:** [Requirement description]

**Output format:**
| TC ID | Test Case Title | Precondition | Steps | Expected Result | Priority | Type |

**Requirements:**
- Include positive, negative, boundary, edge cases
- Use Vietnamese for descriptions
- Priority: High / Medium / Low
- Type: Positive / Negative / Boundary / Edge
```

## 2. Automation Script Generation

```
Convert the following test case into automation script:

**Test Case:** [TC content]
**Framework:** [Selenium Java / Playwright TypeScript]
**Pattern:** Page Object Model

**Output:**
1. Page Object class(es)
2. Test class
3. Test data (if needed)

**Rules:**
- Smart waits only (no hard sleep)
- Random test data with prefix + timestamp
- Clear assertions
```

## 3. API Test Generation

```
Generate API tests from Swagger specification:

**Swagger URL:** [URL]
**Endpoint(s):** [Endpoints to test]
**Framework:** REST Assured + TestNG

**Include:**
- Happy path (200 OK)
- Validation errors (400)
- Authentication (401/403)
- Not found (404)
- Boundary values
- Schema validation
```

## 4. Locator Generation

```
Inspect element and generate stable locator:

**Element:** [Element description]
**Page URL:** [URL]
**Tool:** [Selenium / Playwright]

**Output:**
- Primary locator
- Fallback locator
- Reasoning for locator choice
```

## 5. Flaky Test Analysis

```
Analyze flaky test and suggest fix:

**Test file:** [Path to test]
**Symptoms:** [Flaky behavior description]

**Analysis:**
1. Root cause
2. Pattern detected (timing, data, environment, selector)
3. Specific fix suggestion
4. Code fix
```

## 6. Test Data Generation

```
Generate test data for module:

**Module:** [Module name]
**Fields:** [List of fields needing data]

**Include:**
- Valid data (happy path)
- Invalid data (negative)
- Boundary values (min, max, empty, null)
- Special characters
- Format: JSON / CSV / Excel
```
