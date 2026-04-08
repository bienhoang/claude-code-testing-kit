---
name: Regression Suite Generator
description: Generate prioritized regression test suite from application features. Categorizes by P1 (critical), P2 (main), P3 (secondary).
---

# Regression Suite Generator

## Description

Generate a prioritized regression test suite from application features and existing test scenarios.

## When to Use

- Build regression suite for an application
- Prioritize test coverage for release validation
- Identify critical paths needing regression coverage

## Process

### 1. Analyze Features
- Review application modules and features
- Identify business-critical flows (payments, authentication, data integrity)
- Map user journeys and integration points

### 2. Identify Critical Flows
- Core business operations
- Revenue-affecting features
- Security-sensitive areas
- High-traffic user paths

### 3. Generate Regression Scenarios
For each module, generate test scenarios covering:
- Happy path (main flow)
- Key negative scenarios
- Integration points between modules
- Data validation

### 4. Assign Priority

| Level | Criteria | Example |
|-------|----------|---------|
| **P1 - Critical** | Core business, payment, auth, data loss risk | Login, checkout, payment |
| **P2 - Main** | Main features, frequently used | Search, profile update, listing |
| **P3 - Secondary** | Edge cases, low-traffic features | Settings, help page, rarely used filters |

## Output

Prioritized regression scenario list as Markdown table:

```
| # | Module | Scenario | Priority | Type | Automation Candidate |
```

- Type: Smoke / Functional / Integration / E2E
- Automation Candidate: Yes / No (with reason)
