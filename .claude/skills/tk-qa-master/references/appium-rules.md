# Appium Mobile Automation Rules

> Applies when automating mobile applications with Java and Appium.

## 1. Locator Priority

Use native platform-specific locator strategy (iOS / Android) instead of web equivalents:

1. `accessibility id` — Cross-platform, most stable
2. `resource-id` (Android) — Native Android attribute
3. `id` — General ID
4. `iOS predicate string` (iOS) — Fast, iOS-specific
5. `iOS class chain` (iOS) — iOS structure query
6. `xpath` — Last resort (slowest)

Correct:
```java
// Accessibility id — Cross-platform, always preferred
driver.findElement(AppiumBy.accessibilityId("login_button"));

// Android — resource-id
driver.findElement(AppiumBy.id("com.application.xyz:id/login_button"));

// iOS — Predicate String (fast)
driver.findElement(AppiumBy.iOSNsPredicateString("label == 'Login'"));

// iOS — Class Chain
driver.findElement(AppiumBy.iOSClassChain(
    "**/XCUIElementTypeButton[`label == 'Login'`]"
));
```

## 2. FORBIDDEN

- Absolute positional XPath — any small layout change causes failure:
  ```java
  // FORBIDDEN:
  driver.findElement(By.xpath(
      "//android.widget.FrameLayout[1]/android.widget.LinearLayout[2]/android.widget.Button[1]"
  ));
  ```
- Querying off-screen elements without scrolling first
- Interacting with disabled elements without checking state
- Hardcoding animation wait times

## 3. Wait Strategy

**FORBIDDEN:**
- `Thread.sleep()` — In all cases

**USE:**
- Explicit Waits with `WebDriverWait`:
  ```java
  WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(15));

  // Wait for element visible
  wait.until(ExpectedConditions.visibilityOfElementLocated(
      AppiumBy.accessibilityId("welcome_text")
  ));

  // Wait for element clickable
  wait.until(ExpectedConditions.elementToBeClickable(
      AppiumBy.accessibilityId("submit_button")
  ));
  ```

- Scroll to element:
  ```java
  // Android — UiScrollable
  driver.findElement(AppiumBy.androidUIAutomator(
      "new UiScrollable(new UiSelector().scrollable(true))" +
      ".scrollIntoView(new UiSelector().text(\"Submit\"))"
  ));
  ```

## 4. Test Structure (TestNG)

```java
public class LoginMobileTest extends BaseTest {

    @BeforeMethod
    public void setUp() {
        // Initialize driver, capabilities...
    }

    @Test(groups = {"mobile", "regression"})
    public void testLoginSuccess() {
        // Arrange
        LoginScreen loginScreen = new LoginScreen(driver);
        String email = DataGenerator.generateEmail("loginMobile");

        // Act
        loginScreen.login(email, "ValidPass@123");

        // Assert
        HomeScreen homeScreen = new HomeScreen(driver);
        Assert.assertTrue(homeScreen.isWelcomeDisplayed(),
            "Home screen should display after login");
    }
}
```

Notes:
- Mobile uses **Screen Objects** (equivalent to Page Objects) — suffix `Screen`
- Example: `LoginScreen.java`, `HomeScreen.java`, `SettingsScreen.java`

## 5. Mobile-Specific Testing

- **Screen rotation:** Test both portrait and landscape if app supports:
  ```java
  driver.rotate(ScreenOrientation.LANDSCAPE);
  ```
- **Background/Foreground:** Test app after moving to background and returning:
  ```java
  driver.runAppInBackground(Duration.ofSeconds(5));
  ```
- **Push Notification:** Verify notifications via Appium notification listener
- **Permission Dialog:** Handle permission dialogs (camera, location...):
  ```java
  // Android — Auto-grant permissions in capabilities
  capabilities.setCapability("autoGrantPermissions", true);
  ```
