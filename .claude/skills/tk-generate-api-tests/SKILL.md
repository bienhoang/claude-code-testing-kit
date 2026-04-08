---
name: API Test Generator
description: Generate API test cases and REST Assured automation tests from Swagger/OpenAPI specifications. Validates status codes, response body, error scenarios.
---

# API Test Generator

## Description

Generate API test cases and REST Assured (Java) automation tests from Swagger/OpenAPI specifications. Covers success, validation errors, auth errors, and edge cases.

## When to Use

- API testing from Swagger/OpenAPI spec
- REST Assured test generation
- User provides Swagger URL or spec file

## Process

### 1. Read Swagger Spec
- `WebFetch` Swagger URL or `Read` local spec file
- Parse endpoints, methods, parameters, request/response schemas

### 2. Analyze Endpoints
- List all endpoints with HTTP method, path, parameters
- Identify required vs optional parameters
- Note authentication requirements

### 3. Generate Test Scenarios
For each endpoint, generate scenarios:

| Category | Status | Description |
|----------|--------|------------|
| Success | 200/201 | Valid request, correct response |
| Validation | 400 | Missing required fields, invalid format |
| Auth | 401 | Missing or invalid token |
| Forbidden | 403 | Insufficient permissions |
| Not Found | 404 | Non-existent resource |
| Edge Cases | Various | Boundary values, special characters |

### 4. Generate REST Assured Tests

```java
@Test
public void testGetUserSuccess() {
    given()
        .header("Authorization", "Bearer " + token)
        .pathParam("id", validUserId)
    .when()
        .get("/api/users/{id}")
    .then()
        .statusCode(200)
        .body("id", equalTo(validUserId))
        .body("email", notNullValue());
}
```

### 5. Validations per Test
- HTTP status code
- Response body fields (type, value, presence)
- Error messages
- Response headers (Content-Type, etc.)
- Response time (optional)

## Output

1. **API Test Cases Table** — Markdown table with endpoint, scenario, expected status, description
2. **REST Assured Java Test Classes** — Organized by endpoint/module

## Framework

- **Language:** Java
- **Library:** REST Assured
- **Test Runner:** TestNG
- **Assertions:** Hamcrest matchers + TestNG Assert
