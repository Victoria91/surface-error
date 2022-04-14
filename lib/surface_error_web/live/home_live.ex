defmodule SurfaceErrorWeb.HomeLive do
  @moduledoc """
  Homepage for a signed-in user
  """

  use SurfaceErrorWeb, :surface_live_view

  @impl true
  def mount(_params, _session, socket) do
    socket = Surface.init(socket)

    {:ok, socket}
  end
end
