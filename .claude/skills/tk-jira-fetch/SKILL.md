---
name: Jira Requirements Fetcher
description: Fetch requirements, user stories, and epics from Jira. Supports single issue, project-wide, JQL queries, and Markdown export. Uses scripts/integrations/jira/.
---

# Jira Requirements Fetcher

## Description

Fetch requirements, user stories, and issues from Jira and convert to documentation for test automation.

## When to Use

- Fetch requirements from Jira
- Export Jira issues to Markdown
- Get Epic children as requirement document
- Import user stories from Jira for test case generation

## Prerequisites

### 1. Install Dependencies
```bash
cd scripts/integrations && npm install
```

### 2. Configure .env
Copy `.env.example` to `.env` at project root and fill in:

| Variable | Description | Required |
|----------|------------|----------|
| `JIRA_BASE_URL` | Jira instance URL (e.g., `https://domain.atlassian.net`) | Yes |
| `JIRA_EMAIL` | Jira account email (Cloud) | Yes (Cloud) |
| `JIRA_API_TOKEN` | API Token (Cloud) | Yes (Cloud) |
| `JIRA_PAT` | Personal Access Token (Server/DC) | Yes (Server) |
| `JIRA_PROJECT_KEY` | Default project key | Recommended |

## Commands

Use `Bash` tool to execute:

```bash
# Single issue
node scripts/integrations/jira/jira_fetcher.js --issue PROJ-123

# Project-wide
node scripts/integrations/jira/jira_fetcher.js --project PROJ --type Story --max 20

# JQL query
node scripts/integrations/jira/jira_fetcher.js --jql "project = PROJ AND status = 'To Do'"

# Markdown export
node scripts/integrations/jira/jira_fetcher.js --issue PROJ-123 --format md

# Epic children
node scripts/integrations/jira/jira_fetcher.js --epic PROJ-10 --format md
```

## Process

1. **Check prerequisites** — Verify `.env` exists and dependencies installed
2. **Determine fetch scope** — Ask user for issue key, project key, JQL, or epic key
3. **Execute script** via `Bash`
4. **Read output** — `Read` the generated file
5. **Present to user** — Format and display results in Vietnamese

## Error Handling

| Error | Cause | Solution |
|-------|-------|---------|
| HTTP 401 | Wrong token/password | Check `JIRA_API_TOKEN` or `JIRA_PAT` |
| HTTP 403 | No permission | Check Jira project permissions |
| HTTP 404 | Wrong URL or issue doesn't exist | Check `JIRA_BASE_URL` and issue key |
| `ENOTFOUND` | DNS cannot resolve | Check `JIRA_BASE_URL` domain |
| `ECONNREFUSED` | Server not running | Check if Jira Server is online |
| File .env not found | .env not created | Copy `.env.example` → `.env` |

## Output

- Formatted requirement data (Markdown or JSON)
- Saved to `requirements/jira/` directory (or `--output` specified path)
