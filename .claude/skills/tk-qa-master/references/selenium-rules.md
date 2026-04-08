# Selenium WebDriver Rules

> Applies when automating browsers with Java and Selenium WebDriver.

## 1. Locator Priority

Strictly follow this order for speed and stability:

1. `id` — Fastest, most unique
2. `data-testid` / `data-test` / `data-qa` — Test-specific attributes
3. `name` — Standard HTML attribute
4. `cssSelector` — Flexible, fast
5. `xpath` — Last resort

Correct:
```java
driver.findElement(By.id("login-btn"));
driver.findElement(By.cssSelector("button[data-testid='submit-btn']"));
driver.findElement(By.name("username"));
```

Wrong — positional XPath:
```java
// FORBIDDEN: Absolute XPath based on DOM structure
driver.findElement(By.xpath("//div[3]/div[2]/form/div[1]/button"));
```

## 2. Wait Strategy

**FORBIDDEN:**
- `Thread.sleep()` — In all cases
- Any fixed-time wait

**USE:**
- Java Explicit Waits with `WebDriverWait` + `ExpectedConditions`:

```java
WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10));

// Wait for element visible
WebElement element = wait.until(
    ExpectedConditions.visibilityOfElementLocated(By.id("profile"))
);

// Wait for element clickable
wait.until(ExpectedConditions.elementToBeClickable(By.id("submit-btn")));

// Wait for text present
wait.until(ExpectedConditions.textToBePresentInElementLocated(
    By.id("message"), "Success"
));

// Wait for URL redirect
wait.until(ExpectedConditions.urlContains("/dashboard"));
```

- Custom `FluentWait` for flexible polling:
```java
Wait<WebDriver> fluentWait = new FluentWait<>(driver)
    .withTimeout(Duration.ofSeconds(15))
    .pollingEvery(Duration.ofMillis(500))
    .ignoring(NoSuchElementException.class);
```

## 3. Browser Setup

- **Viewport:** Set desktop viewport (`1920x1080`) for debugging:
  ```java
  driver.manage().window().setSize(new Dimension(1920, 1080));
  ```
- **Headed mode:** Required for debugging (no `--headless`)
- **Headless mode:** Only when tests PASS on headed or in CI/CD

## 4. Test Structure (TestNG)

```java
public class LoginTest extends BaseTest {

    @BeforeMethod
    public void setUp() {
        // Navigate, setup data...
    }

    @Test(groups = {"smoke", "regression"})
    public void testLoginWithValidCredentials() {
        // Arrange
        LoginPage loginPage = new LoginPage(driver);
        String email = DataGenerator.generateEmail("login");

        // Act
        loginPage.login(email, "ValidPass@123");

        // Assert
        DashboardPage dashboard = new DashboardPage(driver);
        Assert.assertTrue(dashboard.isDisplayed(),
            "Dashboard should display after successful login");
    }

    @AfterMethod
    public void tearDown() {
        // Cleanup...
    }
}
```

## 5. Assertions

- Use TestNG Assertions (`Assert.assertEquals`, `Assert.assertTrue`...)
- Always add **descriptive message** to assertions:
  ```java
  Assert.assertEquals(actualTitle, "Dashboard", "Page title should be Dashboard");
  Assert.assertTrue(element.isDisplayed(), "Element should be visible on page");
  ```
- Every test method must have at least **1 assertion** at the end
