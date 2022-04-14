import { test, expect, Page } from "@playwright/test";
import { faker } from "@faker-js/faker";

test.beforeEach(async ({ page }) => {
  await page.goto("/signup");
});

test.describe("Sign Up", () => {
  test("should allow me to create a new account", async ({ page }) => {
    await page.locator("#user_name").fill(faker.name.findName());
    await page.locator("#user_email").fill(faker.internet.email());
    const password = faker.internet.password();
    await page.locator("#user_password").fill(password);
    await page.locator("#user_password_confirmation").fill(password);
    await page.locator("[type=submit]").click();
    await expect(page).toHaveURL(/\//);
    await expect(page.locator(".flashes")).toHaveText(/email to activate/);
  });
});
