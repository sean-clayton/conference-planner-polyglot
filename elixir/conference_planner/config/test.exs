use Mix.Config

# Configure your database
config :conference_planner, ConferencePlanner.Repo,
  username: "postgres",
  password: "postgres",
  database: "conference_planner_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :conference_planner, ConferencePlannerWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
