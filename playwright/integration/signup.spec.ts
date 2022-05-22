import { test, expect } from "@playwright/test";
import { faker } from "@faker-js/faker";

test.beforeEach(async ({ page }) => {
  await page.goto("/signup");
});

test.describe("Sign Up", () => {
  test.use({ storageState: "./storage/guest.json" });

  test("should allow me to create a new account", async ({
    page,
    browserName,
  }) => {
    const firstName = faker.name.firstName();
    const lastName = faker.name.lastName();
    await page.locator("data-testid=name").fill(`${firstName} ${lastName}`);
    // Use the browser name to eliminate race condition on unique emails.
    const email = faker.unique(faker.internet.email, [
      firstName,
      lastName,
      `${browserName}.com`,
    ]);
    await page.locator("data-testid=email").fill(email);
    const password = faker.internet.password();
    await page.locator("data-testid=password").fill(password);
    await page.locator("data-testid=password-confirmation").fill(password);
    await page.locator("data-testid=submit").click();
    await expect(page).toHaveURL(/\//);
    await expect(page.locator("data-testid=flashes")).toContainText(
      "email to activate"
    );
  });

  test("should error when the passwords don't match", async ({ page }) => {
    await page.locator("#user_name").fill(faker.name.findName());
    await page.locator("#user_email").fill(faker.internet.email());
    await page.locator("#user_password").fill(faker.internet.password());
    await page
      .locator("#user_password_confirmation")
      .fill(faker.internet.password());
    await page.locator("[type=submit]").click();
    await expect(page).toHaveURL(/signup/);
    await expect(page.locator(".toast-error")).toHaveText(
      /Password confirmation doesn't match/
    );
  });

  test("should error when the password is too short", async ({ page }) => {
    await page.locator("#user_name").fill(faker.name.findName());
    await page.locator("#user_email").fill(faker.internet.email());
    const tooShortPassword = "foo1";
    await page.locator("#user_password").fill(tooShortPassword);
    await page.locator("#user_password_confirmation").fill(tooShortPassword);
    await page.locator("[type=submit]").click();
    await expect(page).toHaveURL(/signup/);
    await expect(page.locator(".toast-error")).toHaveText(
      /Password is too short/
    );
  });

  test("should error when required fields are not filled", async ({ page }) => {
    await page.locator("[type=submit]").click();
    await expect(page).toHaveURL(/signup/);
    await expect(page.locator(".toast-error")).toHaveText(
      /Name can't be blank/
    );
    await expect(page.locator(".toast-error")).toHaveText(
      /Email can't be blank/
    );
    await expect(page.locator(".toast-error")).toHaveText(
      /Password can't be blank/
    );
  });
});
