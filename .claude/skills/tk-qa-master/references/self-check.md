# Self Check

Mandatory checklist the agent must verify **before completing** any task.

---

## Code Quality

- [ ] Code follows Page Object Model (POM)
- [ ] Clear separation: Page objects / Test classes / Utils / Test data
- [ ] No hard-coded values (URLs, credentials, test data)
- [ ] Consistent and readable naming convention
- [ ] No leftover code: commented code, debug logs

## Locator Quality

- [ ] Locators inspected from real DOM (not guessed)
- [ ] Stable locators per priority list (id > data-testid > name > css > xpath)
- [ ] No fragile locators (auto-generated classes, positional xpath)
- [ ] Playwright: semantic locators preferred (getByRole, getByLabel, getByPlaceholder)

## Wait Strategy

- [ ] No hard sleep (Thread.sleep, waitForTimeout, fixed delay)
- [ ] Smart waits used (WebDriverWait, expect(), auto-waiting)
- [ ] Reasonable timeout values (not too short causing flaky, not too long causing slow)

## Test Execution

- [ ] Test has been run and PASSES stably
- [ ] Test has clear assertions validating expected behavior
- [ ] Test data uses random values with prefix + timestamp (traceable)
- [ ] Each test case is independent, no dependency on other tests

## Test Data

- [ ] Unique fields (email, username, code) use random data
- [ ] Random data is traceable (deterministic: test name + timestamp + prefix)
- [ ] No sensitive data (real passwords, PII) in code

## Documentation

- [ ] Test case has clear description (precondition, steps, expected result)
- [ ] Code comments only for complex logic (no obvious comments)
- [ ] README or test execution guide if needed

## CI/CD Ready

- [ ] Test can run in headless mode
- [ ] No dependency on specific local environment
- [ ] TestNG XML / Playwright config properly set up
