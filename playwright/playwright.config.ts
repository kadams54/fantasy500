import { devices, PlaywrightTestConfig } from "@playwright/test";

const config: PlaywrightTestConfig = {
  expect: { timeout: 5000 },
  forbidOnly: !!process.env.CI,
  globalSetup: "setup.ts",
  globalTeardown: "teardown.ts",
  projects: [
    {
      name: "chromium",
      use: { ...devices["Desktop Chrome"] },
    },
    {
      name: "firefox",
      use: { ...devices["Desktop Firefox"] },
    },
    {
      name: "webkit",
      use: { ...devices["Desktop Safari"] },
    },
  ],
  retries: process.env.CI ? 2 : 1,
  testDir: "./integration",
  timeout: 5 * 1000,
  use: {
    actionTimeout: 0,
    baseURL: "http://localhost:3000",
    storageState: "storageState.json",
    trace: "retain-on-failure",
  },
  webServer: {
    command: "pushd .. && RAILS_ENV=test ./bin/rails s",
    port: 3000,
  },
  workers: process.env.CI ? 1 : undefined,
};

export default config;
