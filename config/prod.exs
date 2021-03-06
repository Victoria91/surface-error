import Config

# For production, don't forget to configure the url host
# to something meaningful, Phoenix uses this information
# when generating URLs.
#
# Note we also include the path to a cache manifest
# containing the digested version of static files. This
# manifest is generated by the `mix phx.digest` task,
# which you should run after static files are built and
# before starting your production server.
# Ref: https://gigalixir.readthedocs.io/en/latest/domain.html#how-to-set-up-ssl-tls
# Ref: https://shift.infinite.red/how-to-set-up-a-cdn-iqn-phoenix-af89074e0a62
config :surface_error, SurfaceError.Endpoint,
  url: [host: System.get_env("SURFACE_ERROR_HOSTNAME"), scheme: "https", port: 443],
  static_url: [scheme: "https", host: System.get_env("SURFACE_ERROR_CDN_HOSTNAME"), port: 443],
  force_ssl: [rewrite_on: [:x_forwarded_host, :x_forwarded_port, :x_forwarded_proto]],
  cache_static_manifest: "priv/static/cache_manifest.json"

# Do not print debug messages in production
config :logger, level: :info
