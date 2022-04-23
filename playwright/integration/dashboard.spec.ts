import { test, expect } from "@playwright/test";
import { faker } from "@faker-js/faker";

test.beforeEach(async ({ page }) => {
  await page.goto("/");
});

test.describe("Dashboard", () => {
  test("should allow me to create a new team", async ({ page }) => {
    await page.locator('.btn:has-text("Create a new team")').first().click();
    await expect(page).toHaveURL(/teams\/new/);
    const name = faker.vehicle.vehicle();
    await page.locator("#team_name").fill(name);
    const checkbox =
      "input[type='checkbox'][name='team[driver_ids][]'] + .form-icon";
    await page.locator(`:nth-match(${checkbox}, 1)`).click();
    await page.locator(`:nth-match(${checkbox}, 2)`).click();
    await page.locator(`:nth-match(${checkbox}, 3)`).click();
    await page.locator(`:nth-match(${checkbox}, 4)`).click();
    await page.locator(`:nth-match(${checkbox}, 5)`).click();
    await page.locator("input[type='submit']").click();
    await expect(page).toHaveURL(/teams\/.*/);
    await expect(page.locator(".title")).toHaveText(name);
    await expect(page.locator(".driver")).toHaveCount(5);
  });
});
