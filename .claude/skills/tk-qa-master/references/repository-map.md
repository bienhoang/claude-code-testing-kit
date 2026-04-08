# Repository Map

## Usage Guide

This file provides the repository structure map so the agent knows where to place code when generating automation scripts.

> Update this file when project structure changes.

---

## Maven Standard Structure (Java + Selenium/TestNG)

```
project-root/
├── pom.xml                              # Dependencies & build config
├── src/
│   ├── main/
│   │   └── java/
│   │       └── [package]/
│   │           ├── pages/               # Page Object classes
│   │           ├── utils/               # Utilities (WebDriver, Waits, Helpers)
│   │           └── config/              # Configuration classes
│   └── test/
│       ├── java/
│       │   └── [package]/
│       │       ├── tests/              # Test classes (@Test methods)
│       │       ├── base/               # BaseTest, TestNG listeners
│       │       └── dataproviders/      # DataProvider classes
│       └── resources/
│           ├── testdata/               # Test data files (JSON, CSV, Excel)
│           ├── config.properties       # Environment config
│           └── testng.xml              # TestNG suite configuration
├── reports/                            # Generated test reports
└── README.md
```

## Playwright Structure (TypeScript)

```
project-root/
├── package.json
├── playwright.config.ts                # Playwright configuration
├── tests/
│   ├── pages/                          # Page Object classes
│   ├── specs/                          # Test spec files (.spec.ts)
│   ├── fixtures/                       # Custom fixtures
│   └── utils/                          # Helper utilities
├── test-data/                          # External test data
├── test-results/                       # Test execution results
└── README.md
```

## File Placement Rules

| File Type | Location | Naming Convention |
|-----------|----------|-------------------|
| Page Object | `pages/` | `LoginPage.java` / `login.page.ts` |
| Test Class | `tests/` | `LoginTest.java` / `login.spec.ts` |
| Base Test | `base/` | `BaseTest.java` |
| Utilities | `utils/` | `WebDriverHelper.java` / `helpers.ts` |
| Test Data | `testdata/` | `login_data.json` |
| Config | `config/` or root | `config.properties` |
