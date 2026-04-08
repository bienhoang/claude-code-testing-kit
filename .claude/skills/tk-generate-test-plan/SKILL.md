---
name: Test Plan Generator
description: Explore web application and generate test plan identifying key flows, modules, and automation opportunities.
---

# Test Plan Generator

## Description

Explore a web application and generate a comprehensive test plan. Identifies modules, key user flows, test approach, and automation opportunities.

## When to Use

- New project — need test planning
- Identify automation candidates
- Create test strategy document for a web application

## Process

### 1. Explore Application
- Use **Playwright MCP** to open app URL and navigate
- Set viewport to 1920x1080
- Discover pages, menus, navigation structure
- Fallback: ask user for app description/screenshots if Playwright MCP unavailable

### 2. Identify Modules
- Map major application modules
- Identify module dependencies
- Note authentication/authorization requirements

### 3. Map Key Flows
- User registration / onboarding
- Login / authentication
- Core business operations
- Search and navigation
- CRUD operations per module
- Admin/management flows

### 4. Assess Automation Opportunities
- Identify repetitive flows suitable for automation
- Prioritize by business impact and execution frequency
- Note technical feasibility (complex UI interactions, third-party integrations)

## Output

1. **App Overview** — Brief description, modules discovered
2. **Module Map** — List of modules with descriptions and priority
3. **Key Flows** — User flows per module
4. **Test Approach** — Suggested test types per module (manual, automated, API)
5. **Automation Candidates** — Flows recommended for automation with justification
6. **Test Scenarios** — High-level test scenarios per flow

## Fallback

If Playwright MCP unavailable:
- Ask user for app description
- Request screenshots of key pages
- Use `WebFetch` for basic page analysis
