# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :job_offers_api,
  ecto_repos: [JobOffersApi.Repo]

# Configures the endpoint
config :job_offers_api, JobOffersApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "o+edCt4NScyjwWbaPtSF+vVRbZ4bxzgNJDqXnUL4AmdBR0a946kHYH21VfLrQfC+",
  render_errors: [view: JobOffersApiWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: JobOffersApi.PubSub,
  live_view: [signing_salt: "CVlWalzk"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
