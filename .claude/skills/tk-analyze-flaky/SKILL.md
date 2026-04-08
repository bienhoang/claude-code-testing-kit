---
name: Flaky Test Analyzer
description: Analyze automation tests for flakiness. Identifies unstable locators, timing issues, data conflicts. Provides root cause analysis and fixes.
---

# Flaky Test Analyzer

## Description

Identify and resolve unstable automation tests. Analyzes test code, classifies root causes, and provides specific fixes.

## When to Use

- A test passes and fails intermittently
- Test results inconsistent across runs
- CI/CD pipeline has unreliable test results

## Common Causes

| Cause | Symptoms | Fix |
|-------|----------|-----|
| Unstable locator | `NoSuchElement`, works sometimes | Replace with stable locator per priority |
| Timing issue | Race conditions, slow loads | Smart waits instead of hard sleep |
| Shared test data | Fails in parallel, passes solo | Unique traceable data per test |
| Environment dependency | External service down, stale data | Isolate tests, mock external deps |
| Race condition | Async operations incomplete | Proper wait for async completion |

## Analysis Process

### 1. Detect
- `Read` the failing test file
- Identify the error message and stack trace

### 2. Inspect
- Analyze locators for fragility (dynamic classes, positional xpath)
- Check for hard sleeps (`Thread.sleep`, `waitForTimeout`)
- Check test data for uniqueness issues
- Check setup/teardown for shared state

### 3. Classify Root Cause
- **Locator:** Dynamic class, positional xpath, auto-generated ID
- **Timing:** Hard sleep, missing wait, race condition
- **Data:** Shared data, hardcoded data, duplicate data
- **Environment:** External dependency, cleanup missing

### 4. Fix
Apply framework-appropriate fix:

**Unstable Locator:**
```java
// Before: fragile
driver.findElement(By.xpath("//div[3]/button"));
// After: stable
driver.findElement(By.id("submit-btn"));
```

**Timing Issue:**
```java
// Before: hard sleep
Thread.sleep(3000);
// After: smart wait
WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10));
wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("result")));
```

**Data Conflict:**
```
// Before: hardcoded
String email = "test@test.com";
// After: unique traceable
String email = "auto_login_" + System.currentTimeMillis() + "@test.com";
```

### 5. Verify
- Re-run test multiple times to confirm stability
- Target: 5+ consecutive passes

## Stability Checklist

After fixing a flaky test:
- [ ] Locator is unique and stable across reloads
- [ ] No hard sleep or fixed delays
- [ ] Test data is unique and deterministic
- [ ] Test is independent (no dependency on other tests)
- [ ] Test passes 5+ consecutive runs

## References

- `tk-qa-master/references/locator-strategy.md` — Locator stability
- `tk-qa-master/references/automation-rules.md` — General best practices
- `tk-qa-master/references/selenium-rules.md` — Selenium wait strategy
- `tk-qa-master/references/playwright-rules.md` — Playwright auto-waiting
