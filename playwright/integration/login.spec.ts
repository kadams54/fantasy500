import { test, expect } from "@playwright/test";

test.describe.parallel("Unauthenticated Login", () => {
  test.use({ storageState: "./storage/guest.json" });

  test("can view as guest", async ({ page, context }) => {
    await page.goto("/login");
    await expect(page.locator("data-testid=header")).toHaveText("Log In");
  });
});

test.describe.parallel("Authenticated Login", () => {
  test.use({ storageState: "./storage/guest.json" });

  test("can login as admin", async ({ page, context }) => {
    await page.goto("/login");
    await page.fill("data-testid=email", "admin@example.com");
    await page.fill("data-testid=password", "1password");
    await page.click("data-testid=submit");
    await page.goto("/welcome/dashboard");
    await expect(page.locator("data-testid=nav")).toContainText("Dashboard");
    await expect(page.locator("data-testid=current-user-name")).toHaveText(
      "Administrator"
    );
  });

  test("can login as standard user", async ({ page, context }) => {
    await page.goto("/login");
    await page.fill("data-testid=email", "user@example.com");
    await page.fill("data-testid=password", "2password");
    await page.click("data-testid=submit");
    await page.goto("/welcome/dashboard");
    await expect(page.locator("data-testid=nav")).toContainText("Dashboard");
    await expect(page.locator("data-testid=current-user-name")).toHaveText(
      "User"
    );
  });

  test("can NOT login as inactive user", async ({ page }) => {
    await page.goto("/login");
    await page.fill("data-testid=email", "inactive_user@example.com");
    await page.fill("data-testid=password", "3password");
    await page.click("data-testid=submit");
    await expect(page.locator("data-testid=flashes")).toContainText(
      "Account not activated"
    );
  });

  test("can login as commissioner", async ({ page, context }) => {
    await page.goto("/login");
    await page.fill("data-testid=email", "commish@example.com");
    await page.fill("data-testid=password", "4password");
    await page.click("data-testid=submit");
    await page.goto("/welcome/dashboard");
    await expect(page.locator("data-testid=nav")).toContainText("Dashboard");
    await expect(page.locator("data-testid=current-user-name")).toHaveText(
      "Commish"
    );
  });
});
