import { test, expect } from "@playwright/test";
import { faker } from "@faker-js/faker";

test.beforeEach(async ({ page }) => {
  await page.goto("/");
});

test.describe("Dashboard", () => {
  test("should allow me to create a new team", async ({ page }) => {
    await page.locator('.btn:has-text("Create a new team")').click();
    await expect(page).toHaveURL(/teams\/new/);
    await page.locator("#team_name").fill(faker.vehicle.vehicle());
  });
});
