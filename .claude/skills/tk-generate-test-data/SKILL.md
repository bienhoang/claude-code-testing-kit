---
name: Test Data Generator
description: Generate structured, unique, traceable test data sets for testing. Supports positive, negative, boundary, and edge case categories.
---

# Test Data Generator

## Description

Generate reliable, structured test data for automation and manual testing. Covers positive, negative, boundary, and edge case categories.

## When to Use

- Create test data for new test cases
- Generate boundary and edge case data
- Set up data-driven tests
- Create API request payloads

## Data Rules

All generated data must be:
- **Unique** — No duplication within test suite
- **Deterministic** — Same seed produces same data (when needed)
- **Traceable** — Can identify which test generated it

## Unique Data Pattern

Format: `<prefix>_<testName>_<timestamp>`

### Common Types

| Type | Pattern | Example |
|------|---------|---------|
| Email | `auto_<test>_<ts>@test.com` | `auto_register_20260402@test.com` |
| Username | `user_<test>_<ts>` | `user_login_20260402133000` |
| Phone | Random 10-digit, valid prefix | `0912345678` |
| Password | Mix upper/lower/digit/special | `Test@12345` |

## Data Categories

### Positive (Happy Path)
- Valid format, within constraints
- All required fields filled
- Standard business values

### Negative
- Missing required fields
- Invalid format (wrong email, short password)
- Invalid characters
- Already existing values (duplicate check)

### Boundary Values
- Minimum length (e.g., 1 character)
- Maximum length (e.g., 255 characters)
- Min + 1, Max - 1
- Empty string vs null
- Zero, negative numbers

### Edge Cases
- Unicode / special characters
- Very long strings
- SQL injection patterns (for security testing)
- HTML tags in text fields
- Leading/trailing whitespace

## Process

1. Analyze feature/module — identify fields and validation rules
2. Determine field constraints (from DOM inspection or requirements)
3. Generate data per category (positive, negative, boundary, edge)
4. Output in structured format

## Output Format

```json
{
  "positive": [
    { "email": "auto_tc01_20260402@test.com", "password": "Test@12345" }
  ],
  "negative": [
    { "email": "", "password": "Test@12345", "expectedError": "Email is required" },
    { "email": "invalid-email", "password": "Test@12345", "expectedError": "Invalid email format" }
  ],
  "boundary": [
    { "email": "a@b.co", "password": "12345678", "note": "Min length" }
  ]
}
```

## Constraints

- Respect field validation rules (from DOM or requirements)
- Match input format (date format, phone format)
- Avoid duplication across test runs
- No real PII (personal data)

## References

- `tk-qa-master/references/automation-rules.md` — Test data rules (Section 2)
