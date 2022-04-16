const shell = require("shelljs");

export default function () {
  if (
    shell.exec("pushd .. && RAILS_ENV=test ./bin/rails db:reset").code !== 0
  ) {
    shell.echo("Error: Database reset failed");
    shell.exit(1);
  }
}
