# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :msgui, MsguiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "knEajb0W9GzRyvDzIYRj6yDvyqI+VbqvptVKRdHVd+k/PGlymTEmgJb8BoRPl+AV",
  render_errors: [view: MsguiWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Msgui.PubSub,
  live_view: [signing_salt: "C+FAOtMo"]

config :msgui,
  examples_dir: "../sc_em/examples",
  initial_circuit: "fat-saw-reverb.json"

config :sc_em,
  #port: 57110,
  port: String.to_integer(System.fetch_env!("SC_PORT")),
  ip: String.split(System.fetch_env!("SC_IP"), ".") |> Enum.map(&(String.to_integer(&1))) |> List.to_tuple,
  remote_synth_dir: System.fetch_env!("MODSYNTH_REMOTE_DIR"),
  local_synth_dir: System.fetch_env!("MODSYNTH_LOCAL_DIR")

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
