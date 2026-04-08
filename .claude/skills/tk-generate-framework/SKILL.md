---
name: Automation Framework Designer
description: Design scalable automation framework with POM, driver management, reporting, and CI/CD integration. Supports Selenium Java and Playwright TypeScript.
---

# Automation Framework Designer

## Description

Design and generate a scalable test automation framework. Creates project structure, base classes, configuration, utilities, and reporting setup.

## When to Use

- New automation project — need framework setup
- Design Selenium Java or Playwright TypeScript framework
- Create base classes, driver management, reporting infrastructure

## Framework Components

### 1. Driver/Browser Management
- WebDriver factory (Selenium) or Playwright config
- Browser selection (Chrome, Firefox, Edge)
- Headed/headless mode configuration
- Viewport settings (default: 1920x1080)

### 2. Base Test Class
- Setup/teardown lifecycle
- Driver initialization and cleanup
- Screenshot on failure
- Logging setup

### 3. Page Object Structure
- Base Page class with common methods (click, type, wait...)
- Page-specific classes extending Base Page
- Locators as class properties

### 4. Wait Utilities
- Smart wait helpers (no hard sleep)
- Selenium: WebDriverWait + ExpectedConditions wrappers
- Playwright: auto-waiting + web-first assertions

### 5. Configuration Management
- Environment-specific config (dev, staging, prod URLs)
- Properties file or .env based
- No hardcoded credentials

### 6. Reusable Utilities
- DataGenerator (random, traceable test data)
- FileHelper (read test data from JSON/CSV/Excel)
- DateHelper, StringHelper as needed

### 7. Test Reporting
- **Java:** Allure Report, Log4j 2.x for logging
- **TypeScript:** Playwright built-in HTML reporter
- Screenshot attachment on failure

## Output

1. Recommended project structure (directory tree)
2. Key framework classes (Base Test, Base Page, Driver Factory)
3. Configuration files (pom.xml/package.json, config.properties/playwright.config.ts)
4. Example base classes with code
5. Best practices document

## Supported Stacks

| Stack | Language | UI Tool | Test Runner | Build | Report |
|-------|----------|---------|-------------|-------|--------|
| Java | Java | Selenium | TestNG | Maven | Allure + Log4j 2.x |
| TypeScript | TypeScript | Playwright | Playwright Test | npm | Built-in HTML |
