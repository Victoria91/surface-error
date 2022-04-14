defmodule SurfaceErrorWeb.Router do
  use SurfaceErrorWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_live_flash)
    plug(:put_root_layout, {SurfaceErrorWeb.LayoutView, :root})
    plug(:protect_from_forgery)

    # sobelow_skip ["Config.CSP"]
    plug(:put_secure_browser_headers)

    if Mix.env() == :int_test do
      forward("/int-test", SurfaceError.Util.IntTest)
    end
  end

  pipeline :image_auth do
    plug(:accepts, ["png"])
    plug(:fetch_session)
    plug(:protect_from_forgery)
  end

  pipeline :webhook do
    plug(:accepts, ["json"])
  end

  pipeline :sns_webhook do
    # Amazon SNS sends a JSON body but a "text/plain" content-type header,
    # so force decoding of the body as JSON
    plug(SurfaceErrorWeb.Plug.ForceJSON)
    plug(Plug.Parsers, parsers: [:json], json_decoder: Jason)
  end

  pipeline :unauthenticated do
  end

  scope "/webhooks/stripe", SurfaceErrorWeb do
    pipe_through(:webhook)

    post("/", StripeWebhookController, :create)
  end

  if Enum.member?([:int_test, :dev], Mix.env()) do
    scope "/", SurfaceErrorWeb do
      pipe_through(:browser)
    end
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).

  scope "/", SurfaceErrorWeb do
    pipe_through([:browser])

    live_session :admin do
      live("/", HomeLive, :index)
      # live("/admin/user_stats", UserStatsLive, :index)
      # live("/admin/user_impersonation", UserImpersonationLive, :index)
    end
  end
end
