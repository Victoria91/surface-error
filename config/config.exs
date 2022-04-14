# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

# Configures the endpoint
config :surface_error, SurfaceErrorWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "P6EOggsYk/Cr1KL/ZwFfQXFzM6glvrXU9MhkGEOnQw4PfSxCrnfM2y7p5Nh2eej9",
  render_errors: [view: SurfaceErrorWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: SurfaceError.PubSub,
  live_view: [signing_salt: "NQPwxi1/"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.14.11",
  default: [
    args: ~w(
      js/app.js
      --bundle
      --define:global=window
      --define:SURFACE_ERROR_GOOGLE_MAPS_FRONTEND_KEY='#{System.get_env("SURFACE_ERROR_GOOGLE_MAPS_FRONTEND_KEY", "")}'
      --target=es2017
      --outdir=../priv/static/assets
      --external:/fonts/*
      --external:/images/*
      --external:/favicons/*
    ),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

config :tailwind,
  version: "3.0.15",
  default: [
    args: ~w(
      --postcss
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]

config :surface, :components, [
  {Surface.Components.Form.ErrorTag,
   default_translator: {SurfaceErrorWeb.ErrorHelpers, :translate_error},
   default_class: "error-message"}
]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
