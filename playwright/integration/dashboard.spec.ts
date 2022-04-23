import { test, expect, Page } from "@playwright/test";
import { faker } from "@faker-js/faker";

test.beforeEach(async ({ page }) => {
  await page.goto("/");
});

async function createTeam(page: Page): Promise<null | string> {
  const createBtn = page.locator("data-testid=create-team");
  if ((await createBtn.count()) === 0) {
    return await page.locator("data-testid=team-name").textContent();
  }
  await createBtn.click();
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
  return name;
}

test.describe("Dashboard", () => {
  test("should allow me to create a new team", async ({ page }) => {
    const name = await createTeam(page);
    await expect(page).toHaveURL(/teams\/.*/);
    await expect(page.locator(".title")).toHaveText(name);
    await expect(page.locator(".driver")).toHaveCount(5);
  });

  test("should allow me to create a league", async ({ page }) => {
    await createTeam(page);
    await page.goto("/");
    await page.locator('.btn:has-text("Create a league")').first().click();
    await expect(page).toHaveURL(/leagues\/new/);
    const name = `${faker.word.adjective()} ${faker.word.noun()}`;
    await page.locator("#league_name").fill(name);
    await page.locator("input[type='submit']").click();
    await expect(page).toHaveURL(/leagues\/\d+/);
    await expect(page.locator(".toast")).toContainText("creating a league");
    await expect(page.locator("data-testid=league-name")).toHaveText(name);
  });
});
