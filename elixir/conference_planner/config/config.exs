# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :conference_planner,
  ecto_repos: [ConferencePlanner.Repo]

config :conference_planner, ConferencePlanner.Repo,
  username: "postgres",
  password: "postgres",
  database: "ConferencePlanner",
  hostname: "localhost",
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

# Configures the endpoint
config :conference_planner, ConferencePlannerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "MxVVIxRqAac5XmgzAQufWOTjmmmX0+E8HPj+IIrFGpIWYScJwJ3Dkb2I6Kffp/AZ",
  render_errors: [view: ConferencePlannerWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: ConferencePlanner.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
