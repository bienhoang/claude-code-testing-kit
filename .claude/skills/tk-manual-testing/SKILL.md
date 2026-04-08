---
name: Manual Test Case Generator
description: Generate manual test cases with 2 modes — QUICK (fast from requirements) and FULL RBT (6-step AI-RBT with risk assessment). Supports EP, BVA, Decision Table, State Transition techniques.
---

# Manual Test Case Generator

## Description

Master skill for manual test case generation. Provides **2 modes** to fit any scope:

| Mode | When to Use | Duration |
|------|------------|----------|
| **QUICK** | Simple module, clear requirements, need TCs fast | 1 pass (no wait) |
| **FULL RBT** | Complex module, risk analysis needed, large system | 6 sequential steps (with checkpoints) |

**Core principles:**
- **Human Strategy:** Humans define strategy, risk levels, and standards
- **AI Execution:** AI performs analysis, writes TCs, and identifies gaps
- **Human Verification:** Humans review results before finalizing

## When to Use

- Generate manual test cases from requirements / user stories
- Analyze requirements to detect ambiguity
- Decompose system into modules / features
- Build traceability matrix
- Apply Risk-Based Testing (risk assessment for test cases)
- Standardize test cases to Markdown table (Jira/Excel format)

**Do NOT use when:**
- Need automation code → use `/tk:generate-automation`
- Need DOM inspection / locators → use `/tk:generate-locator`
- Only need test data → use `/tk:generate-test-data`

## Mode Routing

Auto-detect mode based on **trigger keywords** and **context**:

### → QUICK Mode
- User says: "generate test cases fast", "create TCs from this requirement", "write test cases for form..."
- Requirements are clear, small scope (1 module / 1 feature)
- User does not request risk analysis

### → FULL RBT Mode
- User says: "6-step process", "RBT analysis", "comprehensive test cases"
- Large scope (multiple modules, complex system)
- User requests Traceability Matrix or Risk Level assessment
- Requirements unclear, need Ambiguity analysis

### → When Unclear
Ask user using `AskUserQuestion`:
```
Which mode do you want?
1. QUICK — Fast generation from requirements (no analysis steps)
2. FULL RBT — Full 6-step process (analysis → decomposition → RBT → TC generation)
```

---

# Mode QUICK — Fast Test Case Generation

## Process (single pass)

1. **Read and understand requirements** provided
2. **Identify main flows:**
   - Happy Path (main flow)
   - Negative Path (wrong/missing data)
   - Boundary Cases (edge values)
3. **Apply test design techniques:**
   - **Equivalence Partitioning (EP):** Divide input into equivalent groups
   - **Boundary Value Analysis (BVA):** Test at boundaries
   - **Decision Table:** List condition combinations (if multiple rules)
   - **State Transition:** Test state transitions (if workflow exists)
4. **Generate test cases** with all fields:
   - TC ID (format: `[PROJECT]_[MODULE]_TC_[NUM]`)
   - Module, Test Scenario, Pre-conditions
   - Test Steps (numbered), Expected Results (numbered)
   - Test Data (**must be concrete**, no placeholders)
   - Priority (Critical / High / Medium / Low)
5. **Output Markdown table** ready for Excel/Jira

## Output Format

```
| TC ID | Module | Test Scenario | Pre-Condition | Test Steps | Test Data | Expected Result | Priority |
```

## Anti-Patterns (QUICK)
- Generate generic/placeholder test data
- Only Happy Path, missing Negative/Boundary
- Skip validation rules from requirements
- Vague Test Steps ("enter data" → must specify what data, where)

---

# Mode FULL RBT — 6-Step AI-RBT Process

> **IMPORTANT:** Steps run **sequentially**. Do NOT merge multiple steps. Each step must complete and get user confirmation before proceeding.

### Step 1: Context & Role-play
**Purpose:** Establish Senior QA Engineer role and load project context.

1. Ask user to provide: project name, system description, MVP test goals, requirement docs
2. Read documentation thoroughly and confirm understanding
3. Summarize test scope
4. **Wait for user confirmation** before Step 2 — use `AskUserQuestion`

### Step 2: Analysis & QnA
**Purpose:** Analyze documents to find gaps, missing info, contradictions.

1. Identify flows: Happy Path, Alternate Paths, Exception Paths
2. Detect Ambiguities: missing requirements, contradictions, unclear specs
3. Ask numbered Q&A questions (Q1, Q2...) with context and assumptions
4. **STOP — Wait for user answers** — use `AskUserQuestion`

> **Critical checkpoint.** If skipped and agent guesses business logic, test cases will be seriously wrong.

### Step 3: Decomposition
**Purpose:** Break complex features into manageable Modules/Sub-modules.

1. Decompose by UI (Header, Form, Table...) or by Flow (Create, Edit, Delete...)
2. Describe each Module's function briefly
3. Identify Dependencies between Modules

### Step 4: Traceability
**Purpose:** Establish traceability matrix ensuring 100% requirement coverage.

1. Map each Module/Rule to Requirement codes (REQ-01, REQ-02...)
2. Gap Analysis — check for uncovered requirements
3. List High-Level Test Scenarios per Module (Security, UI, Business Logic, Data Integrity, Error Handling)
4. **Wait for user review** — use `AskUserQuestion`

### Step 5: RBT & TC Generation
**Purpose:** Generate detailed test cases with Risk-Based Testing strategy.

1. Assess Risk Level per Module: High (critical business, money, security) / Medium / Low
2. Generate test cases with full fields including Risk Level
3. Cover: Happy Path, Negative Path, Edge Cases
4. Apply EP, BVA, Decision Table, State Transition techniques
5. If too many scenarios → generate per Module, ask user to continue

### Step 6: Template Mapping
**Purpose:** Package test cases into standard Markdown table for Excel/Jira.

```
| TC ID | Module | Risk Level | Test Title | Pre-Condition | Test Steps | Expected Result | Priority | Test Data |
```

- TC ID in unified format (e.g., `CRM_CUST_TC_001`)
- Use `<br>` for line breaks in table cells
- **Do NOT omit** any test case from Step 5
- If too long → split into Part 1, Part 2... ask user to continue
- Output via `Write` tool to file

## Test Data Rules (Both Modes)

```
Bad:  "Enter valid code"
Good: "Enter code: KH-2026-0012"

Bad:  "Enter valid email"
Good: "Enter email: test_customer_01@domain.com"

Bad:  "Enter value exceeding limit"
Good: "Enter 256 characters in Name field (max: 255)"
```

## Prompt Templates

FULL RBT step-by-step templates located at:
```
plans/manual/
├── 01_context_and_roleplay/prompt.txt
├── 02_analysis_and_qna/prompt.txt
├── 03_decomposition/prompt.txt
├── 04_traceability/prompt.txt
├── 05_rbt_and_tc_generation/prompt.txt
└── 06_template_mapping/prompt.txt
```

All output must be in **Vietnamese**, **Markdown** format.
