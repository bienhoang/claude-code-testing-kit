---
name: Full Automation Suite Generator
description: Explore a web application, discover all modules and flows, generate comprehensive test scenarios and automation skeleton. Ideal for new projects.
---

# Full Automation Suite Generator

## Description

End-to-end application exploration + comprehensive test suite generation. Opens the app, discovers modules, generates test scenarios, manual TCs overview, and automation skeleton.

## When to Use

- New project — need to explore app structure
- Generate complete test coverage for an application
- Bootstrap automation for a project from scratch

## Process

### 1. Open Application
- Use **Playwright MCP** to navigate to app URL
- Set viewport to 1920x1080
- Verify page loads successfully

### 2. Explore Structure
- Navigate through menus, navigation bars, sidebar
- Discover all accessible pages and modules
- Map the application structure

### 3. Identify Modules & Flows
Common flows to discover:
- Login and authentication
- User registration
- Search functionality
- Product browsing / listing
- Add to cart / checkout
- Profile management
- Admin / dashboard
- Logout

### 4. Generate Test Scenarios
- For each discovered module, generate test scenarios
- Categorize: Smoke / Regression / Edge cases
- Assign priority: P1 (critical) / P2 (main) / P3 (secondary)

### 5. Generate Manual TCs Overview
- High-level test case list per module
- Format as Markdown table

### 6. Generate Automation Skeleton
- POM structure: Page Object classes per discovered page
- Base test class with setup/teardown
- Test class stubs with TODO markers
- Project structure following `tk-qa-master/references/repository-map.md`

## Output

1. **App Overview** — Modules discovered, navigation map
2. **Test Scenarios** — Prioritized list per module
3. **Manual TCs** — High-level Markdown table
4. **Automation Skeleton** — POM classes, test stubs, project structure

## Framework Default

- **Language:** Java
- **UI Automation:** Selenium WebDriver
- **Test Framework:** TestNG
- **Design Pattern:** Page Object Model

## Fallback

If Playwright MCP unavailable, ask user for:
- App description and screenshots
- List of modules and key features
- Navigation structure
