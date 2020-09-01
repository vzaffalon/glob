# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :glob,
  ecto_repos: [Glob.Repo]

# Configures the endpoint
config :glob, GlobWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "xY7ZBr15pr46PdVfT3p2GRuORc+Qbx+CVFkNPGv1+qlv+2wowURlNfU2rJa1tsFR",
  render_errors: [view: GlobWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Glob.PubSub,
  live_view: [signing_salt: "uMjM0Upv"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
