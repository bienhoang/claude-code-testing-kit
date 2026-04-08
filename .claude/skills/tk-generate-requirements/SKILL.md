---
name: Requirements Generator
description: Analyze a website or web module and generate structured requirement documents in Vietnamese. Inspects DOM, forms, flows, and business rules.
---

# Requirements Generator

## Description

Analyze a web module's UI and generate a structured requirements document. Inspects DOM, forms, user flows, and business rules to produce professional documentation.

## When to Use

- Generate requirements from a website URL
- Analyze a web module for testing
- Extract user stories from web page
- Create field specification documents

## Process

### 1. Information Gathering
- Ask user for: URL, module name, login credentials (if needed)
- Clarify scope: full page or specific module/section

### 2. System Recon
- Use **Playwright MCP** (if available) to open browser and inspect page
- Fallback: use `WebFetch` to fetch page content
- Set viewport to 1920x1080
- Capture page structure and key elements

### 3. UI & Interaction Analysis
- **Layout Analysis:** Identify Header, Footer, Sidebar, Main Content
- **Form & Inputs:** Find all `input`, `select`, `textarea` elements. Note `type`, `required`, `maxlength`, `minlength`, `pattern` attributes
- **Buttons/Actions:** Identify Save, Submit, Cancel, Delete, Edit functions. Note alerts, toasts, validation messages on error
- **Workflows:** Identify dependencies (e.g., Submit only enabled after checkbox checked)

### 4. Draft Requirements
Generate document with these sections:

#### 4.1 Overview
Brief description of the feature/module and its purpose.

#### 4.2 Functional Requirements
Organized as User Stories or Use Cases:
- Feature name (e.g., Login Function)
- Description: "As a user, I want to... so that..."
- Acceptance Criteria: specific conditions to satisfy

#### 4.3 Field Specifications
Markdown table listing:
- Field Name (Label)
- UI Type (text, dropdown, checkbox...)
- Validation Rules (required, default, length limits)
- Notes

#### 4.4 Business Rules & Validations
Detailed list of expected validation messages for invalid inputs.

### 5. Review & Delivery
- Output in **Vietnamese**, **Markdown** format
- Save via `Write` tool to appropriate location
- If uncertain about business logic, list in "Questions for PO/User" section

## Rules

- Always write in **Vietnamese**
- Do not infer complex business requirements without UI evidence — list unknowns as questions
- When Playwright MCP is available, prefer opening real browser for screenshot/capture
- Fallback to `WebFetch` if Playwright MCP unavailable
