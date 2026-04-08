---
name: Xray Test Results Importer
description: Push automation test results (Playwright JSON, JUnit XML, Xray JSON) to Xray test management. Supports Cloud and Server/Data Center.
---

# Xray Test Results Importer

## Description

Push automation test results to Xray (Cloud or Server/Data Center) for tracking on Jira.

## When to Use

- Push test results to Xray
- Import Playwright/JUnit/Allure results to Jira
- Validate Xray authentication

## Prerequisites

### 1. Install Dependencies
```bash
cd scripts/integrations && npm install
```

### 2. Configure .env
Ensure Xray credentials in `.env`:

| Variable | Description | Required |
|----------|------------|----------|
| `XRAY_PLATFORM` | `cloud` or `server` | Default: cloud |
| `XRAY_CLIENT_ID` | Xray API Client ID | Yes (Cloud) |
| `XRAY_CLIENT_SECRET` | Xray API Client Secret | Yes (Cloud) |
| `JIRA_PAT` | Personal Access Token | Yes (Server) |

## Process

### 1. Check Prerequisites
- Verify `.env` has Xray credentials
- Verify dependencies installed

### 2. Verify Xray Auth
```bash
node scripts/integrations/jira/xray_auth.js --verify
```

### 3. Identify Report Type
- **Playwright JSON:** `--format playwright --file <path>`
- **JUnit XML:** `--format junit --file <path>`
- **Xray JSON:** `--format xray --file <path>`

### 4. Execute Import
```bash
# Playwright report
node scripts/integrations/jira/xray_importer.js --format playwright --file ./test-results.json --project PROJ

# JUnit XML
node scripts/integrations/jira/xray_importer.js --format junit --file ./junit-results.xml --project PROJ

# Xray JSON
node scripts/integrations/jira/xray_importer.js --format xray --file ./xray-payload.json
```

### 5. Handle Results
- Success: Display Test Execution Key created on Jira
- Failure: Read log → analyze → fix → retry

## Important Notes

- **Test Key Convention:** Include Jira key in test title for auto-mapping:
  ```typescript
  test('[PROJ-123] Login should work', async ({ page }) => { ... });
  ```
- **Xray Cloud auth** is separate from Jira auth (Client ID + Secret)
- **Rate limiting** applies — avoid rapid consecutive imports
- **Security:** NEVER commit `.env` to git

## Supported Formats

| Format | File Extension | Command Flag |
|--------|---------------|-------------|
| Playwright JSON | `.json` | `--format playwright` |
| JUnit XML | `.xml` | `--format junit` |
| Xray JSON | `.json` | `--format xray` |

## Error Handling

| Error | Cause | Solution |
|-------|-------|---------|
| Auth failed | Wrong credentials | Check `XRAY_CLIENT_ID`/`XRAY_CLIENT_SECRET` |
| Format error | Wrong report format | Verify file matches `--format` flag |
| Rate limit | Too many requests | Wait and retry |
