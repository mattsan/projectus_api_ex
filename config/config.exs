# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :projectus_api,
  ecto_repos: [ProjectusApi.Repo]

# Configures the endpoint
config :projectus_api, ProjectusApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "UiMn4h4cF+1gIddhKdepzu9S5WUZXhUmsiTXUQGZERdXfnWpLEP6PTuE6FtZDXqB",
  render_errors: [view: ProjectusApiWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: ProjectusApi.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
