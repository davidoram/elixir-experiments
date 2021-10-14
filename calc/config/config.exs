# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

# Configures the endpoint
config :calc, CalcWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: CalcWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Calc.PubSub,
  live_view: [signing_salt: "UHiqu6Om"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:erl_level,
            # :file, :function, :line,
            :x_interaction_id,
            :request_id, :http_status, :http_response]    # Decide what metadata to include on each log line
                                                          # Configure Filebeat / Logstash to parse elixir style logs

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
