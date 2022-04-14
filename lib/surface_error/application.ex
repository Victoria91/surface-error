defmodule SurfaceError.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  # alias SurfaceError.Billing.{SynchronizePlans, SynchronizeProducts}

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the PubSub system
      {Phoenix.PubSub, name: SurfaceError.PubSub},
      # Start the Endpoint (http/https)
      SurfaceErrorWeb.Endpoint
      # Start a worker by calling: SurfaceError.Worker.start_link(arg)
      # {SurfaceError.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SurfaceError.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    SurfaceErrorWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  # Conditionally disable queues or plugins here.
end
