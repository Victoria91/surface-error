defmodule SurfaceErrorWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :surface_error

  # The session will be stored in the cookie and signed,
  # this means its contents can be read but not tampered with.
  # Set :encryption_salt if you would also like to encrypt it.
  @session_options [
    store: :cookie,
    key: "_surface_error_key",
    signing_salt: "U8A2ImW1"
  ]

  socket("/live", Phoenix.LiveView.Socket,
    websocket: [connect_info: [:x_headers, :user_agent, :peer_data, session: @session_options]]
  )

  socket "/socket", SurfaceErrorWeb.AnonymousUserSocket,
    websocket: true,
    longpoll: false

  # Serve at "/" the static files from "priv/static" directory.
  #
  # You should set gzip to true if you are running phx.digest
  # when deploying your static files in production.
  plug(Plug.Static,
    at: "/",
    from: :surface_error,
    gzip: false,
    only: ~w(
      assets
      fonts
      images
      uploads
      favicons
      favicon.ico
      robots.txt
      browserconfig.xml
      site.webmanifest
      apple-touch-icon-precomposed.png
      apple-touch-icon.png
    ),
    headers: [{"access-control-allow-origin", "*"}]
  )

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    socket("/phoenix/live_reload/socket", Phoenix.LiveReloader.Socket)
    plug(Phoenix.LiveReloader)
    plug(Phoenix.CodeReloader)
  end

  # plug(SurfaceErrorWeb.Plug.BodyParser,
  #   parsers: [:urlencoded, :multipart, :json],
  #   pass: ["*/*"],
  #   json_decoder: Phoenix.json_library()
  # )

  plug(Plug.MethodOverride)
  plug(Plug.Head)
  # One-line request logging. Must come before the session & router plugs.
  plug(Plug.Session, @session_options)
  plug(SurfaceErrorWeb.Router)
end
